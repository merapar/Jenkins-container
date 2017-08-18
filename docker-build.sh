#!/bin/sh
set -xe
REGISTRY=${REGISTRY:-merapar}
NAME=jenkins-container
TAG="2.60.2"
echo "Building docker for $REGISTRY/$NAME:$TAG"
docker build -t $REGISTRY/$NAME:$TAG .
docker tag $REGISTRY/$NAME:$TAG $REGISTRY/$NAME:latest
