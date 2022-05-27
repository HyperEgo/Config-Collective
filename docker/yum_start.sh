#!/bin/bash

# yum install - partial, quick test - Fedora distros

#yum -y update && yum -y upgrade
yum -y update  # 'update' only, no 'upgrade'
yum install -y vim
yum install -y tree
yum install -y wget
yum install -y epel-release  # EPEL repo
yum install -y e2fsprogs  # tune2fs
yum install -y traceroute
#yum install -y python36
#pip3 install --upgrade pip
