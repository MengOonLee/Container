#!/bin/bash

microk8s kubectl create -f namespace.yaml
microk8s kubectl create -f pv_backups.yaml
microk8s kubectl create -f pvc_backups.yaml
microk8s kubectl create -f configmap.yaml
microk8s kubectl create -f secret.yaml
microk8s kubectl create -f deployment.yaml
microk8s kubectl create -f service.yaml
