#!/bin/bash
export GITHUB_USERNAME="DynamicApproach"

# Install curl
sudo apt-get update
sudo apt-get install -y curl

# Download and run the chezmoi installation script
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
