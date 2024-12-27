#!/usr/bin/bash
set -xeuo pipefail

# busybox のコンテナイメージを pull
docker pull busybox:1.34.1

# リポジトリ用に名前・タグ付け
docker tag busybox:1.34.1 core.harbor.domain/sandbox/busybox:1.34.1

docker images ls

# Push !
docker push core.harbor.domain/sandbox/busybox:1.34.1

docker image rm busybox:1.34.1

