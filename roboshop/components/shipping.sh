#!/bin/bash
COMPONENT=shipping
source components/common.sh

Print "Installing maven"
yum install maven -y
Stat $?


Print "Adding roboshop user"
id roboshop || useradd roboshop
Stat $?



Print "Download the shipping code"
curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
Stat $?

Print "Unzipping the contents of shipping code"
rm -rf /home/roboshop/shipping
cd /home/roboshop && unzip -o /tmp/shipping.zip && mv shipping-main shipping
Stat $?

Print "mvn clean package"
cd /home/roboshop/shipping && mvn clean package && mv target/shipping-1.0.jar shipping.jar
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Copy the service file and start the service."
sed -i -e 's/CARTENDPOINT/cart-ss.srinivassuryapet.ml/' -e 's/DBHOST/mysql-ss.srinivassuryapet.ml/' /home/roboshop/shipping/systemd.service && mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

Print "Restart Service"
systemctl daemon-reload && systemctl start shipping && systemctl enable shipping
Stat $?