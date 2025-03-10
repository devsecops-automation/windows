#!/bin/bash

INSTANCE_ID=$(terraform output -raw instance_id)
REGION=$(terraform output -raw region)
UNIQUE_NAME=$(terraform output -raw unique_name)

aws ec2 get-password-data --instance-id "${INSTANCE_ID}" --region "${REGION}" --priv-launch-key ./"${UNIQUE_NAME}".pem > ./"password-${UNIQUE_NAME}".json
