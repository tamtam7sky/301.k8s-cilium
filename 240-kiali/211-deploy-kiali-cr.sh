#!/usr/bin/bash
set -xeuo pipefail

kubectl apply -f kiali-cr.yaml -n istio-system


#  kubectl -n istio-system create token kiali-service-account
COMMAND="alias create-token-kiali=\"kubectl -n istio-system create token kiali-service-account\""
! $(grep -q "$COMMAND" ~/.bashrc) && echo $COMMAND | tee -a ~/.bashrc

