#!/bin/bash

microk8s kubectl delete -f deployment.yaml
microk8s kubectl delete -f service.yaml
