#!/bin/bash

ID=118755950356
REGION=eu-north-1
REGISTRY_NAME=docker_images
IMAGE_TAG=latest
PORT=8080
IMAGE_NAME="$ID".dkr.ecr."$REGION".amazonaws.com/"$REGISTRY_NAME":"$IMAGE_TAG"

# Add Docker's official GPG key:
sudo apt update
sudo apt install -y --no-install-recommends ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# Install Docker
sudo apt update && \
sudo apt install -y --no-install-recommends docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
sudo systemctl start docker

# Get credentials and authenticate the registry
aws ecr get-login-password --region "$REGION" | \
sudo docker login --username AWS --password-stdin "$ID".dkr.ecr."$REGION".amazonaws.com

# Pull the image from the repository and run the container
sudo docker pull "$ID".dkr.ecr."$REGION".amazonaws.com/"$REGISTRY_NAME":"$IMAGE_TAG"
sudo docker run -d --rm -p "$PORT":"$PORT" "$IMAGE_NAME"
