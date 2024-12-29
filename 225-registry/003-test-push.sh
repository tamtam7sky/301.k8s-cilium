#!/usr/bin/bash
set -xeuo pipefail

VERSION="1.36.1"

# busybox のコンテナイメージを pull
docker pull busybox:${VERSION}

# リポジトリ用に名前・タグ付け
docker tag busybox:${VERSION} core.harbor.domain/sandbox/busybox:${VERSION}

docker image ls

# Push !
docker push core.harbor.domain/sandbox/busybox:${VERSION}

docker image rm busybox:${VERSION}

