#!/bin/bash
set -e
CONTAINER_NAME="mycontainer-cicd"

echo "Stopping container"
docker stop "$CONTAINER_NAME" || true

echo "Removing container"
docker rm "$CONTAINER_NAME" || true
