# run Docker container, local shared volume, Ubuntu 14.04

docker run -p 8080 -ti -v /home/ninjaboy/docker-shared:/home -w /home ubuntu:14.04 bash
