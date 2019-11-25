#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

source ./.env
source ./.password.cfg

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath="${docker_user}/${DOCKER_NAME}:${DOCKER_TAG}"

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker tag ${DOCKER_NAME}:${DOCKER_TAG} ${dockerpath}
docker login -u ${docker_user} -p ${docker_pwd}

# Step 3:
# Push image to a docker repository
docker push ${dockerpath}
