#!/bin/bash
COMPONENT=frontend
source components/common.sh
Print "Installing Nginx"
yum install nginx -y
Stat $?
Print "Starting Nginx Service"
exit
systemctl start nginx
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html || exit
rm -rf *
Stat $?
unzip /tmp/frontend.zip && cd frontend-main/ || exit && mv static/* /usr/share/nginx/html && rm -rf static README.md && mv localhost.conf /etc/nginx/default.d/roboshop.conf
Stat $?
systemctl enable nginx
systemctl restart nginx
Stat $?