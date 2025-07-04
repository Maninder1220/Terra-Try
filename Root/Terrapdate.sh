#!/usr/bin/env bash
# update_terraform.sh
# Adds HashiCorp APT repo, installs/upgrades Terraform, and installs AWS CLI v2.

set -euo pipefail

# --- Configuration ---
KEYRING_PATH="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
REPO_LIST="/etc/apt/sources.list.d/hashicorp.list"
AWS_CLI_ZIP="awscliv2.zip"
AWS_INSTALL_DIR="aws"

# --- Prerequisites check ---
for cmd in curl gpg lsb_release unzip; do
  if ! command -v $cmd &>/dev/null; then
    echo "⚠️  '$cmd' not found, installing prerequisites..."
    sudo apt-get update
    sudo apt-get install -y gnupg2 lsb-release unzip curl
    break
  fi
done

# --- HashiCorp GPG key & repo ---
echo "🔑 1. Fetching and installing the HashiCorp GPG key…"
curl -fsSL https://apt.releases.hashicorp.com/gpg \
  | sudo gpg --dearmor -o "$KEYRING_PATH"

echo "📦 2. Adding the HashiCorp APT repository…"
ARCH=$(dpkg --print-architecture)
CODENAME=$(lsb_release -cs)
if [[ -z "$CODENAME" ]]; then
  echo "❌ Could not determine Ubuntu codename." >&2
  exit 1
fi

# Overwrite or create the list file
echo "deb [arch=$ARCH signed-by=$KEYRING_PATH] https://apt.releases.hashicorp.com $CODENAME main" \
  | sudo tee "$REPO_LIST" > /dev/null

# --- Terraform install/upgrade ---
echo "🔄 3. Updating package lists…"
sudo apt-get update -q

echo "⬆️ 4. Installing/upgrading Terraform…"
sudo apt-get install -y terraform

echo "✅ Terraform is now installed. Version:"
terraform version

# --- AWS CLI v2 install with arch mapping ---
echo "☁️ 5. Installing AWS CLI v2…"

# Map Debian/Ubuntu arch names to AWS CLI download names
DEB_ARCH=$(dpkg --print-architecture)
case "$DEB_ARCH" in
  amd64) AWS_ARCH="x86_64" ;;
  arm64) AWS_ARCH="aarch64" ;;
  *) 
    echo "❌ Unsupported architecture: $DEB_ARCH" >&2
    exit 1
    ;;
esac

AWS_ZIP="awscliv2.zip"
AWS_DIR="aws"

curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "$AWS_ZIP"
unzip -q "$AWS_ZIP"
sudo ./${AWS_DIR}/install --update

# Clean up
rm -rf "$AWS_ZIP" "$AWS_DIR"

echo "✅ AWS CLI version:"
aws --version
