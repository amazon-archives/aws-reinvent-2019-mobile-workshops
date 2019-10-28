+++
title = "Create a user and test"
chapter = false
weight = 30

[[resources]]
  name = "LandingView"
  src = "images/30-20-test-1.png"
+++

You just add a bit of logic in the `ApplicationDelegate` class to sign in and to sign out users.  You also modified the screen flow to start the app with a `LandingView` that controls the routing towards a `LoginViewController` or the `LandmarksList` view based on the user authentication status.

Let's now verify everythign works as expected.  Start the application using XCode's menu and click **Product**, then **Run** (or press **&#8984;R**).

The application starts and shows the `LandingView`.  Click on the user icon in the middle of the screen to trigger the Amplify Login View. Click on **Create new account** to signup a new user.

Landing View | Authentication View | Signup View
:---: | :---: | :---: |
!![Landing View](/images/30-20-test-1.png) | ![App Login Screen](/images/30-20-test-2.png) | ![App Login Screen](/images/30-20-test-3.png) |


After clicking **Sign Up**, check your email.  Cognito sends you a confirmation code.

Code View | Registration View | Landmarks List View
:---: | :---: | :---: |
!![Confirmation Code](/images/30-20-test-4.png) | ![Registration](/images/30-20-test-5.png) | ![Landmark list](/images/30-20-test-6.png) |

Click **Sign Out** to end the session and return to the `LandingView`.

In the XCode console, you see some application debugging information: the username and profile of the signed in user as well as its Cognito token.  

```text 
user just signed in.
username : Optional("sebsto")
Sign in flow completed: signedIn
error : nil
attributes: Optional(["sub": "4105547d-0000-0000-0000-b057472cd2c5", "phone_number_verified": "false", "phone_number": "+33711", "email": "-secret-@amazon.com", "email_verified": "true"])

error : nil
token : Optional(AWSMobileClient.Tokens(idToken: Optional(AWSMobileClient.SessionToken(tokenString: Optional("eyJraWQiOiJ...WQi"))), expiration: Optional(2019-10-24 15:47:05 +0000)))

(edited for brevity)
```

{{% notice warning %}}
This applisation displays user personal information, such as the email address and the Cognito token in the console.  In real life DO NOT print these information in the console.  We did this for education purpose only.
{{% /notice %}}

You can ignore the following warning in XCode console, [as they appear only in the Simulator](https://openradar.appspot.com/45237042):

```text 
2019-10-24 16:47:05.056651+0200 Landmarks[92803:3338639] [Client] Updating selectors failed with: Error Domain=NSCocoaErrorDomain Code=4099 "The connection to service on pid 0 named com.apple.commcenter.coretelephony.xpc was invalidated." UserInfo={NSDebugDescription=The connection to service on pid 0 named com.apple.commcenter.coretelephony.xpc was invalidated.}
```

To permanently disable these warnings, open a Terminal and type:

```bash
xcrun simctl spawn booted log config --mode "level:off"  --subsystem com.apple.CoreTelephony
```