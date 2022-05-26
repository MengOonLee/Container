#!/bin/bash

docker run --gpus all --rm -it -p 8888:8888 -v $PWD:/notebook darklemon/notebook:latest