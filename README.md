## Status

Oct 22.
Final application is working and demo-able.  Some tweaks and improvements can be done, but I have a basis to start to write the core of the workshop now.

### TODO

- [X] scaffold the workshop web site
- [X] host the project on github + amplify console for hosting and CI/CD.  Use the shared evangelist account.
- [ ] start to write the workshop instructions
- [ ] eliminate the TODO in the code
- [ ] test and dry run

### Dir Structure

x (you are here)
|
|-- code
      |-- Complete       <== this is the final result of the workshop
      |-- StartingPoint  <== this is the starting point of the app
|
|-- instructions         <== this is the static web site

### Deploy

The instruction web site is generated with [Hugo](https://gohugo.io) and the [Learn theme](https://learn.netlify.com/en/).
To build the web site :
```
cd instructions
hugo
```

This site is automatically deployed to https://amplify-ios-workshop.go-aws.com

## Pre-requisites

XCode 11.1 or more recent.

```
$ amplify --version
3.0.0

$node --version
v12.12.0

$ npm --version
6.11.3

$ jq --version
jq-1.6

$ aws --version
aws-cli/1.16.253 Python/3.7.4 Darwin/18.7.0 botocore/1.12.243

$ aws configure --profile default
AWS Access Key ID [****************J7E3]:
AWS Secret Access Key [****************oGX3]:
Default region name [eu-west-1]:
Default output format [None]:
```

## Init

```
$ amplify init
Note: It is recommended to run this command from the root of your app directory
? Enter a name for the project Landmarks
? Enter a name for the environment dev
? Choose your default editor: None
? Choose the type of app that you're building ios
Using default provider  awscloudformation

For more information on AWS Profiles, see:
https://docs.aws.amazon.com/cli/latest/userguide/cli-multiple-profiles.html

? Do you want to use an AWS profile? Yes
? Please choose the profile you want to use default
⠴ Initializing project in the cloud...

CREATE_IN_PROGRESS DeploymentBucket             AWS::S3::Bucket            Fri Oct 18 2019 15:30:36 GMT+0200 (Central European Summer Time) Resource creation Initiated
CREATE_IN_PROGRESS AuthRole                     AWS::IAM::Role             Fri Oct 18 2019 15:30:35 GMT+0200 (Central European Summer Time) Resource creation Initiated
CREATE_IN_PROGRESS UnauthRole                   AWS::IAM::Role             Fri Oct 18 2019 15:30:35 GMT+0200 (Central European Summer Time) Resource creation Initiated
CREATE_IN_PROGRESS AuthRole                     AWS::IAM::Role             Fri Oct 18 2019 15:30:35 GMT+0200 (Central European Summer Time)
CREATE_IN_PROGRESS DeploymentBucket             AWS::S3::Bucket            Fri Oct 18 2019 15:30:35 GMT+0200 (Central European Summer Time)
CREATE_IN_PROGRESS UnauthRole                   AWS::IAM::Role             Fri Oct 18 2019 15:30:35 GMT+0200 (Central European Summer Time)
CREATE_IN_PROGRESS landmarks-dev-20191018153032 AWS::CloudFormation::Stack Fri Oct 18 2019 15:30:32 GMT+0200 (Central European Summer Time) User Initiated
⠴ Initializing project in the cloud...

CREATE_COMPLETE DeploymentBucket AWS::S3::Bucket Fri Oct 18 2019 15:30:56 GMT+0200 (Central European Summer Time)
CREATE_COMPLETE UnauthRole       AWS::IAM::Role  Fri Oct 18 2019 15:30:53 GMT+0200 (Central European Summer Time)
CREATE_COMPLETE AuthRole         AWS::IAM::Role  Fri Oct 18 2019 15:30:53 GMT+0200 (Central European Summer Time)
⠦ Initializing project in the cloud...

CREATE_COMPLETE landmarks-dev-20191018153032 AWS::CloudFormation::Stack Fri Oct 18 2019 15:30:58 GMT+0200 (Central European Summer Time)
✔ Successfully created initial AWS cloud resources for deployments.
✔ Initialized provider successfully.
Initialized your environment successfully.

Your project has been successfully initialized and connected to the cloud!
```
## Authentication

```
$ amplify add auth
Using service: Cognito, provided by: awscloudformation

 The current configured provider is Amazon Cognito.

 Do you want to use the default authentication and security configuration? Default configuration with Social Provider (Federation)
 Warning: you will not be able to edit these selections.
 How do you want users to be able to sign in? Username
 Do you want to configure advanced settings? No, I am done.
 What domain name prefix you want us to create for you? landmarks8edb73c3-8edb73c3
 Enter your redirect signin URI: landmarks://
? Do you want to add another redirect signin URI No
 Enter your redirect signout URI: landmarks://
? Do you want to add another redirect signout URI No
 Select the social providers you want to configure for your user pool: (Press <space> to select, <a> to toggle all, <i> to invert selection)
Successfully added resource landmarks8edb73c3 locally

Some next steps:
"amplify push" will build all your local backend resources and provision it in the cloud
"amplify publish" will build all your local backend and frontend resources (if you have hosting category added) and provision it in the cloud
```

```
$ amplify push

Current Environment: dev

| Category | Resource name     | Operation | Provider plugin   |
| -------- | ----------------- | --------- | ----------------- |
| Auth     | landmarksc33d45f2 | Create    | awscloudformation |
? Are you sure you want to continue? Yes
⠦ Updating resources in the cloud. This may take a few minutes...

(...)

✔ All resources are updated in the cloud
```

## Storage

```
$ amplify add storage
? Please select from one of the below mentioned services Content (Images, audio, video, etc.)
? Please provide a friendly name for your resource that will be used to label this category in the project: landmarks
? Please provide bucket name: landmarksb014087e45894ba6b5748c01e00e19ab
? Who should have access: Auth users only
? What kind of access do you want for Authenticated users? read
? Do you want to add a Lambda Trigger for your S3 Bucket? No
Successfully added resource landmarks locally
```

```
$ amplify push

Current Environment: dev

| Category | Resource name     | Operation | Provider plugin   |
| -------- | ----------------- | --------- | ----------------- |
| Storage  | landmarks         | Create    | awscloudformation |
| Auth     | landmarksc33d45f2 | No Change | awscloudformation |
? Are you sure you want to continue? Yes
⠼ Updating resources in the cloud. This may take a few minutes...

(...)

✔ All resources are updated in the cloud
```

## API

```
$ amplify add api
? Please select from one of the below mentioned services GraphQL
? Provide API name: landmarks
? Choose an authorization type for the API Amazon Cognito User Pool
Use a Cognito user pool configured as a part of this project
? Do you have an annotated GraphQL schema? No
? Do you want a guided schema creation? Yes
? What best describes your project: Objects with fine-grained access control (e.g., a project management app with owner-based authorization)
? Do you want to edit the schema now? No

GraphQL schema compiled successfully.

Edit your schema at /Users/stormacq/Desktop/swiftui/HandlingUserInput/Complete/Landmarks/amplify/backend/api/landmarks/schema.graphql or place .graphql files in a directory at /Users/stormacq/Desktop/swiftui/HandlingUserInput/Complete/Landmarks/amplify/backend/api/landmarks/schema
Successfully added resource landmarks locally
```

### GraphQL Schema

in `amplify/backend/api/landmarks/schema.graphql`

```
type Landmark
  @model
  @auth(rules: [ {allow: private, provider: userPools, operations: [ read ] } ])
{
  id: ID!
  name: String!
  category: String
  city: String
  state: String
  isFeatured: Boolean
  isFavorite: Boolean
  park: String
  coordinates: Coordinate
  imageName: String
}

type Coordinate {
  longitude: Float
  latitude: Float
}
```

```
$ amplify push

Current Environment: dev

| Category | Resource name     | Operation | Provider plugin   |
| -------- | ----------------- | --------- | ----------------- |
| Api      | landmarks         | Create    | awscloudformation |
| Auth     | landmarksc33d45f2 | No Change | awscloudformation |
| Storage  | landmarks         | No Change | awscloudformation |
? Are you sure you want to continue? Yes

GraphQL schema compiled successfully.

Edit your schema at /Users/stormacq/Desktop/swiftui/HandlingUserInput/Complete/Landmarks/amplify/backend/api/landmarks/schema.graphql or place .graphql files in a directory at /Users/stormacq/Desktop/swiftui/HandlingUserInput/Complete/Landmarks/amplify/backend/api/landmarks/schema
? Do you want to generate code for your newly created GraphQL API Yes
? Enter the file name pattern of graphql queries, mutations and subscriptions graphql/**/*.graphql
? Do you want to generate/update all possible GraphQL operations - queries, mutations and subscriptions Yes
? Enter maximum statement depth [increase from default if your schema is deeply nested] 2
? Enter the file name for the generated code API.swift
⠦ Updating resources in the cloud. This may take a few minutes...

(...)

✔ All resources are updated in the cloud
```

## Upload test data to the cloud
- `scripts/init_s3.sh` to upload the images
- `scripts/init-db.sh` to upload test data

## Add authentication code

- Refactor UserData
- Add LandingZone.swift
- Add the Navigation Controller
- Add UserBadge.swift  
- Update SceneDelegate to use the Landing Zone

## Add API code

- add API.swift
- change ApplicationDelegates.swift
  - initialise AppSync client
  - add call to query
  - bring data to UserData

(iterate over GraphQL List) ?

## Add Storage call

- add AWSS3 pod
- change Landmark.swift
- change ApplicationDelegates.swift
