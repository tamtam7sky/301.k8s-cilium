#!/usr/bin/bash
set -xeu
set -o pipefail

[ -e init-config.yaml ] && mv init-config.yaml init-config.yaml.old
touch init-config.yaml

# base on `kubeadm config print init-defaults`
cat <<EOF | tee init-config.yaml
apiVersion: kubeadm.k8s.io/v1beta3
bootstrapTokens:
- groups:
  - system:bootstrappers:kubeadm:default-node-token
  token: abcdef.0123456789abcdef
  ttl: 24h0m0s
  usages:
  - signing
  - authentication
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: 192.168.11.100
  bindPort: 6443
nodeRegistration:
  criSocket: unix:///var/run/containerd/containerd.sock
  imagePullPolicy: IfNotPresent
  name: k8s-master
  taints: null
  kubeletExtraArgs:
    node-ip: 192.168.11.100
---
apiServer:
  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta3
certificatesDir: /etc/kubernetes/pki
clusterName: k8s
controllerManager: 
  extraArgs:
    bind-address: 0.0.0.0
dns: {}
etcd:
  local:
    dataDir: /var/lib/etcd
    extraArgs:
      listen-metrics-urls: http://0.0.0.0:2381
imageRepository: registry.k8s.io
kind: ClusterConfiguration
kubernetesVersion: 1.29.0
networking:
  dnsDomain: cluster.local
  serviceSubnet: 10.255.0.0/16
  podSubnet: 10.0.0.0/16
scheduler:
  extraArgs:
    bind-address: 0.0.0.0
EOF

sudo kubeadm reset -f
# Ciliumをkube-proxyの代わりに使うため、kube-proxyはセットアップしない
sudo kubeadm init --config ./init-config.yaml --skip-phases=addon/kube-proxy

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl -n kube-system get cm kubeadm-config -o yaml
kubectl get nodes
