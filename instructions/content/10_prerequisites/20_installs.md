+++
title = "Installs"
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

### Installing or updating

You need different command line tools to be installed : `aws`, `amplify` and `jq`.  These tools have themselves requirements on `python`, `pip`, `nodejs` and `npm`.  To install and configure these, open a Terminal on your laptop and type the following commands:

{{% tabs %}}
{{% tab "brew" "Using Brew" %}}

Follow these instructions to install the prerequisites using [HomeBrew](https://brew.sh/) package manager.  To install `brew` itself, type `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

```bash
# install python3 and pip3
brew install python3 

# install the AWS CLI
pip3 install --upgrade awscli

# install Node.js & npm
brew install node

# install the AWS Amplify CLI
npm install -g @aws-amplify/cli

# install jq (only required to import some data into our API)
brew install jq
```
{{% /tab %}}

{{% tab "manual" "Manual" %}}
TODO
{{% /tab %}}

{{% /tabs %}}

{{% notice note %}}
These commands will take a few minutes to finish.
{{% /notice %}}

