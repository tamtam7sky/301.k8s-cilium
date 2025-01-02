#!/usr/bin/env bash
set -xeuo pipefail

KUBE_VERSION="v1.32"
# KUBE_VERSION="v1.30"

sudo apt update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

curl -fsSL https://pkgs.k8s.io/core:/stable:/${KUBE_VERSION}/deb/Release.key |
	sudo gpg --yes --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${KUBE_VERSION}/deb/ /" |
       sudo tee /etc/apt/sources.list.d/kubernetes.list


sudo apt-mark unhold kubelet kubeadm kubectl
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo apt install -y bash-completion

COMMAND="source <(kubectl completion bash)"
if ! grep -q "$COMMAND" ~/.bashrc
then
	echo "$COMMAND" | tee -a ~/.bashrc
fi

kubectl completion bash |
	sudo tee /etc/bash_completion.d/kubectl

COMMAND="alias k=kubectl"
if ! grep -q "$COMMAND" ~/.bashrc
then
	echo "$COMMAND" | tee -a ~/.bashrc
fi

COMMAND="complete -F __start_kubectl k"
if ! grep -q "$COMMAND" ~/.bashrc
then
	echo "$COMMAND" | tee -a ~/.bashrc
fi
