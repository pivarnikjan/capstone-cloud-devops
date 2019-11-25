#!/usr/bin/env bash

## Complete the following steps to get Docker running locally
source ./.env

# Step 1:
# Build image and add a descriptive tag
docker build -t ${DOCKER_NAME}:${DOCKER_TAG} .

# Step 2: 
# List docker images
docker images

# Step 3: 
# Run flask app
#docker run -it --name machine-learning-ms-api -p 8000:80 machine-learning-ms:1.0 bash
docker run --detach --name ${DOCKER_NAME} -p 5000:5000 ${DOCKER_NAME}:${DOCKER_TAG}
