#!/usr/bin/bash
set -xeuo pipefail

kubectl apply -f bookinfo-vs.yaml
kubectl get vs -A

