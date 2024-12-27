#!/usr/bin/bash
set -xeuo pipefail

kubectl -n kube-system apply -f vs.yaml

