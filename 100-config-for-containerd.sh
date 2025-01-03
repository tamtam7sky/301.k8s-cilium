#!/usr/bin/env bash
set -xeuo pipefail

cat <<EOF | sudo tee -a /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# カーネルパラメーターの設定
cat <<EOF | sudo tee -a /etc/sysctl.d/20-k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# カーネルパラメーターを適用
sudo sysctl --system
