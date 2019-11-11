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

You need different command line tools to be installed : `aws`, `amplify`, `cocoapods` and `jq`.  These tools have themselves requirements on `python`, `pip`, `nodejs` and `npm`.  To install and configure these, open a Terminal on your laptop and type the following commands:

{{% tabs %}}
{{% tab "brew" "Installation" %}}

Follow these instructions to install the prerequisites using [HomeBrew](https://brew.sh/) package manager. 

```bash

# install brew itself
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install python3 and pip3
brew install python3 

# install the AWS CLI
brew install awscli

# install Node.js & npm
brew install node

# install the AWS Amplify CLI
npm install -g @aws-amplify/cli

# install jq (only required to import some data into our API)
brew install jq

# install cocoa pods
sudo gem install cocoapods
```
{{% /tab %}}

{{% tab "version" "Version Check" %}}
If you already have one or several of these dependencies installed, just verify you have the latest version.  Here are the versions we tested the workshop instructions with.  Any more recent version should work as well.

```bash
brew --version
# Homebrew 2.1.15
# Homebrew/homebrew-core (git revision abe6e; last commit 2019-11-04)
# Homebrew/homebrew-cask (git revision e317e; last commit 2019-11-04)

python3 --version
# Python 3.7.5

aws --version
# aws-cli/1.16.273 Python/3.7.5 Darwin/18.7.0 botocore/1.13.9

node --version
# v12.12.0

amplify --version
# Scanning for plugins...
# Plugin scan successful
# 3.17.0

pod --version
# 1.8.4
```

{{% /tab %}}

{{% /tabs %}}

{{% notice note %}}
These commands will take a few minutes to finish.
{{% /notice %}}

To learn more about the tools we are instaling, you can follow the following links:

- [AWS CLI](https://docs.aws.amazon.com/en_pv/cli/latest/userguide/cli-chap-welcome.html)
- [AWS Amplify CLI](https://aws-amplify.github.io/docs/cli-toolchain/quickstart)
- [jq](https://stedolan.github.io/jq/)
- [Node.js](https://nodejs.org/en/)
- [Cocoa Pods](https://cocoapods.org/)