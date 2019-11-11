+++
title = "Bring your own UI"
chapter = false
weight = 30
+++

Amazon Cognito provides low level API allowing you to implement your custom authentication flows, when needed.  It allows to build your own Signin, Signup, Forgot Password Views or to build your own flows.  Check the available APIs in the [Amplify documentation](https://aws-amplify.github.io/docs/ios/authentication#working-with-the-api).

In this section, we are going to implement our own Login user interface (a custom SwiftUI View) and interact with the `AWSMobileClient.SignIn()` API instead of using the Cognito dropin or hosted UI.

## Add API based signin in Application Delegate

We start by adding a new method in the Application Delegate to sign in through the API instead of using the drop-in or hosted UI.

Add the `signIn()` function in file *Landmarks/AppDelegate.swift* (you can safely copy/paste the whole file below, modified lines are highlighted):

{{< highlight swift "hl_lines=142-159">}}
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application delegate.
*/

import UIKit
import AWSMobileClient
import AWSAppSync
import AWSS3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public let userData = UserData()
    var appSyncClient: AWSAppSyncClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //init appsync
        self.appSyncInit()
        
        AWSMobileClient.default().addUserStateListener(self) { (userState, info) in
            
            // notify our subscriber the value changed
            self.userData.isSignedIn = AWSMobileClient.default().isSignedIn

            switch (userState) {
            case .guest:
                print("user is in guest mode.")
                
            case .signedOut:
                print("user just signed out")
                self.userData.landmarks = []
                
            case .signedIn:
                print("user just signed in.")
                print("username : \(String(describing: AWSMobileClient.default().username))")
                
                print("Loading data")
                self.queryLandmarks()

                AWSMobileClient.default().getUserAttributes(completionHandler: { (attributes, error) in
                    print("error : \(String(describing: error))")
                    print("attributes: \(String(describing: attributes))")
                    print("")
                    
                    AWSMobileClient.default().getTokens({ (tokens, error) in
                        print("error : \(String(describing: error))")
                        print("token : \(String(describing: tokens))")
                        print("")                        
                    })
                })
                                
            case .signedOutUserPoolsTokenInvalid:
                print("need to login again.")

            case .signedOutFederatedTokensInvalid:
                print("user logged in via federation, but currently needs new tokens")

            default:
                print("unsupported")
            }
        }
        
        AWSMobileClient.default().initialize { (userState, error) in

            // notify our subscriber the value changed
            self.userData.isSignedIn = AWSMobileClient.default().isSignedIn
            
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }

        if (self.userData.isSignedIn) {
            print("Loading data")
            self.queryLandmarks()
        }

        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
      
    // MARK: AWSMobileClient - Authentication
    
    public func authenticateWithDropinUI(navigationController : UINavigationController) {
        print("dropinUI()")
        
        // Option to launch sign in directly
        let signinUIOptions = SignInUIOptions(canCancel: false,
                                              logoImage: UIImage(named: "turtlerock"),
                                              backgroundColor: .black)

        AWSMobileClient.default().showSignIn(navigationController: navigationController, signInUIOptions: signinUIOptions, { (signInState, error) in
            if let signInState = signInState {
                print("Sign in flow completed: \(signInState)")
            } else if let error = error {
                print("error logging in: \(error.localizedDescription)")
            }
        })
    }

    public func authenticateWithHostedUI(navigationController : UINavigationController) {
        
        print("hostedUI()")
        // Optionally override the scopes based on the usecase.
        let hostedUIOptions = HostedUIOptions(scopes: ["openid", "email", "profile", "aws.cognito.signin.user.admin"])

        // Present the Hosted UI sign in.
        AWSMobileClient.default().showSignIn(navigationController: navigationController, hostedUIOptions: hostedUIOptions) { (userState, error) in
            if let error = error as? AWSMobileClientError {
                print(error.localizedDescription)
            }
            if let userState = userState {
                print("Status: \(userState.rawValue)")

            }
        }
    }
    
    public func signIn(username: String, password: String) {
        AWSMobileClient.default().signIn(username: username, password: password) { (signInResult, error) in

            if let error = error  {
                print("\(error)")
                // in real life, present an error message to user
            } else if let signInResult = signInResult {
                switch (signInResult.signInState) {
                case .signedIn:
                    print("User is signed in.")
                case .smsMFA:
                    print("SMS message sent to \(signInResult.codeDetails!.destination!)")
                default:
                    print("Sign In needs info which is not et supported.")
                }
            }
        }
    }
    
    public func signOut() {
        AWSMobileClient.default().signOut()
    }
    
    // MARK: AWSAppSync
        
    func appSyncInit() {
        do {
            // You can choose the directory in which AppSync stores its persistent cache databases
            let cacheConfiguration = try AWSAppSyncCacheConfiguration()

            // AppSync configuration & client initialization
            let appSyncServiceConfig = try AWSAppSyncServiceConfig()
            let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncServiceConfig: appSyncServiceConfig,
                                                                  userPoolsAuthProvider: AWSMobileClient.default() as AWSCognitoUserPoolsAuthProvider,
                                                                  cacheConfiguration: cacheConfiguration)
            self.appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            print("Initialized appsync client.")
        } catch {
            print("Error initializing appsync client. \(error)")
        }
    }
    
    func queryLandmarks() {
        print("Query landmarks")
        self.appSyncClient?.fetch(query: ListLandmarksQuery(limit:100), cachePolicy: .fetchIgnoringCacheData) {(result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    return
                }
                print("Landmarks query complete.")
                result?.data?.listLandmarks?.items!.forEach {
                    
                    // convert the AppSync jsonObject (aka Dictionary<String, Any> to Data
                    // the code below assumes there is no casting / nil error
                    // TODO should add guard statement and handle errors
                    // https://nacho4d-nacho4d.blogspot.com/2016/05/dictionary-to-json-string-and-json.html
                    let jsonData = try! JSONSerialization.data(withJSONObject: $0?.jsonObject as Any, options: [])
                    // this allows to create a Landmark object using the Decodable protocol
                    let l : Landmark = try! JSONDecoder().decode(Landmark.self, from: jsonData)
                    self.userData.landmarks.append(l);
                    
                }
            }
    }

    // MARK: AWS S3 & Image Loading

    /**
        Asynchronously load the image from S3.  This method blocks until the S3 download is completed.
        https://stackoverflow.com/questions/42484281/waiting-until-the-task-finishes
     */
    func image(_ imageName : String) -> Data? {
        
        print("Downloading image : \(imageName)")
        
        var result : Data?
        
        let group = DispatchGroup()
        group.enter()
        
        let transferUtility = AWSS3TransferUtility.default()
        transferUtility.downloadData(
            forKey: "public/\(imageName).jpg",
              expression: nil,
              completionHandler: { (task, URL, data, error) -> Void in
                
                if let e = error {
                    print("Can not download image : \(e)")
                } else {
                    print("Image \(imageName) loaded")
                    result = data!
                }
                
                group.leave()
              }
        )
        
        // wait for image to be downloaded
        group.wait()
        
        return result
    }
}

