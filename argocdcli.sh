#!/bin/bash

set -e

echo "🚀 Installing ArgoCD CLI..."

# Detect OS
OS="$(uname -s)"
ARCH="$(uname -m)"

if [[ "$OS" != "Linux" ]]; then
  echo "❌ This script is for Linux systems."
  exit 1
fi

# Download latest ArgoCD CLI
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

# Make executable
chmod +x argocd

# Move to PATH
sudo mv argocd /usr/local/bin/

# Verify installation
echo "✅ Verifying installation..."
argocd version

echo "🎉 ArgoCD CLI installed successfully!"
