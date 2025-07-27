#!/bin/bash
set -e
AWS_REGION="ap-south-1"
ACCOUNT_ID="156916773321"
REPO_NAME="pooja/rails_app"
IMAGE_TAG="latest"
CONTAINER_NAME="mycontainer-cicd"
IMAGE_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}"


echo "Logging into AWS ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Pulling image: $IMAGE_URI"
docker pull $IMAGE_URI

echo "Fetching RAILS_MASTER_KEY from SSM..."
export RAILS_MASTER_KEY=$(aws ssm get-parameter \
  --name "/pooja-cicd/master.key" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text)

echo "Stopping any existing container..."
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Running container..."
docker run -d \
  -e RAILS_MASTER_KEY="$RAILS_MASTER_KEY" \
  -e RAILS_ENV=production \
  -p 3000:3000 \
  --name "$CONTAINER_NAME" \
  "$IMAGE_URI"

echo "Container started."







