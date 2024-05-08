#!/bin/bash

# Install docker rhel|centos - run as 'sudo', requires internet access

# Base
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create docker group
groupadd docker

# Add docker group to current User
usermod -a -G docker $USER  # restart terminal session
# newgrp docker  # effect immediate

# Start docker service
systemctl start docker
systemctl enable docker
