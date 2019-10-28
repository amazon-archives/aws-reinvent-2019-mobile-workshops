+++
title = "Use the Cognito hosted UI"
chapter = false
weight = 10
+++

Amazon Cognito offers a hosted user interface, i.e. a web based authentication view that can be shared between your mobile and web clients. The hosted UI is a customisable OAuth 2.0 flow that allows to launch a login screen without embedding the SDK for Cognito or a Social provider in your application.

You can learn more about the Hosted UI experience in the [Amplify documentation](https://aws-amplify.github.io/docs/ios/authentication#using-hosted-ui-for-authentication) or in the [Amazon Cognito documentation](https://docs.aws.amazon.com/en_pv/cognito/latest/developerguide/cognito-user-pools-configuring-app-integration.html).

The code to launch the hosted UI is already in the `ApplicationDelegate` class:

{{< highlight swift >}}
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
{{< /highlight >}}

Notice that the `showSignIn()` is used t display both the dropin UI and the hosted UI.  The difference lies in the options passed.  To show the drop in UI, pass a `HostedUIOptions` object.

To experiment the hosted UI, you replace one line of code in the file *Landmarks/LoginViewController.swift*:

{{< highlight swift "hl_lines=3-4">}}
    func authenticate() {
        let app = UIApplication.shared.delegate as! AppDelegate        
//        app.authenticateWithDropinUI(navigationController: navController)
        app.authenticateWithHostedUI(navigationController: navController)
    }
{{< /highlight >}}

## Build and test 

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i>.
![build](/images/20-10-xcode.png)

If you are still authenticated, click **Sign Out** and click the user badge to sign in again. You should see this:

![customized drop in UI](/images/60-20-1.png)

{{% notice tip %}}
The very first time user launches the hosted UI, iOS displays a confirmation message to inform users they are going to open a web address.  This message is part of [iOS Universal Link](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content) and can not be modified.
{{% /notice %}}
