#!/bin/bash
set -e

CONTAINER_NAME="mycontainer-cicd"

echo "Stopping and removing container: $CONTAINER_NAME"

if docker ps -q -f name="$CONTAINER_NAME" | grep -q .; then
  docker stop "$CONTAINER_NAME"
  docker rm "$CONTAINER_NAME"
else
  echo "No running container named $CONTAINER_NAME found."
fi
