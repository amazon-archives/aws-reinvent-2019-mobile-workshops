+++
title = "Update application code"
chapter = false
weight = 20
+++

Now that the storage backend is ready, let's modify the application code to load the images from Amazon S3.  We're going to make several changes in the application:

- [add AWS Amplify dependencies](#add-amazon-s3-client-library) to the project 

- [add the code](#add-storage-access-code) to query S3 in `AppDelegate`

- [update](#update-imagestore-class) the `ImageStore` class in the *Landmarks/Models/Data.swift* file to load the cloud images instead of the local ones.

## Add Amazon S3 client library
Edit `Landmarks/Podfile` to add the Amazon S3 client dependency.  Your `Podfile` must look like this (you can safely copy/paste the entire file from belowpwd):

{{< highlight text "hl_lines=13">}}
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
  pod 'AWSS3', '~> 2.12.1'                # For file transfers

end
{{< /highlight >}}

In a Terminal, type the following commands to download and install the dependencies:

```bash
cd $PROJECT_DIRECTORY
pod install --repo-update
```

After one minute, you shoud see the below:

![Pod update](/images/50-20-s3-code-1.png)

## Add storage access code

At high level, this is what we are going to change:

- add AWS S3 file transfer code in `AppDelegate` 
- modify `UserStorage` class from the initial code sample to download images from the cloud instead of reading the file from the local bundle. 

To add storage access code, we first import the `AWSS3` framework.  File upload and download capability is provided by [TransferUtility](https://aws-amplify.github.io/docs/ios/storage#using-transferutility) component.  This class offers a high level interface to manage file uploads and downloads.  It also allows to pause and restart transfers and to monitor progress.  For this workshop, our usage will be simpler.  The code downloads a file by name and returns a `Data` object.

As usual, you can safely copy/paste the entire `AppDelegate` from below.  Lines that have been added since last section are highlighted.

{{< highlight swift "hl_lines=6 180-217" >}}
// Landmarks/AppDelegate.swift

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
{{< /highlight>}}

Notice that `AWSS3TransferUtility.transferData()` class is asynchronous and returns immediately.  It takes a callback function as argument to be notified when the transfer completes.  For this use case, we want the transfer to be synchronous and the call to return when the image becomes available.  For this purpose, the code is using thread synchronisation mechanism provided by iOS and MacOS' [Dispatch](https://developer.apple.com/documentation/DISPATCH) framework. The code creates a *Dispatch Group* and `wait()` on the callback function until it `leave()` the group.  

You can read more about Dispatch groups in [Apple's Developer documentation](https://developer.apple.com/documentation/dispatch/dispatchgroup).

## Update ImageStore class

The `ImageStore` class is part of the original code sample we started from. It is located in *Landmarks/Models/Data.swift* file.  Accessing the `image` property of a Landmark triggers the image loading logic. This class also takes care of caching images in memory to avoid loading them at each access.

Let's look how it works by reading code in *Landmarks/Models/Landmark.swift*:

```swift
extension Landmark {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
```

and in *Landmarks/Models/Data.swift*:

```swift
    static func loadImage(name: String) -> CGImage {
        // load image from the local bundle
    }
```

{{% notice tip %}}
You do not need to copy/paste the code above.  We provide the above code for reading / exploration only.
{{% /notice %}}

To download images from S3, we just replace the logic inside the `loadImage()` function.

{{< highlight swift "hl_lines=51-62" >}}
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Helpers for loading images and data.
*/

import UIKit
import SwiftUI
import CoreLocation

// this is just used for the previews. At runtime, data are now taken from UserData and loaded through AppDelegate
let landmarkData: [Landmark] = load("landmarkData.json")

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    typealias _ImageDictionary = [String: CGImage]
    fileprivate var images: _ImageDictionary = [:]

    fileprivate static var scale = 2
    
    static var shared = ImageStore()
    
    func image(name: String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(verbatim: name))
    }

    // load the image from Amazon S3 instead of local resource bundle
    static func loadImage(name: String) -> CGImage {
        let app = UIApplication.shared.delegate as! AppDelegate
        guard
            // going trough a UIImage is the shortest way I found to get a CGImage from NSData
            let i = UIImage(data: app.image(name)!),
            let image = i.cgImage
        else {
            fatalError("Couldn't load image \(name).jpg from Amazon S3.")
        }
        return image
    }
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        if let index = images.index(forKey: name) { return index }
        
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
}
{{< /highlight >}}

What did we just change ?  

- we modified the implementation of `loadImage()` function 

- it now calls `image(name)` on the application delegate.

- `image(name)` return a [Data](https://developer.apple.com/documentation/foundation/data) while `loadImage()` is supposed to return a [CGImage](https://developer.apple.com/documentation/coregraphics/cgimage).  To transform [Data](https://developer.apple.com/documentation/foundation/data) to [CGImage](https://developer.apple.com/documentation/coregraphics/cgimage), it firts created a [UIImage](https://developer.apple.com/documentation/uikit/uiimage) and then calls `.cgImage()`

- the rest of the caching and display logic is unchanged.

The list of all changes we made to the code is visible in [this commit](https://github.com/sebsto/amplify-ios-workshop/commit/cbe400f6437540a98030679c7414f1cc2f506549#diff-c13367945d5d4c91047b3b50234aa7ab).

## Launch the app 

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;R**.
![build](/images/20-10-xcode.png)

After a few seconds, you should see the application running in the iOS simulator.
![run](/images/40-30-appsync-code-2.png)

{{% notice tip %}}
There might be a small delay between the moment the Landmark list is displayed and the moment the list is populated.  This is because image loading is synchronous and calls are blocked while the images are downloaded.  One way to improve this would be to modify `UserData` class to return a pre-canned image while loading the landmark image, and replace images as they are being loaded.  
{{% /notice %}}

Now that we have the basic building blocks of the app defined, let's explore the options offered to customize the authentication user interface and user experience.