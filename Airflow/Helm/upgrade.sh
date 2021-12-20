#!/bin/bash

microk8s helm3 upgrade airflow apache-airflow/airflow \
--namespace airflow \
--set images.airflow.repository=darklemon/test-airflow-dag \
--set images.airflow.tag=0.0.1 \
--set images.airflow.pullPolicy=Always
