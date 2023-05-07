#!/bin/sh

# The path to the install-chezmoi.sh script within the chezmoi source directory
install_path="{{ .chezmoi.sourceDir }}/install-chezmoi.sh"

# Check if the install-chezmoi.sh script exists
if [ -f "$install_path" ]; then
    echo "Running install-chezmoi.sh script..."
    sh "$install_path"
else
    echo "install-chezmoi.sh script not found in $install_path"
fi

# The path to the init.sh script within the chezmoi source directory
init_path="{{ .chezmoi.sourceDir }}/scripts/init.sh"

# Check if the init.sh script exists
if [ -f "$init_path" ]; then
    echo "Running init.sh script..."
    sh "$init_path"
else
    echo "init.sh script not found in $init_path"
fi
