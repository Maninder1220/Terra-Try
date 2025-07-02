#!/usr/bin/env bash
# update_terraform.sh
# This script adds the official HashiCorp APT repository and installs/upgrades Terraform.

set -euo pipefail

KEYRING_PATH="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
REPO_LIST="/etc/apt/sources.list.d/hashicorp.list"

echo "🔑 1. Fetching and installing the HashiCorp GPG key…"
wget -O- https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor -o "$KEYRING_PATH"

echo "📦 2. Adding the HashiCorp APT repository…"
ARCH=$(dpkg --print-architecture)
CODENAME=$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs)
echo "deb [arch=$ARCH signed-by=$KEYRING_PATH] https://apt.releases.hashicorp.com $CODENAME main" \
  | sudo tee "$REPO_LIST" > /dev/null

echo "🔄 3. Updating package lists…"
sudo apt-get update

echo "⬆️ 4. Installing/upgrading Terraform…"
sudo apt-get install -y terraform

echo "✅ Terraform is now installed. Version:"
terraform version

