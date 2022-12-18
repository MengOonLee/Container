#!/bin/bash

docker run --rm -it -p 8888:8888 -v $PWD:/home/meng/work darklemon/notebook-cpu:latest
