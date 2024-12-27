#!/usr/bin/bash
set -xeuo pipefail

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

echo "INGRESS_HOST: $INGRESS_HOST"
echo "INGRESS_PORT: $INGRESS_PORT"
echo "SECURE_INGRESS_PORT: $SECURE_INGRESS_PORT"

export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

echo "GATEWAY_URL: $GATEWAY_URL"

curl -I http://$GATEWAY_URL/productpage

