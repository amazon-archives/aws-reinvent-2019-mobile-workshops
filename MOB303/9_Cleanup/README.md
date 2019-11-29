# Build and ship full-stack serverless apps with AWS Amplify

## Cleanup

Amplify provides several tools to help you manage the AWS resources deployed for your project. Thus far, we have primarily used `amplify add` to add new functionality. In this module, we'll briefly discuss a few other tools at your disposal as well as clean-up the resources we've deployed.

> If you have been using your own AWS account and would like to keep your work, feel free to leave as is. Continue reading, just skip executing the commands below.

First, let's recall the services we have used Amplify to deploy thus far. The `amplify status` command will print a listing of enabled resources and their current status (i.e. if a change is ready to be pushed to the cloud).

``` bash
amplify status
```

If you run the `status` command, the result should look something like the following (depending on the optional modules you have completed):

``` bash
Current Environment: dev

| Category    | Resource name            | Operation | Provider plugin   |
| ----------- | ------------------------ | --------- | ----------------- |
| Auth        | amplifyphotosabcde123    | No Change | awscloudformation |
| Storage     | AmplifyPhotoStorage      | No Change | awscloudformation |
| Api         | AmplifyPhotosApi         | No Change | awscloudformation |
| Function    | AmplifyPhotoProcessor    | No Change | awscloudformation |
| Predictions | identifyEntitiesccd20a09 | No Change | awscloudformation |
| Analytics   | amplifyphotos            | No Change | awscloudformation |

GraphQL endpoint: https://abcdefg12345.appsync-api.us-east-2.amazonaws.com/graphql
```

If you would like to remove a resource, Amplify provides a `remove command`. For example, to remove Analytics, you can use:

``` bash
amplify remove analytics
```

```
# Be sure to update resources in cloud as well
amplify push
```

The Amplify `delete` command will delete all resources associated with your project, both locally and in the cloud.

``` bash
amplify delete
```

If you are finished with today's workshop and do not want to keep the deployed the application, use `amplify delete` to remove. Note that the React application will not be deleted.

For those using an account provided by AWS Event Engine, there is no further action required. If you have run this workshop in your account, please also delete CodeCommit, Cloud9, and Amplify resources.

## Thanks!

We hope you have enjoyed the workshop and have a working, full-stack serverless app deployed. If you have completed this workshop at re:Invent, please don't forget to complete the survey.