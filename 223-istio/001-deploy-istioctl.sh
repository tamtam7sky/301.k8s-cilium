#!/usr/bin/bash
set -xeuo pipefail

curl -sL https://istio.io/downloadIstio | sh -
sudo cp -p  istio-1.24.2/bin/istioctl /usr/local/bin
istioctl version

