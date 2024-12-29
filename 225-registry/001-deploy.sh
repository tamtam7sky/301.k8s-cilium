#!/usr/bin/bash
set -xeuo pipefail

NAMESPACE="registry"

kubectl apply -f pv.yaml
helmfile apply
kubectl apply -f gw.yaml

kubectl get secrets -n $NAMESPACE harbor-nginx -o jsonpath='{.data.ca\.crt}' | base64 -d > harbor.ca.crt

# CA証明書をmacにインストールが必要
# crtファイルをmacに転送し、ダブルクリック
# キーチェインアクセスから証明書を開き、常に許可を設定
#
# ブラウザからharborへアクセス
# アカウント:admin、パスワード: Harbor12345
# sandboxプロジェクトを作成する
