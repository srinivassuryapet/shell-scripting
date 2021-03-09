#!/bin/bash
set -e
yum install nginx -y
systemctl enable nginx
systemctl start nginx
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html || exit
rm -rf *
unzip /tmp/frontend.zip
cd frontend-main/ || exit
mv static/* /usr/share/nginx/html
rm -rf static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx