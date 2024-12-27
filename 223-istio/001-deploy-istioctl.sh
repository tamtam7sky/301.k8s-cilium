#!/usr/bin/bash
set -xeu
set -o pipefail

curl -sL https://istio.io/downloadIstio | sh -
sudo cp -p  istio-1.22.3/bin/istioctl /usr/local/bin
istioctl version

