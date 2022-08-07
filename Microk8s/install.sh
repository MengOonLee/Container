#!/bin/bash

sudo snap install microk8s \
--classic \
--channel=latest/stable

sudo apt-get install -y iptables-persistent
sudo iptables -P FORWARD ACCEPT

sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
su - $USER

microk8s status --wait-ready
microk8s enable dns helm3 hostpath-storage
microk8s inspect
