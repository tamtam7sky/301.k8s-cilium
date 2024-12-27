#!/usr/bin/bash
set -xeuo pipefail

# kubectl apply -f samples/addons
# kubectl get pod -A
# kubectl rollout status deployment/kiali -n istio-system

# kubectl apply -f ingressgateway-for-http.yaml -n istio-system
# sudo iptables -t nat -A DOCKER ! -i br-ebdf6c44d749 -p tcp --dport 80 -j DNAT --to-destination 172.18.255.201:80
# sudo iptables -t filter -A DOCKER -p tcp  --destination 172.18.255.201 --dport 80 -j ACCEPT



kubectl apply -f vs-for-kiali.yaml -n istio-system

# kubectl -n istio-system patch deployment kiali --patch '{"spec": {"template": {"spec": {"external_services": {"prometheus": {"url": "http://prometheus-stack-kube-prom-prometheus.monitoring.svc.cluster.local:9090/" } } }}}}'


kubectl get gateway,virtualservice -A

kubectl -n istio-system create token kiali-service-account
