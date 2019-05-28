#!/bin/bash

# run Docker container with image 
# include image-name:tag as argument to script, arg $1

if [ $# -lt 1 ]; then  # if total line args are less than '1'
  printf "\nRequires Docker image id or name:tag as argument.\n\n"
else
  docker run -ti -d -p 8080 $1  # start container as daemon process, open port 8080
  sleep 1
  docker cp ./install.sh $(docker ps -lq):/home  # copy local script in to container
  docker exec -ti $(docker ps -lq) bash -c 'cd /home; exec /bin/bash'  # attach process, enter container, start bash session
fi

