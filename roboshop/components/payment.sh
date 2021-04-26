#!/bin/bash
COMPONENT=payment
source components/common.sh

Print "Installing Python 3"
yum install python36 gcc python3-devel -y
Stat $?

Print "Adding Roboshop user"
id roboshop || useradd roboshop
Stat $?

Print "Downloading the config"
rm -rf /home/roboshop/payment && cd /home/roboshop && curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"
Stat $?
unzip -o /tmp/payment.zip && mv payment-main payment
Stat $?

cd /home/roboshop/payment || exit
Stat $?

pip3 install -r requirements.txt
Stat $?
exit

Print "Starting the service"
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
systemctl daemon-reload && systemctl enable payment && systemctl start payment
Stat $?







