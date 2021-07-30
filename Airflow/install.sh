#!/bin/bash

microk8s helm3 repo add apache-airflow https://airflow.apache.org
microk8s helm3 repo update
microk8s kubectl create namespace airflow

microk8s helm3 upgrade --cleanup-on-fail \
--install airflow apache-airflow/airflow \
--namespace airflow \
--values values.yaml \
--set images.airflow.repository=darklemon/airflow \
--set images.airflow.tag=latest \
--set images.airflow.pullPolicy=Always \
--debug
