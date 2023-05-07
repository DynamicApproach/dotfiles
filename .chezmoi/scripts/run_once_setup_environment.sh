#!/bin/sh

# The path to the init.sh script within the chezmoi source directory
init_path="{{ .chezmoi.sourceDir }}/scripts/init.sh"

# Check if the init.sh script exists
if [ -f "$init_path" ]; then
    echo "Running init.sh script..."
    sh "$init_path"
else
    echo "init.sh script not found in $init_path"
fi
