#!/bin/sh
set -xe
REGISTRY=${REGISTRY:-merapar}
NAME=jenkins-container
docker push $REGISTRY/$NAME
