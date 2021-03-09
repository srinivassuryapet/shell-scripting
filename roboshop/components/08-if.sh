#!/bin/bash
if [ "$USER" != "root" ] ; then
  echo "Hey, you are not a root user"
fi
if [ -z "$a" ] ; then
  echo "Your variable is empty"
fi
