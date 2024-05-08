#!/bin/bash

# Start docker container w/ jenkins image

# arg 1 = jenkins image

image=$1
HOST_HOME="/home/jenkins_home"

# Directory, User permission
mkdir -p $HOST_HOME;
chown -R $USER:$USER $HOST_HOME; 
chmod -R 755 $HOST_HOME

# [host]:[container]

docker run --rm -ti --net host -p 8080:8080 -p 50000:50000 --env JENKINS_OPTS=--httpPort=8080 \
-v ${SSH_AUTH_SOCK}:${SSH_AUTH_SOCK} -e ${SSH_AUTH_SOCK} \
-v ${HOME}/.ssh/known_hosts:/etc/ssh/ssh_known_hosts \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(which docker):/usr/bin/docker \
-v $HOST_HOME:/var/jenkins_home \
--name jenkins $image
