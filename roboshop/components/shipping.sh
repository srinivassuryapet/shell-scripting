#!/bin/bash
COMPONENT=shipping
source components/common.sh

Print "Installing maven"
yum install maven -y


Print "Adding roboshop user"
id roboshop || useradd roboshop
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Download the repo"
rm -rf /home/roboshop/shipping
cd /home/roboshop || exit
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
Stat $?
unzip -o /tmp/shipping.zip
cd /home/roboshop/shipping || exit
mv shipping-main shipping

mvn clean package
mv target/shipping-1.0.jar shipping.jar
Stat $?

Print "Copy the service file and start the service."
cp /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

Print "Restart Service"
systemctl daemon-reload && systemctl start shipping && systemctl enable shipping
Stat $?