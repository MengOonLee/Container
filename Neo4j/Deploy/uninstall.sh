#!/bin/bash

microk8s helm3 uninstall neo4j \
--namespace=neo4j
microk8s helm3 repo rm neo4j
microk8s kubectl delete -f namespace.yaml
