#!/bin/bash

microk8s helm3 repo add neo4j https://helm.neo4j.com/neo4j
microk8s helm3 repo update
microk8s kubectl apply -f namespace.yaml

microk8s helm3 upgrade --cleanup-on-fail \
--install neo4j neo4j/neo4j-standalone \
--values=values.yaml \
--namespace=neo4j \
--debug
