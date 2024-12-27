#!/usr/bin/bash
#set -xeuo pipefail

for i in $(seq 1 100); do curl -sS http://192.168.11.128/productpage -o /dev/null; done
# while true; do curl -sS http://172.18.255.200/productpage -o /dev/null; sleep 1; done

