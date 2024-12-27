#!/usr/bin/bash
set -xeu
set -o pipefail

istioctl install --set profile=demo -y

