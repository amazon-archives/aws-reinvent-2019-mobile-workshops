+++
title = "AWS Temporary Account"
chapter = false
weight = 1
+++

When attending this workshop during an event organised by AWS, such as [AWS re:Invent](https://reinvent.awsevents.com/), you may choose to use one of AWS' temporary AWS Account instead of using your personal or company AWS account.  Follow the instructions from this page and the AWS instructor in the room to access the temporary account.

{{% notice warning %}}
Should you attend this workshop on your own or in a non-AWS event, you can skip this section and [proceed to next section](/10_prerequisites/10_iam_user.html#aws-account).
{{% /notice %}}

## Access AWS Event Engine Account

1. Open your browser and navigate to [https://dashboard.eventengine.run](https://dashboard.eventengine.run)

1. Read the Terms and Conditions and Acceptable Use Policy, then enter the 12 digits hashcode given by AWS instructor.
![hash code](/images/10-05-10.png)

1. Click **AWS Console**
![link to console](/images/10-05-20.png)

    The screen below has all the information you need to run the workshop:
    ![open console](/images/10-05-30.png)

1. Please note the region that the event is using. **Only actions in this region are allowed.**

1. Copy and paste the CLI credentials.  You will need these values thorough the workshop. Open a Terminal and execute the set of `export` commands you copied from the event engine page:

```bash
# this is a copy paste from event engine console

# !! PASTE THE LINES FROM AWS EVENT ENGINE PAGE !!

# export AWS_ACCESS_KEY_ID=AKIAI44QH8DHBEXAMPLE
# export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
# export AWS_SESSION_TOKEN=AQoDYXdzEJr...<remainder of security token>

# create an AWS CLI profile for this workshop
# IF YOU ALREADY HAVE A PROFILE NAMED "WORKSHOP" => CHOOSE ANOTHER NAME !
echo "[workshop]"  >> ~/.aws/config
echo "region=us-west-2"  >> ~/.aws/config
echo "[workshop]"  >> ~/.aws/credentials
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID"  >> ~/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY"  >> ~/.aws/credentials
echo "aws_session_token = $AWS_SESSION_TOKEN"  >> ~/.aws/credentials

# unset env variables to ensure CLI will use values from the profile.
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
```

1. Finally, click the **Open AWS Console** button to open the AWS Console.  You can also copy the login link in case you want to return to the console later.

Now that you have an AWS Account and a pair of Access Key / Secret Key, let's proceed to [the installation of development tools on your local machine](/10_prerequisites/20_installs.html).