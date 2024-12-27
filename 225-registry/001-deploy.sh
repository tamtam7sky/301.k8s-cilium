#!/usr/bin/bash
set -xeuo pipefail

NAMESPACE="registry"

kubectl apply -f pv.yaml
helmfile apply
kubectl apply -f gw.yaml

kubectl get secrets -n $NAMESPACE harbor-nginx -o jsonpath='{.data.ca\.crt}' | base64 -d > harbor.ca.crt
