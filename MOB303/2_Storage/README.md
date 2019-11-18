# Build and ship full-stack serverless apps with AWS Amplify

## Adding Storage

Next, let's add storage for our application. Specifically, we will add a new [Amazon S3](https://aws.amazon.com/s3/) bucket to hold photos using the Amplify [Storage](https://aws-amplify.github.io/docs/js/storage) module. Enter the following command and follow the prompts:

``` bash
amplify add storage
```

* Please select from one of the below mentioned services __Content (Images, audio, video, etc.)__
* Please provide a friendly name for your resource that will be used to label this category in the project: __AmplifyPhotosStorage__
* Please provide bucket name: __ACCEPT DEFAULT BUCKET NAME PROVIDED__
* Who should have access: __Auth users only__
* What kind of access do you want for Authenticated users? __create/update, read, delete__
* Do you want to add a Lambda Trigger for your S3 Bucket? __No__

We have now created the CloudFormation templates to provision an Amazon S3 Bucket with appropriate permissions for user uploads. Later, we will deploy in the cloud, connect the bucket to our application, and add a Lambda function that will be triggered when a new photo is added. The function will create a thumbnail of the uploaded image and add [EXIF](https://en.wikipedia.org/wiki/Exif) data to our album.

In the next module, we will build the GraphQL API for our application before pushing updates to the cloud.

**[Adding a GraphQL API >>](../3_API)**