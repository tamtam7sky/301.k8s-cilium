#!/usr/bin/bash
set -xeuo pipefail

NAMESPACE="registry"
CERT="harbor.ca.crt"
LOADBALANCER="192.168.11.128"
SERVER="core.harbor.domain"

# 証明書配置ディレクトリ作成
sudo mkdir -p /usr/share/ca-certificates/harbor

# 証明書ファイル出力
kubectl get secrets -n $NAMESPACE harbor-nginx -o jsonpath='{.data.ca\.crt}' |
      base64 -d |
      sudo tee /usr/share/ca-certificates/harbor/$CERT

# 証明書確認
cat /usr/share/ca-certificates/harbor/$CERT

# ルート証明書一覧更新
echo harbor/$CERT | sudo tee -a /etc/ca-certificates.conf

# ルート証明書再読み込み
sudo update-ca-certificates

# docker 再起動
sudo systemctl restart docker

# Harborの名前解決を設定
echo "$LOADBALANCER  $SERVER" | sudo tee -a /etc/hosts

docker login -u admin https://$SERVER/

