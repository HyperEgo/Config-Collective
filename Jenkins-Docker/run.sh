#!/bin/bash

# Start docker container w/ jenkins image

# arg 1 = jenkins image

image=$1
app_home="/var/jenkins_home"

# Directory, User permission
sudo mkdir -p $app_home;
sudo chown -R $USER:$USER $app_home; 
sudo chmod -R 755 $app_home

# Docker container execution
# Port assignment => -p [host-os-port]:[container-port]
# Shared volume => -v [host-os-volume]:[container-volume]

docker run --rm -ti --net host -p 8080:8080 -p 50000:50000 --env JENKINS_OPTS=--httpPort=8080 \
-v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} -e ${SSH_AUTH_SOCK} \
-v ${HOME}/.ssh/known_hosts:/etc/ssh/ssh_known_hosts \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-v $app_home:$app_home \
--name jenkins $image
