#!/bin/bash

microk8s kubectl delete -f deployment.yaml
microk8s kubectl delete -f service.yaml
microk8s kubectl delete -f pvc-neo4j-backup.yaml
microk8s kubectl delete -f pv-neo4j-backup.yaml
microk8s kubectl delete -f namespace.yaml
