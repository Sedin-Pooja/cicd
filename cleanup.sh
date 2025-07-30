#!/bin/bash
set -e
TARGET_DIR="/home/ec2-user/cicd"

echo "Fixing ownership perm"
sudo chown -R ec2-user:ec2-user "$TARGET_DIR"

echo "Cleaning up old files"
rm -rf "$TARGET_DIR"/{*,.*}