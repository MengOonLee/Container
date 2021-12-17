#!/bin/bash

microk8s kubectl create -f namespace.yaml
microk8s kubectl create -f pv_workspace.yaml
microk8s kubectl create -f pvc_workspace.yaml
microk8s kubectl create -f deployment.yaml
microk8s kubectl create -f service.yaml