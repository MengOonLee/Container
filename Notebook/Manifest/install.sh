#!/bin/bash

microk8s kubectl create -f namespace.yaml
microk8s kubectl create -f pv_work.yaml
microk8s kubectl create -f pvc_work.yaml
microk8s kubectl create -f deployment.yaml
microk8s kubectl create -f service.yaml
