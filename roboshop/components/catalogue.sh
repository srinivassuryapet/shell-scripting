#!/bin/bash
COMPONENT=catalogue
source components/common.sh
Print "Installing nodejs"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding roboshop user"
id roboshop || useradd roboshop
Stat $?

Print "Download Catalogue Code"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
Stat $?

Print "Extract Catalogue Component Code"
rm -rf /home/roboshop/catalogue && mkdir -p /home/roboshop/catalogue && cd /home/roboshop/catalogue && unzip /tmp/catalogue.zip
Stat $?
exit

Print "Install nodejs dependencies"
npm install --unsafe-perm
Stat $?

Print "Update SystemD script for catalogue"
sed -i -e "s/MONGO_DNSNAME/mongodb-ss.srinivassuryapet.ml/" /home/roboshop/catalogue/systemd.service && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
Stat $?

Print "Start catalogue service"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue
Stat $?

