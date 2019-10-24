+++
title = "Create an IAM User"
chapter = false
weight = 1
+++

To follow the instructions proposed by this workshop, you need to have an AWS Account and an IAM user with administrative priviledges.  In addition, you need to know the access key and secret key for the IAM users.  

{{% notice tip %}}
If you already have an AWS account, have IAM Administrator access and have access key and secret key, you can skip this page.
{{% /notice %}}


1. **If you don't already have an AWS account with Administrator access**: [create
one now](https://aws.amazon.com/getting-started/)

1. Once you have an AWS account, create an **IAM user** with administrator access to the AWS account:
[Create a new IAM user to use for the workshop](https://console.aws.amazon.com/iam/home?region=us-east-1#/users$new)

1. Enter the user details:
![Create User](/images/10-10-iam-1-create-user.png)

1. Attach the AdministratorAccess IAM Policy:
![Attach Policy](/images/10-10-iam-2-attach-policy.png)

1. Click to create the new user:
![Confirm User](/images/10-10-iam-3-create-user.png)

1. Take note of the login URL and save:
![Login URL](/images/10-10-iam-4-save-url.png)

1. Generate and access key and secret key for the user

TODO : add screenshots

You now have an IAM user with administrative priviledges.  In the remaining steps of this workshop, you will use this IAM user to programmatically access your AWS account from your laptop.
