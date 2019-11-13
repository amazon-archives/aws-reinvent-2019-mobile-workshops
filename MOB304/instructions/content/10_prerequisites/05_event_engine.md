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

1. Please note the region that the event is using. **Only actions in this region are allowed.**

1. Copy and paste the CLI credentials (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`) as you will need these two values to configure the AWS Command line in [section 1.4](/10_prerequisites/30_configs.html#configuring-the-aws-command-line).

1. Click the **Open AWS Console** button to open the AWS Console.  You can also copy the login link in case you want to return to the console later.
![open console](/images/10-05-30.png)

Now that you have an AWS Account and a pair of Access Key / Secret Key, let's proceed to [the installation of development tools on your local machine](/10_prerequisites/20_installs.html).