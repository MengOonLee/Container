#!/bin/bash

docker build . --no-cache \
-f Dockerfile \
-t "test-airflow-dag:local"

docker save test-airflow-dag > test-airflow-dag.tar

microk8s ctr image import test-airflow-dag.tar

microk8s helm3 upgrade airflow apache-airflow/airflow \
--namespace airflow \
--set images.airflow.repository=test-airflow-dag \
--set images.airflow.tag=local