// Make sure AWSMobileClient is a Cognito User Pool credentails providers
// this makes it easy to AWSMobileClient shared instance with AppSync Client
// read https://github.com/awslabs/aws-mobile-appsync-sdk-ios/issues/157 for details
extension AWSMobileClient: AWSCognitoUserPoolsAuthProviderAsync {
    public func getLatestAuthToken(_ callback: @escaping (String?, Error?) -> Void) {
        getTokens { (tokens, error) in
            if error != nil {
                callback(nil, error)
            } else {
                callback(tokens?.idToken?.tokenString, nil)
            }
        }
    }
}
{{< /highlight >}}

## Add a Custom Login Screen

We implement our own custom login screen as a View.  To add a new Swift class to your project, use XCode menu and click **File**, then **New** or press **&#8984;N** and then enter the file name : *CustomLoginView.swift*:

Copy / paste the code from below:

{{< highlight swift >}}
import SwiftUI

struct CustomLoginView : View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    private let app = UIApplication.shared.delegate as! AppDelegate

    var body: some View { // The body of the screen view
        VStack {
            Image("turtlerock")
            .resizable()
            .aspectRatio(contentMode: ContentMode.fit)
            .padding(Edge.Set.bottom, 20)
            
            Text(verbatim: "Login").bold().font(.title)
            
            Text(verbatim: "Explore Landmarks of the world")
            .font(.subheadline)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 70, trailing: 0))
                                
            TextField("Username", text: $username)
            .autocapitalization(.none) //avoid autocapitalization of the first letter
            .padding()
            .cornerRadius(4.0)
            .background(Color(UIColor.systemFill))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
            SecureField("Password", text: $password)
            .padding()
            .cornerRadius(4.0)
            .background(Color(UIColor.systemFill))
            .padding(.bottom, 10)

            Button(action: { self.app.signIn(username: self.username, password: self.password) }) {
                HStack() {
                    Spacer()
                    Text("Signin")
                        .foregroundColor(Color.white)
                        .bold()
                    Spacer()
                }
                                
            }.padding().background(Color.green).cornerRadius(4.0)
        }.padding()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
static var previews: some View {
        CustomLoginView() // Renders your UI View on the XCode preview
    }
}
#endif
{{< /highlight >}}

The code is straigthforward:

- the UI is structured around a vertical stack.  It has an Image, a title and subtitle.  There are two `TextField` controls allowing users to enter their username and password.  These text fields are bound to corresponding private variables.  At the bottom of the stack, there is a Login button.

- the Login button as an `action` code block.  The code calls the `AppDelegate.signIn()` function we added in the previous step.

The last step consists of using this `CustomLoginView` instead of the dropin or hosted UI.

## Update LandingView 

The `LandingView` is the view displayed when the application starts.  It routes toward a login screen or the Landmark list based on user signin attribute.  

We update `LandingView` to make use of `CustomLoginView` with this code update:

```swift
// .wrappedValue is used to extract the Bool from Binding<Bool> type
if (!$user.isSignedIn.wrappedValue) {
    CustomLoginView()
} else {
    LandmarkList().environmentObject(user)
}
```

This code is making the `LandingView` code simpler.  It displays `CustomLoginView` when user is not signed in, or `LandmarkList` otherwise.  You can safely copy/paste the full code below to replace the content of *Landmarks/LandingView.swift*:

{{< highlight swift >}}
//
//  LandingView.swift
//  Landmarks

// Landmarks/LandingView.swift

import SwiftUI

struct LandingView: View {
    @ObservedObject public var user : UserData
    
    var body: some View {
        
        return VStack {
            // .wrappedValue is used to extract the Bool from Binding<Bool> type
            if (!$user.isSignedIn.wrappedValue) {
                CustomLoginView()
            } else {
                LandmarkList().environmentObject(user)
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        let app = UIApplication.shared.delegate as! AppDelegate
        return LandingView(user: app.userData)
    }
}
{{< /highlight >}}

You can view the whole code changes for this section [from this commit](https://github.com/sebsto/amplify-ios-workshop/commit/bf43285a9ea3eec85fb7d4a3cc33a4acebdbf1d9).

## Build and Test 

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;R**.
![build](/images/20-10-xcode.png)

If you are still authenticated, click **Sign Out** and click the user badge to sign in again. You should see this:

![customized drop in UI](/images/60-30-1.png)

Enter the username and password that you created in section 3 and try to authenticated.  After a second or two, you will see the Landmark list. 