#!/bin/bash

microk8s helm3 delete airflow \
--namespace airflow
microk8s helm3 repo rm apache-airflow
microk8s kubectl delete ns/airflow