+++
title = "Facebook Developer Account"
chapter = false
weight = 10
+++

Nowadays, most applications allow users to sign-in using a third-party identity, defined and managed outside of your app.  This is known as Identity Federation.  Amazon Cognito does support Identity Federation out of the box with [Login With Amazon](https://login.amazon.com/), [Login with Google](https://developers.google.com/identity/sign-in/web/sign-in), [Login with Facebook](https://developers.facebook.com/docs/facebook-login/), or any [OIDC](https://openid.net/connect/) or [SAMLv2](https://en.wikipedia.org/wiki/SAML_2.0) compliant identity provider.

Just as for regular signin flow, you can chose to present to your customers with the Cognito Hosted UI or to build your own.

In this last section, we're going to add a "Login With Facebook" button to our application.  This is a three steps process:

- we create a developer account on Facebook's developer web site and we create an App

- we update the Amplify configuration to add Facebook as an identity provider 

- we revert back the application code to the Hosted UI (the one we used [in section 6.2](/60_add_custom_gui/20_hosted_ui.html)

## Create a Facebook app

To setup oAuth with Facebook, follow these steps:

1. Create [a developer account with Facebook](https://developers.facebook.com/docs/facebook-login).

1. [Sign In](https://developers.facebook.com/) with your Facebook credentials.

1. From the **My Apps** menu, choose **Create App**.
![create a facebook app 1](/images/70-10-facebook-1.png)

1. Enter a name for your app and click **Create App Id**.
![create a facebook app 2](/images/70-10-facebook-2.png)

1. From the left side menu, choose **Settings**, **Basic** and take note of the **App ID** and **App Secret**
![create a facebook app 3](/images/70-10-facebook-3.png)

1. Click **+Add a Platform** from the bottom of the page and choose **Web Site**

1. Under Website, type your user pool domain with the `/oauth2/idpresponse` endpoint into **Site URL**. You can find the Cognito domain by looking in `awsconfiguration.json` file, under the key Auth => Default => OAuth => WebDomain.  Do not forget to type `https://` at the start of the URL.
![create a facebook app 4](/images/70-10-facebook-4.png)

1. click **Save Changes**

1. Type your user pool domain into **App Domains** (this is the same domain as you entered into Site URL, without the path), for example:
`https://landmarks8exxxxx-xxxxxxxx-dev.auth.eu-west-1.amazoncognito.com`
![create a facebook app 5](/images/70-10-facebook-5.png)

1. Click **Save changes**.

1. From the navigation bar choose **Products** and then **Set up** from **Facebook Login**.
![create a facebook app 6](/images/70-10-facebook-6.png)

1. From the navigation bar choose **Facebook Login** and then **Settings**.

1. Type your redirect URL into **Valid OAuth Redirect URIs**. It will consist of your user pool domain with the `/oauth2/idpresponse` endpoint, such as: 
`https://landmarks8exxxxx-xxxxxxxx-dev.auth.eu-west-1.amazoncognito.com/oauth2/idpresponse`
![create a facebook app 7](/images/70-10-facebook-7.png)

1. Click **Save changes**.

Last step is to configure the iOS app to accept the redirection URL.

## Setup Amazon Cognito Hosted UI in iOS App

Add `landmarks://` to the app’s URL schemes:

1. In XCode, right-click **Info.plist** and then choose **Open As** > **Source Code**.

1. Add the following entry in URL scheme:
```xml
<plist version="1.0">

     <dict>
     <!-- YOUR OTHER PLIST ENTRIES HERE -->

     <!-- ADD AN ENTRY TO CFBundleURLTypes for Cognito Auth -->
     <!-- IF YOU DO NOT HAVE CFBundleURLTypes, YOU CAN COPY THE WHOLE BLOCK BELOW -->
     <key>CFBundleURLTypes</key>
     <array>
         <dict>
             <key>CFBundleURLSchemes</key>
             <array>
                 <string>landmarks</string>
             </array>
         </dict>
     </array>

     <!-- ... -->
     </dict>
```

1. Save (**&#8984;S**) and build (**&#8984;B**) to ensure there is no typo.

Next step is to update AWS Amplify's configuration to include Login with Facebook.