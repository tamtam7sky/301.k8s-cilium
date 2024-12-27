#!/usr/bin/bash
set -xeuo pipefail


kubectl apply -f vs.yaml -n monitoring


kubectl get gateway,virtualservice -A


# on Mac
# echo "192.168.11.100    prometheus.geekom" | sudo tee -a /etc/hosts
# curl http://prometheus.geekom/
#
# echo "192.168.11.100    grafana.geekom" | sudo tee -a /etc/hosts
# curl http://grafana.geekom/

