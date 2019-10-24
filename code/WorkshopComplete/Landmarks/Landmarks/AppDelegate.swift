/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application delegate.
*/

import UIKit
import AWSMobileClient
import AWSAppSync
import AWSS3

import SwiftUI // to access Image

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
                    // TODO should add guard statemnet and handle errorss
                    // https://nacho4d-nacho4d.blogspot.com/2016/05/dictionary-to-json-string-and-json.html
                    let jsonData = try! JSONSerialization.data(withJSONObject: $0?.jsonObject as Any, options: [])
                    // this allows to create a Landmark object using the Decodable protocol
                    let l : Landmark = try! JSONDecoder().decode(Landmark.self, from: jsonData)
                    self.userData.landmarks.append(l);
                    
                }
            }
    }

    /**
        Asynchronously load the image from S3.  This method blocks until the S3 download is completed.
        https://stackoverflow.com/questions/42484281/waiting-until-the-task-finishes
     */
    func image(_ landmark : Landmark) -> Image {
        
        print("Downloading image : \(landmark.imageName)")
        
        var image : UIImage?
        
        let group = DispatchGroup()
        group.enter()
        
        let transferUtility = AWSS3TransferUtility.default()
        transferUtility.downloadData(
            forKey: "public/\(landmark.imageName).jpg",
              expression: nil,
              completionHandler: { (task, URL, data, error) -> Void in
                
                if let e = error {
                    print("Can not download image : \(e)")
                } else {
                    print("Image \(landmark.imageName) loaded")
                    image = UIImage(data: data!)
                }
                
                group.leave()
              }
        )
        
        // wait for image to be downloaded
        group.wait()
        
        if let i = image {
            return Image(uiImage: i)
        } else {
            // TODO replace "cloud" with a generic image bundled into the project
            return Image(systemName: "cloud")
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


