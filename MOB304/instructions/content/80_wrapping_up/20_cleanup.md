+++
title = "Cleaning Up"
chapter = false
weight = 20
+++

### Deleting via Amplify

Amplify does a pretty good job of removing the cloud resources we've provisioned for this workshop (just by attempting to delete the CloudFormation nested stack it provisioned)

Let's amplify delete everything.  In a Terminal, type:

```bash
cd $PROJECT_DIRECTORY

# let amplify delete the backend infrastructure
amplify delete
```

**Wait** a few minutes while Amplify deletes all our resources.

![amplify delete](/images/80-20-amplify-delete.png)

Thank you for having follwed this workshop instruction until the end.  Please le us know your feedback by opening an issue or a pull request on our [GitHub repository](https://TODO).