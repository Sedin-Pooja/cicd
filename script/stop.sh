#!/bin/bash
set -e
CONTAINER_NAME="mycontainer-cicd"
echo "Stopping container: $CONTAINER_NAME"
CONTAINER_NAME="my-container-name"

echo "removing container: $CONTAINER_NAME"
docker rm "$CONTAINER_NAME"
