+++
title = "Update application code"
chapter = false
weight = 30
+++

Now that we have a GraphQL API to support access our data model from the cloud, let's modify the application code to call the GraphQL endpoint instead of listing hard coded values.

At high level, here is how we gonna proceed

- first, we're going [to add](#add-the-aws-appsync-client-library) the `pod` dependency to access the AWS AppSync client library

- the [app sync client code is contained](#add-client-code-in-the-application-delegate) in `AppDelegate` class, as we did for authentication.

- `UserData` class holds a hard code reference to the list of Landmarks loaded at application startup time.  [We are going to replace with an empty list](#modify-userdata-class) (`[]`) and we're going to add code to query the API and populate the list after sucesfull sign in.

## Add the AWS AppSync client library

Edit `$PROJECT_DIRECTORY/Podfile` to add the AppSync dependency.  Your `Podfile` must look like this (you can safely copy/paste the entire file from belowpwd):

{{< highlight text "hl_lines=12">}}
# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Landmarks' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Landmarks
  pod 'AWSMobileClient', '~> 2.12.0'      # Required dependency
  pod 'AWSAuthUI', '~> 2.12.0'            # Optional dependency required to use drop-in UI
  pod 'AWSUserPoolsSignIn', '~> 2.12.0'   # Optional dependency required to use drop-in UI
  pod 'AWSAppSync', '~> 2.15.0'           # For AppSync GraphQL API
  
end
{{< /highlight >}}

In a Terminal, type the following commands to download and install the dependencies:

```bash
cd $PROJECT_DIRECTORY
pod install --repo-update
```

After one minute, you shoud see the below:

![Pod update](/images/40-30-appsync-code-1.png)

## Modify UserData class

`UserData` holds a hard coded list of landmarks, loaded from a JSON files (*Landmarks/Resources/landmarkData.json*).  The `Landmarks/Models/Data.swift` class loads the JSON file at application startup time using this line:

```swift
let landmarkData: [Landmark] = load("landmarkData.json")
```

Let's replace `UserData.swift` with the below 

{{< highlight swift "hl_lines=13" >}}
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks : [Landmark] = []
    @Published var isSignedIn : Bool = false
}
{{< /highlight >}}

On line 13, we initialise the list of landmarks with an empty array, while preserving the type of the variable.

## Add the generated code to the project 

Thanks to the strongly typed nature of GraphQL, Amplify generated Swift code to access the data types, the queries and the mutations of the API.  Remember?  The file was generated when you last type `amplify push`.  Now it's time to add the generated file in your project.  In the Finder, drag `API.swift` into Xcode under the *Landmarks* folder, where the rest of the code is. When the *Options* dialog box appears, do the following:

- Clear the **Copy items if needed** check box.
- Choose **Create groups**, and then choose **Finish**.

## Add client code in the application delegate 

We modify `AppDelegate` to add code to call the GraphQL API.  You can safely copy/paste the entire file from below. 

{{< highlight swift "hl_lines=5 11 15-16 29 35-36 73-76 140-155 157-178 180-193" >}}
// Landmarks/AppDelegate.swift

import UIKit
import AWSMobileClient
import AWSAppSync

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
        let signinUIOptions = SignInUIOptions(canCancel: false)

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

What we did change ?

- import `AWSAppSync` framework and define a private reference to it.

- initialize the `AWSAppSyncClient` client in the function `func appSyncInit()`.  Notice that to make things easier, we extends `AWSMobileClient` to implement the `AWSCognitoUserPoolsAuthProviderAsync` protocol.  This protocol allows to obtain Cognito tokens for the currently authenticated user.  We pass the `AWSMobileClient` to the `AWSAppSyncClient` through its configuration object (`AWSAppSyncClientConfiguration`).

- we added `func queryLandmarks()` to call the API.  This function uses the generated code to pass arguments to the AppSync client.  `self.appSyncClient?.fetch()` is asynchronous and returns immediately.   We pass a callback inline function `(result, error) in ...` to be notified when the data are available.  When data are available, the code transforms the JSON obect received in `Landmark` object (as defined in *Landmarks/Models/Landmark.swift*).  Newly created objects are added to the array of Landmarks in `UserData` with this line of code `self.userData.landmarks.append(l)`.

- finally, we added code to query the API and to populate the Landmrk list (`self.queryLandmarks()`) at two places.  First in the Authentication Listener Hub, when the app receives the `.signedIn` event, second in `AWSMobileClient.default().initialize` to ensure the application lods the list at startup, when the user is already authenticated. 

The list of all changes we made to the code is visible in [this commit](https://github.com/sebsto/amplify-ios-workshop/commit/9ec7a9a76395f49e324781fb2cad055d9e7d087a).

## Launch the app 

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;R**.
![build](/images/20-10-xcode.png)

After a few seconds, you should see the application running in the iOS simulator.
![run](/images/40-30-appsync-code-2.png)

{{% notice tip %}}
If you did not sign out last time you started the application, you are still signed in.  This is expected as the `AWSMobileClient` library stores the token locally and automatically refresh the token when it expires.
{{% /notice %}}

At this stage, we have hybrid data sources.  The Landmark list is loaded from the GraphQL API, but the images are still loaded from the local bundle.  In the next section, we are going to move the images to Amazon S3.
