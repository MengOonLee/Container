#!/bin/bash

microk8s helm3 repo add apache-airflow https://airflow.apache.org
microk8s helm3 repo update
microk8s kubectl apply -f namespace.yaml
microk8s kubectl apply -f pv_dags.yaml
microk8s kubectl apply -f pvc_dags.yaml

microk8s helm3 upgrade --cleanup-on-fail \
--install airflow apache-airflow/airflow \
--namespace airflow \
--values values.yaml \
--debug
