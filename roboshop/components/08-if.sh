#!/bin/bash
if [ "$USER" != "root" ] ; then
  echo "Hey, you are not a root user"
fi

read -p "Enter your name =" name

if [ -z "$name" ] ; then
  echo "You have not entered any name"
else
  echo "$name, welcome"
fi


