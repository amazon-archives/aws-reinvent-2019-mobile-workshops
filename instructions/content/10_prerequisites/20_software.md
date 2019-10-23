+++
title = "Installs & Configs"
chapter = false
weight = 20
+++

Before we begin coding, there are a few things we need to install, update, and configure on your laptop.

### Apple Software

In order to develop native applications for iOS, you need to have [XCode](https://apple.com/xcode) installed on your laptop.
You can download and install XCode from [Apple's App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).  The download is ~2Gb, so it might take up to one hour depending on your network connection.

If you are attending this workshop during [re:Invent 2019](https://reinvent.awsevents.com), ask an AWS Staff member to get a USB key containing XCode 11 package.

{{% notice note %}}
This workshop requires [Swift 5.1](https://swift.org) and [Swift UI](https://developer.apple.com/xcode/swiftui/) framework.  These are provided by [XCode 11](https://apple.com/xcode) or more recent.
{{% /notice %}}

### Installing and updating

You need different command line tools to be installed : `aws`, `amplify` and `jq`.  These tools have themselves requirements on `python`, `pip`, `nodejs` and `npm`.  To install and configure these, open a Terminal on your laptop and type the following commands:

```bash
# check if pip is installed and install pip when required.
# TODO 

# install the AWS CLI
pip install --upgrade awscli

# Install and use latest Node.js & npm
# TODO 

# Install the AWS Amplify CLI
npm install -g @aws-amplify/cli

# Check and install jq if required
# TODO
```

{{% notice note %}}
These commands will take a few minutes to finish.
{{% /notice %}}

### Configuring the aws command line

Before using `aws` command line, you need to configure a default **region** and give the **access key and secret key** of the IAM user created in [the previous step](http://localhost:1313/10_prerequisites/10_account.html).

A best practice is to deploy your infrastructure close to your customers, let's configure a default AWS Region for this workshop : Oregpn (*us-west-2*) for North America or Frankfurt (*eu-central-1*) for Europe.

{{% tabs %}}
{{% tab "us-west-2" "North America" %}}
In the Terminal, type:

`aws configure`

1. At the **AWS Access Key** prompt, enter **the IAM user access key**

1. At the **AWS Secret Access Key** prompt, enter **the IAM user secret access key**

1. At the **Default region name**, enter the region close to your customers (in this workshop, we use **us-west-2** for Northern America)

1. At the Default output format, keep the defaut **None**

TODO : add screenshot

{{% /tab %}}

{{% tab  "eu-central-1"  "Europe" %}}
In the Terminal, type:

`aws configure`

1. At the **AWS Access Key** prompt, enter **the IAM user access key**

1. At the **AWS Secret Access Key** prompt, enter **the IAM user secret access key**

1. At the **Default region name**, enter the region close to your customers (in this workshop, we use **eu-central-1** for Europe)

1. At the Default output format, keep the defaut **None**

TODO : add screenshot

{{% /tab %}}
{{% /tabs %}}


