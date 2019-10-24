+++
title = "Update application code"
chapter = false
weight = 20
+++

Now that the cloud-based backend is ready, let's modify the application code to add an authentication screen.  We're going to make several changes in the application:

- add AWS Amplify [dependencies](#add-the-amplify-library-to-the-ios-project) to the project 
- add [the code](#add-authentication-code) to trigger the authentication UI and monitor the state of sessions
- add a [Landing view](#add-a-landing-view) to route users to the authenticated and authenticated views

We choose to write all AWS specific code in the ApplicationDelegate class, to avoid spreading dependencies all over the project.

The view navigation will look like this:

{{<mermaid align="left">}}
graph LR;
    A(SceneDelegate) -->|entry point| B(LandingView)
    B --> C{is user<br/>authenticated?}
    C -->|no| D(LoginView)
    C -->|Yes| E(LandmarksList)
{{< /mermaid >}}

## Add the amplify library to the iOS project

We are using [CocoaPods](https://cocoapods.org/), a MacOS package manager, to add the Amplify library to your project.
The instructions below assume CocoaPod is already installed.  If not, refer to the instructions provided in the [pre-requisites section](/10_prerequisites/20_installs.html#installing-or-updating).

In a Terminal, type the following commands to create a `Pod` file:

```bash
cd $PROJECT_DIRECTORY
pod init
```

Edit `Podfile` to add Amplify dependencies.  You `Podfile` must look like this:

```text
# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Landmarks' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Landmarks
  pod 'AWSMobileClient', '~> 2.12.0'      # Required dependency
  pod 'AWSAuthUI', '~> 2.12.0'            # Optional dependency required to use drop-in UI
  pod 'AWSUserPoolsSignIn', '~> 2.12.0'   # Optional dependency required to use drop-in UI

end
```

Without changing directory, let `pod` download and install the dependencies:

```bash 
pod install --repo-update
```

After one or two minutes, you shoud see the below (it is safe to gnore the two warnings):

![pod install](/images/30-20-pod-install-1.png)

If your XCode project is open, close XCode and re-open the project *workspace* that `pod` just created.

```bash 
open HandlingUserInput.xcworkspace/
```

{{% notice info %}}
It is important to open the XCode **workspace** and not the XCode project.
{{% /notice %}}

### Add awsconfiguration.json to the project 

Rather than configuring each service through a constructor or constants file, the AWS SDKs for iOS support configuration through a centralized file called `awsconfiguration.json` which defines all the regions and service endpoints to communicate. Whenever you run `amplify push`, this file is automatically created allowing you to focus on your Swift application code. On iOS projects the `awsconfiguration.json` will be placed into the root directory and you will need to add it to your XCode project.

In the Finder, drag `awsconfiguration.json` into Xcode under the top Project Navigator folder (the folder named HandleUserInput). When the Options dialog box appears, do the following:

- Clear the **Copy items if needed** check box.
- Choose **Create groups**, and then choose **Finish**.

### Update Target Configurations for CocoaPods

Click on **HandleUserInput** on the top left part of the screen, then **Info**.  Open **Configurations**, **Debug**.  For the **landmarks** target, replace the configuration by **Pods-landmarks.debug**. Repeat the operation for the **release** target, using **Pods-landmarks.release** configuration.  Your project should look like this:

![pod install](/images/30-20-pod-install-2.png)

### Build & Verify 

Build and launch the application to verify everything is working as expected. **Choose** the iOS Simulator you want to use (I am using iPhone 11) and click the **build** icon <i class="far fa-caret-square-right"></i>.
![First build](/images/20-10-xcode.png)

After a few seconds, you should see the application running in the iOS simulator.
![First run](/images/20-10-app-start.png)

## Add authentication code

Add a flag in the UserData class to keep track of authentication status. Highlighted lines shows the update.  You can copy/paste the whole content to replace *Landmarks/Models/UserData.swift* :

{{< highlight swift "hl_lines=8-8 10">}}
// Landmarks/Models/UserData.swift
import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
    @Published var isSignedIn : Bool = false
}
{{< /highlight >}}

Add user authentication logic to *Landmarks/AppDelegate.swift*:

{{< highlight swift "hl_lines=4-4 9-9 13-50 53-63 85-122 125" >}}
// Landmarks/AppDelegate.swift

import UIKit
import AWSMobileClient

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public let userData = UserData()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
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

}
{{< /highlight >}}

What did we add ?

- we moved `userData` object to the ApplicationDelegate to be able to access it from anywhere in the app.
- we added an `AWSMobileClient.addUserStateListener` to listen for changes in authentication status. That code updates the `isSignedIn` flag inside the `userData` object.
- we addedd an `authenticateWithDropinUI()` method to trigger the UI flow using Amplify's drop in component.
- we added an `authenticateWithHostedUI()` method to trigger the UI flow using Cognito's hosted web interface.
- we added a `signOut()` method to sign the user out.

Before proceeding to the next steps, **build** (&#8984;B) the project to ensure there is no compilation error.

## Add a landing view as router to authenticated and non-authenticated views

Let's create three new Swift classes:

- **UserBadge.swift** is the view to use when user is not authenticated
- **LoginViewController.swift** is the View Controller to host the Amplify drop in UI component
- **LandingView.swift** is the application entry point.  It displays either LoginViewControler or LandmarksList based on user's authentication status.

To add a new Swift class to your project, use XCode menu and click **File**, then **New** or press **&#8984;N** and then enter the file name.

### UserBadge.swift 

{{< highlight swift >}}
//
//  UserBadge.swift
//  Landmarks

import SwiftUI

struct UserBadge: View {
    var body: some View {
        GeometryReader { geometry in
        ZStack {
            Circle().stroke(Color.blue, lineWidth: geometry.size.width/50.0)

            VStack {
                Circle()
                    .frame(width:geometry.size.width / 2.0, height:geometry.size.width / 2.0, alignment: .center)
                    .foregroundColor(.blue)
                    .offset(x:0, y:geometry.size.width/3.3)

                Circle()
                    .frame(width:geometry.size.width, height:geometry.size.width, alignment: .center)
                    .foregroundColor(.blue)
                    .offset(x:0, y:geometry.size.width/3.0)

                
            }
        }
        .clipShape(Circle())
        .shadow(radius: geometry.size.width/30.0)
        }
    }
}

struct UserBadge_Previews: PreviewProvider {
    static var previews: some View {
        UserBadge()
    }
}
{{< /highlight >}}

### LoginViewController.swift

{{< highlight swift >}}
//
//  LoginViewControler.swift
//  Landmarks

import SwiftUI
import UIKit

struct LoginViewController: UIViewControllerRepresentable {
    
    let navController =  UINavigationController()
    
    
    func makeUIViewController(context: Context) -> UINavigationController {
        navController.setNavigationBarHidden(true, animated: false)
        let viewController = UIViewController()
        navController.addChild(viewController)
        return navController
    }

    func updateUIViewController(_ pageViewController: UINavigationController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LoginViewController

        init(_ loginViewController: LoginViewController) {
            self.parent = loginViewController
        }
    }
    
    func authenticate() {
        let app = UIApplication.shared.delegate as! AppDelegate        
        app.authenticateWithDropinUI(navigationController: navController)
    }
    
}
{{< /highlight >}}

Despite we are using SwiftUI for this project, a ViewController is required by Amplify's drop in UI component.  This LoginViewController class has two purposes:

1. it creates a bridge between SwiftUI and the UIKit world, as described in [Apple's Developer tutorial](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit).

2. the `authenticate()` method triggers the user authentication flow.  It will be called by the `LandingView`

### LandingView.swift

{{< highlight swift >}}
//
//  LandingView.swift
//  Landmarks

// Landmarks/LandingView.swift

import SwiftUI

struct LandingView: View {
    @ObservedObject public var user : UserData
    
    var body: some View {
        
        let loginView = LoginViewController()

        return VStack {
            // .wrappedValue is used to extract the Bool from Binding<Bool> type
            if (!$user.isSignedIn.wrappedValue) {
                
                ZStack {
                    loginView
                    Button(action: { loginView.authenticate() } ) {
                        UserBadge().scaleEffect(0.5)
                    }
                }

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

This `LandingView` creates the `LoginViewController`.  When user is not authenticated, it creates a stack with the `loginView`, (provided by Amplify) and the `UserBadge`.  Clicking on the `UserBadge` triggers the `authenticate()` method. When user is authenticated, it passes the user object to `LandmarkList`.

### Update SceneDelegate.swift 

Finally, we update `SceneDelegate.swift` to launch our new `LandingView` instead of launching `LandmarksList`. Highlighted lines shows the update.  You can copy/paste the whole content to replace *Landmarks/SceneDelegate.swift* :

{{< highlight swift "hl_lines=14-14 25-25 65" >}}
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The scene delegate.
*/

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let app = UIApplication.shared.delegate as! AppDelegate
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Use a UIHostingController as window root view controller
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.rootViewController = UIHostingController(rootView: LandingView(user: app.userData))

            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
{{< /highlight >}}

## Add a signout button

To make our tests easier and to allow user to signout and invalidate their session, let's add a signout button on the top of the LandmarksList view.  Highlighted lines shows the update.  You can copy/paste the whole content to replace *Landmarks/LandmarksList.swift* 

{{< highlight swift "hl_lines=10-20 44-44 58" >}}
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct SignOutButton : View {
    let app = UIApplication.shared.delegate as! AppDelegate

    var body: some View {
        NavigationLink(destination: LandingView(user: app.userData)) {
            Button(action: { self.app.signOut() }) {
                Text("Sign Out")
            }
        }
    }
}

struct LandmarkList: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Show Favorites Only")
                }
                
                ForEach(userData.landmarks) { landmark in
                    if !self.userData.showFavoritesOnly || landmark.isFavorite {
                        NavigationLink(
                            destination: LandmarkDetail(landmark: landmark)
                                .environmentObject(self.userData)
                        ) {
                            LandmarkRow(landmark: landmark)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Landmarks"))
            .navigationBarItems(trailing: SignOutButton())
        }
    }
}

struct LandmarksList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
        .environmentObject(UserData())
    }
}
{{< /highlight >}}

What we did just change ?

- we created a `SignOutButton` struct that has a reference to the `ApplicationDelegate` and calls `signOut()` when pressed.  The button is just a text with a navigation link.
- we added that button as trailing item in the navigation bar.

Before proceeding to the next steps, **build** (&#8984;B) the project to ensure there is no compilation error.

## Summary

The list of all changes we made to the code is visible in [this commit](https://github.com/sebsto/amplify-ios-workshop/commit/5c2813864e6824fec55953bb40a848cd87fb7f9c).