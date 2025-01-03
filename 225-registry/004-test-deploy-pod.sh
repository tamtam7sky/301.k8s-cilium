#!/usr/bin/bash
set -xeuo pipefail

# kubectl create secret generic < secret名 >
# --from-file：ホームディレクトリ配下の .docker/config.json を指定
kubectl create secret generic harborcred \
	--type=kubernetes.io/dockerconfigjson \
	--from-file=.dockerconfigjson=/home/taro/.docker/config.json \
	-n default

# 登録した Secret 確認
kubectl describe secret -n default harborcred

# デプロイ
cat <<EOF| kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: busybox
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "3600"
    image: core.harbor.domain/sandbox/busybox:1.37.0
    name: busybox
  imagePullSecrets:
  - name: harborcred
EOF

kubectl -n default describe pod busybox

