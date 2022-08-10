#!/bin/bash

docker run --rm -it -p 8978:8978 -v $PWD/cloudbeaver/workspace:/opt/cloudbeaver/workspace dbeaver/cloudbeaver:latest