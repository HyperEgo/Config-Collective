#!/bin/bash

# docker startup, fedora

#yum -y update && yum -y upgrade
yum -y update
yum install -y vim
yum install -y tree
yum install -y wget
yum install -y epel-release  # EPEL repo
yum install -y e2fsprogs  # tune2fs
yum install -y traceroute
#yum install -y python36
#pip3 install --upgrade pip
