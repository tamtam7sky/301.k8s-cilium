#!/bin/sh
set -x

helm plugin install  https://github.com/databus23/helm-diff

ARCH=$(dpkg --print-architecture)

mkdir helmfile
cd helmfile
curl -sL https://github.com/helmfile/helmfile/releases/download/v0.162.0/helmfile_0.162.0_linux_$ARCH.tar.gz -O
tar xvzf helmfile_0.162.0_linux_$ARCH.tar.gz
chmod 755 helmfile
sudo mv helmfile /usr/local/bin
helmfile -v

cd ..
rm -rf ./helmfile
