#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
source $DIR/prerequisites.sh

check_prerequisites

CODE_DIR=$DIR/../Complete/Landmarks
ENV_NAME=$(cat $CODE_DIR/amplify/.config/local-env-info.json | jq -r '.envName')
PROFILE=$(cat $CODE_DIR/amplify/.config/local-aws-info.json | jq -r ".$ENV_NAME.profileName")
IMAGE_BUCKET=$(cat $CODE_DIR/awsconfiguration.json  | jq -r '.S3TransferUtility.Default.Bucket')

echo "Uploading project images to your S3 bucket : $IMAGE_BUCKET/public"
aws s3 --profile $PROFILE sync $CODE_DIR/Landmarks/Resources/ s3://$IMAGE_BUCKET/public

exit 0
