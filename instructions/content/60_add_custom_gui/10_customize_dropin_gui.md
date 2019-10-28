+++
title = "Customize the drop in GUI"
chapter = false
weight = 10
+++

You can customize the Amplify dropin UI with minimum effort.  The `SignInUIOptions` allows you to [customize elements](https://aws-amplify.github.io/docs/ios/authentication#customization) such as the background color or the logo.

For example, let's modify some `SignInUIOptions` in `authenticateWithDropinUI()` method (in *Landmarks/ApplicationDelegate.swift* class)

{{< highlight swift "hl_lines=5-7" >}}
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
{{< /highlight >}}

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;R**.
![build](/images/20-10-xcode.png)

If you are still authenticated, click **Sign Out** and click the user badge to sign in again. You should see this:

![customized drop in UI](/images/60-10-1.png)