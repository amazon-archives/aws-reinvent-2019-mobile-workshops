+++
title = "Add an authentication backend"
chapter = false
weight = 10
+++

Now that we have the application up and running and all the pre-requisites installed, let's add user authentication.  This workshop proposes to use [AWS Amplify](https://aws.amazon.com/amplify/) to create and integrate with a cloud-based backend.  AWS Amplify comprises two components: a [command line tool](https://aws-amplify.github.io/docs/cli-toolchain/quickstart) to easily provision cloud-based services from your laptop and a [library](https://aws-amplify.github.io/docs/ios/start) to access these services from your application code.

## Initialise amplify command line

The first time you use AWS Amplify in a project, Amplify needs to initialise your project directory and the cloud environment.  We assume *$PROJECT_DIRECTORY* is set and unchanged from [previous step](/20_getting_started/20_bootstrapping_the_app.html).

In a Terminal, type the following commands:

```bash
cd $PROJECT_DIRECTORY
amplify init
```

1. Enter a name for your project: enter **amplifyiosworkshop** and press enter.

1. Enter a name for your environment: enter **dev** and press enter.

1. Choose your default editor:  use the arrow keys to scroll to **None** and press enter.

1. Choose the type of app that you're building: accept the default **ios** and press enter.

1. Do you want to use an AWS profile? accept the default **Yes** and press enter.

1. Please choose the profile you want to use: accept the default **default** and press enter.

![amplify init](/images/30-10-amplify-init.png)

Amplify will create a local directory structure to host your project's meta-data.  In addition, it will create the backend resources to host your project : two IAM roles, an S3 bucket and a AWS Cloudformation template.  After 1 or 2 minutes, you should see the below messages:

![amplify init](/images/30-10-amplify-init-ok.png)

## Add an authentication backend

We will now set up an [Amazon Cognito](https://aws.amazon.com/cognito/) User Pool to act as the backend for letting users sign up and sign in. (More about Amazon Cognito and what a User Pool is below)

In a Terminal, type the following commands:

```bash
cd $PROJECT_DIRECTORY
amplify add auth
```

1. Do you want to use the default authentication and security configuration? Use the arrow keys to select **Default configuration with Social Provider (Federation)** and press enter

1. How do you want users to be able to sign in? Accept the default **Username** and press enter.

1. Do you want to configure advanced settings? Accept the default **No, I am done.** and press enter.

1. What domain name prefix you want us to create for you? Accept the default (**amplifyiosworkshopxxxxxx**) and press enter.

1. Enter your redirect signin URI: Type **landmarks://** and press enter.

1. Do you want to add another redirect signin URI? Accept the default **N** and press enter.

1. Enter your redirect signout URI: Type **landmarks://** and press enter.

1. Do you want to add another redirect signout URI? Accept the default **N** and press enter.

1. Select the social providers you want to configure for your user pool. Do not select any other provider at this stage, press enter.

![amplify init](/images/30-10-amplify-add-auth.png)

Amplify generates configuration files in `$PROJECT_DIRECTORY/amplify`. To actually create the backend resources, type the following command:

```bash
amplify push
```

1. Are you sure you want to continue? Accept the default **Y** and press enter.

![amplify init](/images/30-10-amplify-push-1.png)

After a while, you should see:

![amplify init](/images/30-10-amplify-push-2.png)

{{% notice tip %}}
Amazon Cognito lets you add user sign-up, sign-in, and access control to your web and mobile apps quickly and easily. We just made a User Pool, which is a secure user directory that will let our users sign in with the username and password pair they create during registration. Amazon Cognito (and the Amplify CLI) also supports configuring sign-in with social identity providers, such as Facebook, Google, and Amazon, and enterprise identity providers via SAML 2.0. If you'd like to learn more, we have a lot more information on the [Amazon Cognito Developer Resources page](https://aws.amazon.com/cognito/dev-resources/) as well as the [AWS Amplify Authentication documentation.](https://aws-amplify.github.io/docs/ios/authentication)
{{% /notice %}}