#!/bin/bash

# centos_x, rhel_x

yum -y update && yum -y upgrade
yum install -y vim tree wget mlocate traceroute
yum install -y epel-release  # EPEL
yum install -y e2fsprogs  # tune2fs
yum install -y vim-common  # vi
yum install -y iputils  # ping
yum install -y net-tools  # ifconfig, netstat
yum install -y bind-utils  # nslookup

## DEPRECATED
#yum install -y python36
#pip3 install --upgrade pip

