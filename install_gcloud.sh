#!/usr/bin/env bash

set -e

echo "============================================="
echo "   Installing Google Cloud SDK (gcloud)...   "
echo "============================================="

# Update system
echo "[1/6] Updating apt..."
sudo apt-get update -y

# Install dependencies
echo "[2/6] Installing system dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl

# Add Google Cloud public key
echo "[3/6] Adding GCP signing key..."
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the Cloud SDK distribution URI as a package source
echo "[4/6] Adding Google Cloud SDK repository..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Update and install the Cloud SDK
echo "[5/6] Installing google-cloud-sdk..."
sudo apt-get update -y
sudo apt-get install -y google-cloud-sdk

echo "[6/6] Installation complete!"

echo
echo "============================================="
echo " Google Cloud SDK installed successfully 🎉"
echo "============================================="
echo
echo "Next step:"
echo "  ► Run:  gcloud init"
echo "This will log you into your Google account and set your project."
echo
echo "Checking installation..."
gcloud --version

