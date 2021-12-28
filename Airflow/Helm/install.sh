#!/bin/bash
microk8s helm3 repo add apache-airflow https://airflow.apache.org
microk8s helm3 repo update
microk8s kubectl create -f namespace.yaml
microk8s kubectl create -f secret.yaml

microk8s helm3 install airflow apache-airflow/airflow \
--namespace airflow \
--values override.yaml
