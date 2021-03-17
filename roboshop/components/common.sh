#!/bin/bash
#validate user is a root user or not
USER_ID=$(id -u)
if [ "$USER_ID" -ne 0 ]; then
  echo "you must be a root user to execute this script"
  exit 1
fi
#Linux based output
#Print() {
#  echo -e "$(date +%c) $(hostname) ${COMPONENT} :: $1",
#}
#Maven based output

Print() {
  echo -e "[INFO]-------------------< $1 >------------------------"
  echo -e "[INFO]$2"
  echo -e "[INFO]-------------------------------------------------"
}