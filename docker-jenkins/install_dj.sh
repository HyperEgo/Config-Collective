#!/bin/bash

# install docker rhel|centos - run as 'sudo'

# base install seq
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# create docker group
groupadd docker

# add user to docker group
usermod -aG docker $USER  # affect: restart terminal session
# newgrp docker  # affect: auto add instance

# start docker service
systemctl start docker
systemctl enable docker
