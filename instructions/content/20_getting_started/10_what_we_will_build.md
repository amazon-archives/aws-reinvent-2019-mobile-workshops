+++
title = "What we will build"
chapter = false
weight = 10
+++

During this workshop, we are going to add a cloud-based authentication and API backend to an existing iOS application.  We will start with Apple's SwiftUI Example App, starting at the phase "[Handling User Input](https://developer.apple.com/tutorials/swiftui/tutorials").  The workshop provides steps-by-steps instruction to create and configure the backend and to modify the client code.

Splash | Authentication | Main View
:---: | :---: | :---: |
![App Login Screen](/images/20-10-app-01.png) | ![App Login Screen](/images/20-10-app-03.png) | ![App Login Screen](/images/20-10-app-02.png) |

The application will use :

- [AWS Cognito](https://docs.aws.amazon.com/en_pv/cognito/latest/developerguide/what-is-amazon-cognito.html) to authenticate users
- [AWS AppSync](https://docs.aws.amazon.com/en_pv/appsync/latest/devguide/welcome.html) to call a GraphQL API to access its data set
- [Amazon S3](https://docs.aws.amazon.com/en_pv/AmazonS3/latest/gsg/GetStartedWithS3.html) to access images

![Architecture](/images/20-10-architecture.png)