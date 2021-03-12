#!/bin/bash
#validate user is a root user or not
USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo "you must be a root user to execute this script"
  exit 1
fi