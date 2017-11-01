#!/bin/sh
set -xe
REGISTRY=${REGISTRY:-merapar}
NAME=jenkins-container
TAG="2.87"
echo "Building docker for $REGISTRY/$NAME:$TAG"
docker build -t $REGISTRY/$NAME:$TAG .
docker tag $REGISTRY/$NAME:$TAG $REGISTRY/$NAME:latest
