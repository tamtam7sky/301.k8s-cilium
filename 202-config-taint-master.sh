#!/usr/bin/env bash
set -xeuo pipefail

kubectl taint nodes k8s-master  node-role.kubernetes.io/control-plane:NoSchedule-
kubectl taint nodes k8s-master  node-role.kubernetes.io/master:NoSchedule-
