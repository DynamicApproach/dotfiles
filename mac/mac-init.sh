#!/bin/bash

# Function to check if a command succeeded
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error during: $1"
        exit 1
    fi
}

# Check if Xcode command-line tools are installed
if ! command -v xcode-select &>/dev/null; then
    echo "Installing Xcode command-line tools..."
    xcode-select --install
    check_status "Xcode command-line tools installation"
else
    echo "Xcode command-line tools are already installed."
fi

# Check if Homebrew is installed, if not then install it
if test ! $(which brew); then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    check_status "Homebrew installation"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew recipes
echo "Updating Homebrew..."
brew update
check_status "Homebrew update"

# Install tools and casks
echo "Installing tools and casks..."
brew install starship git-delta tidy-html5 nvim nvm ca-certificates composer coreutils curl diff-so-fancy github iterm2 fig discord keepingyouawake nushell python 
brew install wakatime-cli
brew install --cask Docker visual-studio-code alt-tab termius
check_status "Tools and casks installation"


# Configure Wakatime API key
echo "Configuring Wakatime API key..."
if grep --quiet 'api_key=.' ~/.wakatime.cfg; then
    echo "WakaTime API-key already configured."
else
    echo
    echo "Please input your secret API-key for WakaTime."
    echo "See https://wakatime.com/settings/api-key"
    read -p 'API-key: ' key
    echo -e "[settings]\napi_key=$key" >>~/.wakatime.cfg
fi
check_status "Wakatime API key configuration"

# Additional settings and installations
mkdir -p ~/.wakatime
chmod 700 ~/.wakatime
source /Users/thomas/.docker/init-zsh.sh || true  # Docker Desktop
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export STARSHIP_DISTRO="TLJ-🍎- "

echo -e "\n# Aliases\nalias ls=\"ls -aG\"\nalias buildwork=\"composer install && ./scripts/wny/install-docksal-drupal.sh && fin blt sync:refresh\"\nalias root=\"cd /\"\nalias home=\"cd \$HOME\"\nalias docs=\"cd \$HOME/Documents\"\nalias work=\"cd \$HOME/Projects\"\nalias refresh=\"omz reload\"\nalias up=\"cd ..\"\nalias Root=\"cd /\"\nalias docker-clean=\"docker rm -f \$(docker ps -a -q)\"\nalias work-update=\"fin update\"\nalias editzsh=\"micro ~/.zshrc\"\nalias Home=\"cd \$HOME\"\nalias Docs=\"cd \$HOME/Documents\"\nalias WORK=\"cd \$HOME/Projects\"\nalias Work=\"cd \$HOME/Projects\"\nalias Refresh=\"omz reload\"\nalias Up=\"cd ..\"\n\n# Initialize Atuin and Starship\neval \"\$(atuin init zsh)\"\neval \"\$(starship init zsh)\"" >> ~/.zshrc

# Everything is done
echo "Script completed successfully!"
