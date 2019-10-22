#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
source $DIR/prerequisites.sh

echo "Checking prerequisites"
check_prerequisites

#
# Create an App Client in the user pool to allow programmatic access (Client Credentials flow)
#
# https://aws.amazon.com/blogs/mobile/understanding-amazon-cognito-user-pool-oauth-2-0-grants/
# https://docs.aws.amazon.com/en_pv/cognito/latest/developerguide/token-endpoint.html
#
echo "Getting an access token"
USER_POOL_ID=$(cat awsconfiguration.json  | jq -r '.CognitoUserPool.Default.PoolId')
# create a temporary resource server.  This is mandatory for client_credentials grants
aws cognito-idp create-resource-server --user-pool-id $USER_POOL_ID               \
                                       --name APIResourceServer                   \
                                       --identifier API                           \
                                       --scopes "ScopeName=all,ScopeDescription=Full API Access" > /dev/null
# create a temporary app client to accept client_credentials request from this script
aws cognito-idp create-user-pool-client --user-pool-id $USER_POOL_ID              \
                                        --client-name temp_client_for_cli         \
                                        --generate-secret                         \
                                        --allowed-o-auth-flows client_credentials \
                                        --allowed-o-auth-flows-user-pool-client   \
                                        --allowed-o-auth-scopes API/all > temp.json

CLIENT_ID=$(cat temp.json | jq -r '.UserPoolClient.ClientId')
CLIENT_SECRET=$(cat temp.json | jq -r '.UserPoolClient.ClientSecret')

#
# Call Cognito to get an access token, allowing us to call AppSync API
#
WEBDOMAIN=$(cat awsconfiguration.json  | jq -r '.Auth.Default.OAuth.WebDomain')
BASIC=$(echo -n $CLIENT_ID:$CLIENT_SECRET | base64)
AUTHENTICATION="Basic $BASIC"

echo CLIENT_ID=$CLIENT_ID
echo CLIENT_SECRET=$CLIENT_SECRET
echo AUTHENTICATION=$AUTHENTICATION
curl -X POST -s                                                                  \
     -o token.json                                                             \
     -H "Content-Type: application/x-www-form-urlencoded"                      \
     -H "Authorization: $AUTHENTICATION"                                       \
     --data "grant_type=client_credentials&client_id=$CLIENT_ID&scope=API/all" \
     https://$WEBDOMAIN/oauth2/token

TOKEN=$(cat token.json | jq -r '.access_token')

#
# Call app AppSync API to import demo app data
#

echo "Importing Data"

# prepare the payload
GRAPHQL_PAYLOAD='{
    "query" :
      "mutation CreateLandmark($input: CreateLandmarkInput!) {
          createLandmark(input: $input) {
            id
          }
       }",
     "operationName":"CreateLandmark",
     "variables":{
       "input": {}
     }
   }'
echo -n $GRAPHQL_PAYLOAD > graphql.json
LANDMARKS_LIST=$(cat Landmarks/Resources/landmarkData.json)
LANDMARKS_LIST_LENGTH=$(echo "${LANDMARKS_LIST}" | jq -rc 'length')

API_ENDPOINT=$(cat awsconfiguration.json  | jq -r '.AppSync.Default.ApiUrl')

# for each entry in landmarks file, call the API to insert the data in the DB
for ((i=0; i<$LANDMARKS_LIST_LENGTH; i++)); do
  LANDMARK=$(echo $LANDMARKS_LIST | jq -r ".[$i]")
  API_DATA=$(jq -r ".variables.input +=  $LANDMARK" graphql.json)
  curl $API_ENDPOINT  -s                   \
       -H "Content-Type: application/json" \
       -H "Authorization: $TOKEN"          \
       --data "$API_DATA"
  echo ""
done

# clean up
echo "Cleaning up"
aws cognito-idp delete-user-pool-client --user-pool-id $USER_POOL_ID --client-id $CLIENT_ID
aws cognito-idp delete-resource-server --user-pool-id $USER_POOL_ID --identifier API
rm temp.json token.json graphql.json

Echo "Done - success"
