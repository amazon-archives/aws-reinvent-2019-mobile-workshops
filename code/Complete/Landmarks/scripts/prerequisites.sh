#!/bin/bash

check_prerequisites() {
  jq --version &>/dev/null
  if [ $? != 0 ];
  then
    echo "You need to install jq to run this script"
    echo "Instructions are here https://stedolan.github.io/jq/download/"
    exit -1
  fi

  aws --version &>/dev/null
  if [ $? != 0 ];
  then
    echo "You need to install aws CLI to run this script"
    echo "Instructions are here https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html"
    exit -1
  fi
}
