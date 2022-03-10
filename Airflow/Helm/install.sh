#!/bin/bash

# export REPOSITORY="darklemon"
# export IMAGE="airflow"
# export TAG="latest"

# docker build . --no-cache \
# -f Dockerfile \
# -t $REPOSITORY/$IMAGE:$TAG

# docker push $REPOSITORY/$IMAGE:$TAG

microk8s helm3 repo add apache-airflow https://airflow.apache.org
microk8s helm3 repo update
microk8s helm3 show values apache-airflow/airflow > values.yaml

microk8s kubectl create -f namespace.yaml
microk8s kubectl create -f pv_dags.yaml
microk8s kubectl create -f pvc_dags.yaml
microk8s kubectl create -f secret.yaml

microk8s helm3 upgrade \
--install airflow apache-airflow/airflow \
--namespace airflow \
-f override.yaml
