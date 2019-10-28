+++
title = "Federation with Custom UI"
chapter = false
weight = 40
+++

{{< notice warning >}}
This is work in progress
{{< /notice >}}

The last step in this workshop is to udate the Custom Login UI we created in section 6 to include Identity Federation.

If you completed the last step, your backend is ready, we need to modify the frontend.  There are three main steps:

- we add a function `signInWithFederation()` in the `AppDelegate` 

- we add a "Login With Facebook" button on the `CustomLoginView`

- we add code to open Facebook login page and to retrieve Facebook's code to finish authentication.

This last step is quiet complex.  It requires the build the correct login URL that Facebook will accept.  It also involves adding code to collect the code passed back when the app is open using our custom URL scheme (`landmark://`).

## Update Custom Login View

## Update App Delegate

TODO

### Open Facebooks login page and get the code

TODO

https://www.facebook.com/v2.12/dialog/oauth?client_id=2312411109071148&redirect_uri=landmarks://&scope=email%2Cpublic_profile&response_type=code&state=STATE

https://www.facebook.com/v2.12/dialog/oauth?client_id=2312411109071148&redirect_uri=landmarks://&scope=email%2Cpublic_profile&response_type=code&state=STATE&ret=login&fbapp_pres=0&logger_id=a739fb35-f365-4723-bba9-e270430ba139&cancel_url=https://amplifyiosworkshopaf0e3fe3-af0e3fe3-dev.auth.eu-west-1.amazoncognito.com/oauth2/idpresponse?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied&state=STATE#_=_&display=page&locale=en_GB

### Collect code when custom URL is invoked

TODO

## Build and Test 

Build and launch the application to verify everything is working as expected. Click the **build** icon <i class="far fa-caret-square-right"></i> or press **&#8984;R**.
![build](/images/20-10-xcode.png)

If you are still authenticated, click **Sign Out** and click the user badge to sign in again. You should see this:

![federation with custom UI](/images/70-40-customui-1.png)

Click **Continue** With Facebook, follow the Facebook login process, including accepting AMplify iOS Workshop app to access your profile data and, eventually, you should see the Landmark list.