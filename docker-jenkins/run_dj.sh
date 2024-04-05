#!/bin/bash

# run jenkins image via docker

# arg 1 = docker image

image=$1
app_home="/var/jenkins_home"

sudo mkdir -p $app_home;
sudo chown -R $USER:$USER $app_home; 
sudo chmod -R 755 $app_home

# [container-port]:[host-port]

docker run --rm -ti --net host -p 8080:8080 -p 50000:50000 --env JENKINS_OPTS=--httpPort=8080 \
-v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} -e ${SSH_AUTH_SOCK} \
-v ${HOME}/.ssh/known_hosts:/etc/ssh/ssh_known_hosts \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-v /var/jenkins_home:/var/jenkins_home \
--name jenkins $image
