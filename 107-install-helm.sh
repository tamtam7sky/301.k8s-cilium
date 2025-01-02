#!/usr/bin/env bash
set -xeuo pipefail

curl -s https://baltocdn.com/helm/signing.asc |
	sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/helm.gpg > /dev/null

sudo apt-get install -y apt-transport-https
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://baltocdn.com/helm/stable/debian/ all main"
echo "deb [arch=$(dpkg --print-architecture)] https://baltocdn.com/helm/stable/debian/ all main" |
	sudo tee /etc/apt/sources.list.d/helm.list

sudo apt-get update
sudo apt-get install -y helm
sudo apt autoremove -y
helm version
