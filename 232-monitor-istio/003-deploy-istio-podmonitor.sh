#!/usr/bin/bash
set -xeuo pipefail

kubectl -n istio-system apply -f prometheus-monitor.yaml

kubectl -n monitoring apply -f grafana-dashboard.yaml
kubectl -n monitoring apply -f deployments-prometheus-stack-grafana.yaml

