#!/bin/bash
set -e

CONTAINER_NAME="mycontainer-cicd"

echo "Stopping container: $CONTAINER_NAME"
docker stop "$CONTAINER_NAME" || true

echo "Removing container: $CONTAINER_NAME"
docker rm "$CONTAINER_NAME" || true
