#!/bin/bash
COMPONENT=user
source components/common.sh
Print "Installing nodejs"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding roboshop user"
id roboshop || useradd roboshop
Stat $?

Print "Download User Code"
curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
Stat $?

Print "Extract User Component Code"
rm -rf /home/roboshop/user && cd /home/roboshop/ && unzip -o /tmp/user.zip && mv user-main user && cd user
Stat $?

Print "Install nodejs dependencies"
npm install --unsafe-perm
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Update SystemD script for user"
sed -i -e 's/MONGO_DNSNAME/mongodb-ss.srinivassuryapet.ml/' -e 's/REDIS_ENDPOINT/redis-ss.srinivassuryapet.ml/' /home/roboshop/user/systemd.service && mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
Stat $?

Print "Start user service"
systemctl daemon-reload && systemctl restart user && systemctl enable user
Stat $?