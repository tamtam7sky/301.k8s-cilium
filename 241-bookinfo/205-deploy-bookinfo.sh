#!/usr/bin/bash
set -xeuo pipefail

kubectl create namespace bookinfo
kubectl label namespace bookinfo istio-injection=enabled
kubectl -n bookinfo apply -f bookinfo.yaml


