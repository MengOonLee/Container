#!/bin/bash

export REPOSITORY=darklemon
export IMAGE=notebook
export TAG=latest

docker build . --no-cache --pull \
-f Dockerfile \
-t $REPOSITORY/$IMAGE:$TAG
