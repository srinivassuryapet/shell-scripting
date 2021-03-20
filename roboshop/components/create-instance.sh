#!/bin/bash
component=$1

if [ -z "${component}" ]; then
  echo "Provide Input of component name"
  exit 1
fi

aws ec2 run-instances --launch-template LaunchTemplateId=lt-00737ccd643dcd705 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}}]"