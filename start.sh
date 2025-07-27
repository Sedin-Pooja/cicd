#!/bin/bash
set -e
AWS_REGION="ap-south-1"
ACCOUNT_ID="156916773321"
REPO_NAME="pooja/rails_app"
IMAGE_TAG="latest"
CONTAINER_NAME="mycontainer-cicd"
IMAGE_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${REPO_NAME}:${IMAGE_TAG}"
APP_DIR="/home/ec2-user/cicd"
MASTER_KEY_PATH="$APP_DIR/config/master.key"


echo "Logging into AWS ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "Pulling image: $IMAGE_URI"
docker pull $IMAGE_URI

echo "Fetching RAILS_MASTER_KEY from SSM..."
#to get master.key from ssm
RAILS_MASTER_KEY=$(aws ssm get-parameter \
  --name "/pooja-cicd/master.key" \
  --with-decryption \
  --query "Parameter.Value" \
  --output text)

mkdir -p "$APP_DIR/config"
chmod 755 "$APP_DIR/config"
chown ec2-user:ec2-user "$APP_DIR/config"


echo "$RAILS_MASTER_KEY" > "$MASTER_KEY_PATH"
chmod 600 "$MASTER_KEY_PATH"

echo "Running Docker container..."

docker run -d \
  -v "$MASTER_KEY_PATH":/app/config/master.key \
  -e RAILS_ENV=production \
  -p 3000:3000 \
  --name "$CONTAINER_NAME" \
  "$IMAGE_URI"

echo "Container started."







