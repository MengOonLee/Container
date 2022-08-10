#!/bin/bash

microk8s kubectl delete -f namespace.yaml
microk8s kubectl delete -f pv_backups.yaml
