#!/usr/bin/bash
set -xeuo pipefail

[ -e init-config.yaml ] && mv init-config.yaml init-config.yaml.old
touch init-config.yaml

# base on `kubeadm config print init-defaults`
cat <<EOF | tee init-config.yaml
apiVersion: kubeadm.k8s.io/v1beta4
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
  imagePullSerial: true
  name: k8s-master
  taints: null
  kubeletExtraArgs:
    - name: node-ip
      value: 192.168.11.100
timeouts:
  controlPlaneComponentHealthCheck: 4m0s
  discovery: 5m0s
  etcdAPICall: 2m0s
  kubeletHealthCheck: 4m0s
  kubernetesAPICall: 1m0s
  tlsBootstrap: 5m0s
  upgradeManifests: 5m0s
---
apiServer:
  #  timeoutForControlPlane: 4m0s
apiVersion: kubeadm.k8s.io/v1beta4
caCertificateValidityPeriod: 87600h0m0s
certificateValidityPeriod: 8760h0m0s
certificatesDir: /etc/kubernetes/pki
clusterName: k8s
controllerManager:
  extraArgs:
    - name: bind-address
      value: 0.0.0.0
dns: {}
encryptionAlgorithm: RSA-2048
etcd:
  local:
    dataDir: /var/lib/etcd
    extraArgs:
      - name: listen-metrics-urls
        value: http://0.0.0.0:2381
imageRepository: registry.k8s.io
kind: ClusterConfiguration
kubernetesVersion: 1.32.0
networking:
  dnsDomain: cluster.local
  serviceSubnet: 10.255.0.0/16
  podSubnet: 10.0.0.0/16
proxy:
  disabled: true   # disable kube-proxy
scheduler:
  extraArgs:
    - name: bind-address
      value: 0.0.0.0
EOF

sudo kubeadm reset -f
# Ciliumをkube-proxyの代わりに使うため、kube-proxyはセットアップしない
# sudo kubeadm init --config ./init-config.yaml --skip-phases=addon/kube-proxy
sudo kubeadm init --config ./init-config.yaml

mkdir -p $HOME/.kube
cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
# sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl -n kube-system get cm kubeadm-config -o yaml
kubectl get nodes

