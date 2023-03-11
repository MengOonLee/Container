#!/bin/bash

export REPOSITORY=darklemon
export IMAGE=tensorflow-cpu
export TAG=latest

docker build . --no-cache --pull \
-f Dockerfile \
-t $REPOSITORY/$IMAGE:$TAG

# docker push $REPOSITORY/$IMAGE:$TAG
