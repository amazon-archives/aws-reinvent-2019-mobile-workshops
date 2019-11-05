+++
title = "Cleaning Up"
chapter = false
weight = 20
+++

### Deleting via Amplify

Amplify can do a pretty good job of removing most of the cloud resources we've provisioned for this workshop (just by attempting to delete the CloudFormation nested stack it provisioned). However, it will refuse to delete a few items, which we'll manually take care of as well.

### Amplify delete

Let's first capture some information we will need to manually clean resources, and then let's amplify delete everything.  In a Terminal, type:

```bash
# capture a couple of information for manual cleanup 
cd $PROJECT_DIRECTORY
AMPLIFY_BUCKET=$(cat amplify/team-provider-info.json | jq -r .dev.awscloudformation.DeploymentBucketName)
DEPLOYMENT_BUCKET=$(cat awsconfiguration.json | jq -r .S3TransferUtility.Default.Bucket)

# let amplify delete the backend infrastructure
amplify delete
```

**Wait** a few minutes while Amplify deletes most of our resources.

![amplify delete](/images/80-20-amplify-delete.png)

### A small bit of manual cleanup

`amplify delete` deletes most of the infrastructure created.  But it plays it safe by not deleting Amazon S3 buckets where you might have stored additional files.  Should you not ned them anymore, let's delete these now.  In a Terminal, type:

```bash
aws s3 rm --recursive s3://$AMPLIFY_BUCKET
aws s3 rm --recursive s3://$DEPLOYMENT_BUCKET

aws s3 rb s3://$AMPLIFY_BUCKET
aws s3 rb s3://$DEPLOYMENT_BUCKET

rm awsconfiguration.json
```
