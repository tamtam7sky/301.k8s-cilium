#!/usr/bin/bash
set -xeuo pipefail

kubectl create ns monitoring
helm repo add prometheus-community	https://prometheus-community.github.io/helm-charts
helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring -f ./kube-prometheus-stack.yaml
