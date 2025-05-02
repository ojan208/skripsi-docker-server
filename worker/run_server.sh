#!/bin/bash

SERVER_NAME=$1
MASTER_ADDRESS=$2

if [ -z "${SERVER_NAME}" ] || [ -z "${MASTER_ADDRESS}" ]; 
  then
    echo "you need to supply the server name and the master server address"
    echo "use this command:"
    echo "./[script name] [server name] [master server address]"
    echo "or this if you're running the docker image"
    echo "docker run [image name] [server name] [master server address]"
  else
    # change the variable inside the multipaper config file
    sed -i -e $"s/^  my-name:.*/  my-name: ${SERVER_NAME}/" multipaper.yml
    sed -i -e $"s/^  master-address:.*/  master-address: ${MASTER_ADDRESS}/" multipaper.yml

    echo "server starting"
    java -jar multipaper-1.20.1-57.jar 
fi
