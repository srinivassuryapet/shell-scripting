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
cd /home/roboshop && curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
Stat $?
unzip -o /tmp/shipping.zip
mv shipping-main shipping && cd shipping || exit

mvn clean package
mv target/shipping-1.0.jar shipping.jar
Stat $?

Print "Copy the service file and start the service."
#cp /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
sed -i -e 's/CARTENDPOINT/cart-ss.srinivassuryapet.ml/' -e  /home/roboshop/shipping/systemd.service && mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service

Print "Restart Service"
systemctl daemon-reload && systemctl start shipping && systemctl enable shipping
Stat $?