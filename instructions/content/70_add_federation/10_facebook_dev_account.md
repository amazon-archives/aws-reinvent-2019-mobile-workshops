+++
title = "Facebook Developer Account"
chapter = false
weight = 10
+++

Nowadays, most applications allow users to sign-in using a third-party identity, defined and managed outside of your app.  This is known as Identity Federation.  Amazon Cognito does support Identity Federation out of the box with [Login With Amazon](https://login.amazon.com/), [Login with Google](https://developers.google.com/identity/sign-in/web/sign-in), [Login with Facebook](https://developers.facebook.com/docs/facebook-login/), or any [OIDC](https://openid.net/connect/) or [SAMLv2](https://en.wikipedia.org/wiki/SAML_2.0) compliant identity provider.

Just as for regular signin flow, you can chose to present to your customers with the Cognito Hosted UI or to build your own.  In this workshop, we chose to use the hosted UI because it handles most of the complexities of the OAuth flow for you.

In this last section, we're going to add a "Login With Facebook" button to our application.  This is a three steps process:

- we create a developer account on Facebook's developer web site and we create a Facebook app

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

1. Under Web Site, type your user pool domain with the `/oauth2/idpresponse` endpoint into **Site URL**. You can find the Cognito domain by looking in `awsconfiguration.json` file, under the key Auth => Default => OAuth => WebDomain.  Do not forget to type `https://` at the start of the URL.

    Alternatively, the below command will copy the value to the clipboard, you will just need to paste it in the correct field:

    ```bash
    cd $PROJECT_DIRECTORY
    echo "https://"$(cat awsconfiguration.json | jq -r .Auth.Default.OAuth.WebDomain)"/oauth2/idpresponse" | pbcopy
    ```

    ![create a facebook app 4](/images/70-10-facebook-4.png)

1. Click **Save Changes**

1. Type your user pool domain into **App Domains** and **press enter**.  This is the same domain as you entered into Site URL, without the path.  For example:
`https://amplifyiosworkshop8exxxxx-xxxxxxxx-dev.auth.eu-west-1.amazoncognito.com`

    The below command will copy the value to the clipboard, you will just need to paste it in the correct field:

    ```bash
    cd $PROJECT_DIRECTORY
    echo "https://"$(cat awsconfiguration.json | jq -r .Auth.Default.OAuth.WebDomain) | pbcopy
    ```

    ![create a facebook app 5](/images/70-10-facebook-5.png)

1. Click **Save changes**.

1. From the navigation bar choose **Products** and then **Set up** from **Facebook Login**.
![create a facebook app 6](/images/70-10-facebook-6.png)

1. From the navigation bar choose **Facebook Login** and then **Settings**.

1. Type your redirect URL into **Valid OAuth Redirect URIs** and **press enter**. It consists of your user pool domain with the `/oauth2/idpresponse` path, such as:
`https://amplifyiosworkshop8exxxxx-xxxxxxxx-dev.auth.eu-west-1.amazoncognito.com/oauth2/idpresponse`

    Alternatively, the below command will copy the value to the clipboard, you will just need to paste it in the correct field:

    ```bash
    cd $PROJECT_DIRECTORY
    echo "https://"$(cat awsconfiguration.json | jq -r .Auth.Default.OAuth.WebDomain)"/oauth2/idpresponse" | pbcopy
    ```

![create a facebook app 7](/images/70-10-facebook-7.png)

1. Click **Save changes**.

Next step is to update AWS Amplify's configuration to include Login with Facebook.