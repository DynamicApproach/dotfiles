#!/bin/bash

if ! command -v micro &>/dev/null; then
    # Download and install Micro
    curl -L https://getmic.ro | bash

    # Move the micro binary to ~/.local/bin
    mkdir -p ~/.local/bin
    mv micro ~/.local/bin/

    # Create a symlink to the micro binary in /usr/local/bin
    sudo ln -s ~/.local/bin/micro /usr/local/bin/micro

    echo "Micro has been installed and set as the default editor."
else
    echo "Micro is already installed."
fi
