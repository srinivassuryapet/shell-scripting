#!/bin/bash
COMPONENT=frontend
source components/common.sh
Print "Installing Nginx"
yum install nginx -y
Stat $?
Print "Starting Nginx Service"
systemctl start nginx
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
cd /usr/share/nginx/html && rm -rf *
Stat $?
unzip /tmp/frontend.zip && mv frontend-main/* . && mv static/* . && rm -rf frontend-master README.md && mv localhost.conf /etc/nginx/default.d/roboshop.conf
Stat $?
systemctl enable nginx
systemctl restart nginx
Stat $?