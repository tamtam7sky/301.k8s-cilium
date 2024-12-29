#!/usr/bin/bash
set -xueo pipefail

helmfile apply
k -n kube-system apply -f 
kubectl -n kube-system apply -f ./l2AnnouncementPolicy.yaml ./lbIPPool.yaml

# test
kubectl -n kube-system apply -f nginx.yaml
curl http://192.168.11.128/
kubectl -n kube-system delete -f ./nginx.yaml
