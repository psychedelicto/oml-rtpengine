#!/bin/bash

echo "************************* yum update and install kernel-devel ***********************************"
echo "************************* yum update and install kernel-devel ***********************************"
yum update -y && yum install kernel-devel -y

echo "******************** prereq selinux and firewalld ***************************"
echo "******************** prereq selinux and firewalld ***************************"
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
systemctl disable firewalld
setenforce 0

echo "******************** yum install rtpengine ***************************"
echo "******************** yum install rtpwngine ***************************"
yum install epel-release -y && yum install -y curl libpcap hiredis xmlrpc-c-client json-glib libevent http://freetech.com.ar/rpms/rtpengine-5.5.3.1-1.x86_64.rpm vim

echo "************************* Discover IPs ***********************************"
echo "************************* Discover IPs ***********************************"
PUBLIC_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/public/0/ipv4/address)
PRIVATE_IPV4=$(curl -s http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address)

echo "OPTIONS="-i $PUBLIC_IPV4  -o 60 -a 3600 -d 30 -s 120 -n $PRIVATE_IPV4:22222 -m 20000 -M 50000 -L 7 --log-facility=local1""  > /etc/rtpengine-config.conf

echo "************************* Enable and Start RTPENGINE ***********************************"
echo "************************* Enable and Start RTPENGINE ***********************************"
systemctl enable rtpengine && systemctl start rtpengine

reboot
