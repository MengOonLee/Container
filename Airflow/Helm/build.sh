#!/bin/bash

docker build . --no-cache \
-f Dockerfile \
-t "darklemon/test-airflow-dag:0.0.1"

docker push darklemon/test-airflow-dag:0.0.1
