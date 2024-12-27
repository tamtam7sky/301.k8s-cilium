#!/usr/bin/bash
set -xeu
set -o pipefail

kubectl apply -f gw.yaml -n istio-system

# sudo apt update
# sudo apt install -y jq
# 
# BRIDGE="br-"$(docker network ls --filter Name=kind --format json | jq -r '."ID"')
# HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
# 
# sudo iptables -t nat -A DOCKER ! -i $BRIDGE -p tcp --dport 80 -j DNAT --to-destination $HOST:80
# sudo iptables -t filter -A DOCKER -p tcp  --destination $HOST --dport 80 -j ACCEPT

