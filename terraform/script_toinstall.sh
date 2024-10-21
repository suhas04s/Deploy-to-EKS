#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to install kubectl
install_kubectl() {
  echo "Installing kubectl..."

  # Download the latest release of kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

  # Make kubectl executable
  chmod +x ./kubectl

  # Move kubectl to a directory in your PATH
  sudo mv ./kubectl /usr/local/bin/kubectl

  # Verify installation
  kubectl version --client
  echo "kubectl installed successfully!"
}

# Function to install Docker
install_docker() {
  echo "Installing Docker..."

  # Update the apt package index
  sudo apt-get update

  # Install Docker's package dependencies
  sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  # Add Docker’s official GPG key
  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  # Set up the stable Docker repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install Docker Engine
  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Verify Docker installation
  sudo docker --version
  echo "Docker installed successfully!"
}

# Execute installation functions
install_kubectl
install_docker

echo "Installation of kubectl and Docker is complete!"
