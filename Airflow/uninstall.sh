#!/bin/bash

microk8s helm3 delete airflow \
--namespace airflow
microk8s helm3 repo rm apache-airflow
microk8s kubectl delete -f pv-claim.yaml
microk8s kubectl delete -f pv-volume.yaml
microk8s kubectl delete -f namespace.yaml
