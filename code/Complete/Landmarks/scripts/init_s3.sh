#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
source $DIR/prerequisites.sh

check_prerequisites

IMAGE_BUCKET=$(cat awsconfiguration.json  | jq -r '.S3TransferUtility.Default.Bucket')

echo "Uploading project images to your S3 bucket : $IMAGE_BUCKET/public"
aws s3 sync ./Landmarks/Resources/ s3://$IMAGE_BUCKET/public

exit 0
