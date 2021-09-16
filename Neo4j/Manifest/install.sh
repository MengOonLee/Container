#!/bin/bash

microk8s kubectl apply -f namespace.yaml
microk8s kubectl apply -f pv-neo4j-backup.yaml
microk8s kubectl apply -f pvc-neo4j-backup.yaml
microk8s kubectl apply -f deployment.yaml
microk8s kubectl apply -f service.yaml
