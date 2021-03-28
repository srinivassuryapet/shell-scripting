#!/bin/bash
COMPONENT=catalogue
source components/common.sh
Print "Installing nodejs"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding roboshop user"
id roboshop || sudo useradd roboshop
Stat $?

Print "Download Catalogue Code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Stat $?

Print "Extract Catalogue Component Code"
rm -rf /home/roboshop/catalogue && cd /home/roboshop && unzip /tmp/catalogue.zip && mv catalogue-main catalogue && cd /home/roboshop/catalogue
Stat $?
exit

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue

