#!/bin/bash

 if [ "$(id -u)" != "0" ]; then  
   echo "This script must be run as root or with sudo cmd" 1>&2  
   exit 1  
 fi  


cd /home/ubuntu
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i -E ./amazon-cloudwatch-agent.deb
cd  /opt/aws/amazon-cloudwatch-agent/bin/
wget https://raw.githubusercontent.com/WarisBishnoi/personal/master/config.json
chmod +x /opt/aws/amazon-cloudwatch-agent/bin/config.json
chown ubuntu:ubuntu /opt/aws/amazon-cloudwatch-agent/bin/config.json
 /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
ech "************************end*******************"
