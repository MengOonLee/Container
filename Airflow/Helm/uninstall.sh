#!/bin/bash

microk8s helm3 delete airflow \
--namespace airflow
microk8s kubectl delete -f namespace.yaml
microk8s kubectl delete -f pv_dags.yaml
microk8s helm3 repo rm apache-airflow
