#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
source $DIR/prerequisites.sh

echo "Checking prerequisites"
# check_prerequisites

CODE_DIR=$DIR/../Complete/Landmarks

#
# Retrieve the App Client ID
#
echo "Listing App Clients"
ENV_NAME=$(cat $CODE_DIR/amplify/.config/local-env-info.json | jq -r '.envName')
PROFILE=$(cat $CODE_DIR/amplify/.config/local-aws-info.json | jq -r ".$ENV_NAME.profileName")
USER_POOL_ID=$(cat "$CODE_DIR/awsconfiguration.json"  | jq -r '.CognitoUserPool.Default.PoolId')
REGION=$(cat "$CODE_DIR/awsconfiguration.json"  | jq -r '.CognitoUserPool.Default.Region')

USER_POOL_CLIENT=$(aws cognito-idp list-user-pool-clients --region $REGION                       \
                                                          --profile $PROFILE                     \
                                                          --user-pool-id $USER_POOL_ID           \
                                                          --query 'UserPoolClients[].ClientName' \
                                                          --output table | grep Web | sed -e 's/|  //' | sed -e 's/  |//' )
CLIENT_ID=$(aws cognito-idp list-user-pool-clients --region $REGION                       \
                                                   --profile $PROFILE                     \
                                                   --user-pool-id $USER_POOL_ID           \
                                                   --query "UserPoolClients[?ClientName=='${USER_POOL_CLIENT}'].ClientId" \
                                                   --output text )

Echo "Client ID = $CLIENT_ID"
