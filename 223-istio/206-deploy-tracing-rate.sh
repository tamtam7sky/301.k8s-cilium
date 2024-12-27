#!/usr/bin/bash
set -xeuo pipefail

istioctl install --set profile=demo -f ./tracing.yaml -y

