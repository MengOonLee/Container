#!/bin/bash

docker run --gpus all --rm -it -p 8888:8888 -v $PWD:/home/meng/work darklemon/notebook-gpu:latest
