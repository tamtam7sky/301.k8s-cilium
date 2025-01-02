#!/usr/bin/env bash
set -xueo pipefail

if ! helm plugin update diff; then
	helm plugin install  https://github.com/databus23/helm-diff
fi

ARCH=$(dpkg --print-architecture)
VERSION="0.169.2"

mkdir helmfile
cd helmfile
curl -sL "https://github.com/helmfile/helmfile/releases/download/v${VERSION}/helmfile_${VERSION}_linux_${ARCH}.tar.gz" |
	tar zx
# tar xvzf helmfile_${VERSION}_linux_$ARCH.tar.gz
chmod 755 helmfile
sudo mv helmfile /usr/local/bin
helmfile -v

cd ..
rm -rf ./helmfile
