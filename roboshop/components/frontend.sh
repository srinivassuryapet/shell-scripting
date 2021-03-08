#!/bin/bash
yum install nginx -y
systemctl enable nginx
systemctl start nginx
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html || exit
rm -rf *
unzip /tmp/frontend.zip
mv static/* .
rm -rf static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx