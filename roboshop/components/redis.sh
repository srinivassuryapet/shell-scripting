#!/bin/bash
COMPONENT=redis
source components/common.sh

yum install epel-release yum-utils -y
Stat $?

yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
Stat $?

yum-config-manager --enable remi && yum install redis -y
Stat $?

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
Stat $?

Print "Start Redis"
systemctl enable redis && systemctl start redis
Stat $?
