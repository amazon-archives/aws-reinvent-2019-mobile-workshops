+++
title = "Create an IAM User"
chapter = false
weight = 1
+++

{{% notice warning %}}
If you are attending this MOB304 workshop at AWS re:Invent 2019 (in other words, if you are reading this on Monday 2 / 12, 2pm PST, Grand Ballroom D - T2 @ Mirage), you can choose to use a temporary account for the duration of this workshop.  
If not done already, **follow [these instructions](05_event_engine.html) to access a temporary AWS account**.  Once you have access, [proceed to next section](/10_prerequisites/20_installs.html). **You can safely skip this page**.
{{% /notice %}}

## AWS Account 

To follow the instructions proposed by this workshop, you need to have an AWS Account and an IAM user with the minimum priviledges required to access the services we use in this workshop. In addition, you need to know the access key and secret key for the IAM users.  

{{% notice tip %}}
If you already have an AWS account, have IAM Administrator access and have access key and secret key, you can skip this page.
{{% /notice %}}

**If you don't already have an AWS account and you are not using an AWS temporary account**: [create
your account now](https://aws.amazon.com/getting-started/) (you need a valid phone number and a credit card)

## Create an IAM User 

Once you have an AWS account, create an **IAM user** by following these steps:

1. [Open the IAM console using this link](https://console.aws.amazon.com/iam/home?region=us-east-1#/users$new). (Alternatively, navigate to [the IAM console](https://console.aws.amazon.com/iam/home#/home), from the left menu, click **Users** and click **Add User** button on the top of the page.)

1. Enter the user details as shown below and click **Next: Permission**
![Add User](/images/10-10-add-user.png)

1. click **Attach existing policies directly**, then click the button **Create Policy**. This creates a new tab to create the policy.
![Create Policy](/images/10-10-create-policy.png)

1. Click **JSON** tab and replace the policy with the one below, then click **Review Policy**
![Add Policy](/images/10-10-add-policy.png)

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "MinimPermissionSetAmplifyiOSWorkshop",
            "Effect": "Allow",
            "Action": [
                "appsync:*",
                "cloudformation:CreateStack",
                "cloudformation:CreateStackSet",
                "cloudformation:DeleteStack",
                "cloudformation:DeleteStackSet",
                "cloudformation:DescribeStackEvents",
                "cloudformation:DescribeStackResource",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStackSet",
                "cloudformation:DescribeStackSetOperation",
                "cloudformation:DescribeStacks",
                "cloudformation:UpdateStack",
                "cloudformation:UpdateStackSet",
                "cloudfront:CreateCloudFrontOriginAccessIdentity",
                "cloudfront:CreateDistribution",
                "cloudfront:DeleteCloudFrontOriginAccessIdentity",
                "cloudfront:DeleteDistribution",
                "cloudfront:GetCloudFrontOriginAccessIdentity",
                "cloudfront:GetCloudFrontOriginAccessIdentityConfig",
                "cloudfront:GetDistribution",
                "cloudfront:GetDistributionConfig",
                "cloudfront:TagResource",
                "cloudfront:UntagResource",
                "cloudfront:UpdateCloudFrontOriginAccessIdentity",
                "cloudfront:UpdateDistribution",
                "cognito-identity:CreateIdentityPool",
                "cognito-identity:DeleteIdentityPool",
                "cognito-identity:DescribeIdentity",
                "cognito-identity:DescribeIdentityPool",
                "cognito-identity:SetIdentityPoolRoles",
                "cognito-identity:UpdateIdentityPool",
                "cognito-idp:CreateUserPool",
                "cognito-idp:CreateUserPoolClient",
                "cognito-idp:DeleteUserPool",
                "cognito-idp:DeleteUserPoolClient",
                "cognito-idp:DescribeUserPool",
                "cognito-idp:UpdateUserPool",
                "cognito-idp:UpdateUserPoolClient",
                "cognito-idp:CreateResourceServer",
                "cognito-idp:DeleteResourceServer",
                "cognito-idp:ListUserPoolClients",
                "dynamodb:CreateTable",
                "dynamodb:DeleteItem",
                "dynamodb:DeleteTable",
                "dynamodb:DescribeTable",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "dynamodb:UpdateTable",
                "iam:CreateRole",
                "iam:DeleteRole",
                "iam:DeleteRolePolicy",
                "iam:GetRole",
                "iam:GetUser",
                "iam:PassRole",
                "iam:PutRolePolicy",
                "iam:UpdateRole",
                "lambda:AddPermission",
                "lambda:CreateFunction",
                "lambda:DeleteFunction",
                "lambda:GetFunction",
                "lambda:GetFunctionConfiguration",
                "lambda:InvokeAsync",
                "lambda:InvokeFunction",
                "lambda:RemovePermission",
                "lambda:UpdateFunctionCode",
                "lambda:UpdateFunctionConfiguration",
                "s3:*",
                "amplify:*"
            ],
            "Resource": "*"
        }
    ]
}
```

1. Give a name and a description to the policy and click **Create policy** at the bottom of the page.
![Review Policy](/images/10-10-review-policy.png)

1. Return the to *Add User* tab, click the reload button (<i class="fas fa-sync-alt"></i>) to reload the list of policies, search for the policy you just created and select it. Click **Next: Tags**
![Attach Polic](/images/10-10-attach-policy.png)

1. Do not attach any tag, click **Next: Preview**

1. Review your choices and click **Create user** 

1. Take note of the **Access Key ID** and the **Secret access key** . You will need these in the next section.
![Access Key](/images/10-10-access-key.png).  When the two keys are copied, click **Close**

{{% notice warning %}}
This screen in the IAM console is the only place where you can access the secret access key.  If you fail to take a note it at this stage, you will need to regenerate a new one later.
{{% /notice %}}

You now have an IAM user with the priviledges required by Amplify.  In the remaining steps of this workshop, you will use this IAM user to programmatically access your AWS account from your laptop.
