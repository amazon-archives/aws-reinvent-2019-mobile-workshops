+++
title = "Cleaning Up"
chapter = false
weight = 20
+++

### Deleting via Amplify

Amplify can do a pretty good job of removing most of the cloud resources we've provisioned for this workshop (just by attempting to delete the CloudFormation nested stack it provisioned). However, it will refuse to delete a few items, which we'll manually take care of as well.

1. **From the project directory, run:** `amplify delete` and press *Enter* to confirm the deletion.

2. **Wait** a few minutes while Amplify deletes most of our resources.

### A small bit of manual cleanup

TODO 