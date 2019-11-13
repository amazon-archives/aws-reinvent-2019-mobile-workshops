---
title: "Amplify iOS Workshop"
chapter: true
weight: 1
---

# Build an iOS App<br/>using a cloud-based backend.

## Welcome!

In this workshop, we will create a data-driven native iOS app, integrated with a cloud-based backend.  We will use [AWS Cognito](http://aws.amazon.com/cognito) to manage user authentication and we'll use [AWS AppSync](https://aws.amazon.com/appsync/) to get up and running quickly with a [GraphQL API](https://graphql.org/learn/) that backs our data in [Amazon DynamoDB](https://aws.amazon.com/dynamodb/). We'll demonstrate how to use the [AWS Amplify](https://aws.amazon.com/amplify/) library to authenticate users, to communicate with our API, and to download images from [Amazon S3](https://aws.amazon.com/s3/).

{{% notice info %}}
This guide assumes that you are familiar with iOS development and tools. If you are new to iOS development, you can follow [these steps](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/BuildABasicUI.html) to create your first iOS application using Swift.
{{% /notice %}}

## Estimated run time

This workshop takes about 2h to 3h to complete.

## Learning Objectives

The main learning objective of this workshop is to let you discover how to take advantage of a secure, fully managed, scalable cloud backend for your iOS applications.  

We divided this workshop in three parts :

- In the first part ([section 3](30_add_authentication.html)) you will learn how to add a user authentication flow to your application.  In real life, multiple flows are required to support user authentication : SignIn, SignUp, Forgot Password, Email / Phone number verification etc.

- In the second part ([section 4](40_add_api.html) and [5](50_add_images.html)) you will learn how to deploy and call an API from your mobile application.

- Finally, you will learn how to customize the authentication user interface ([section 6](60_add_custom_gui.html)) and to add Identity Federation for your login screen (also known as "Login with XXX") ([section 7](70_add_federation.html))
