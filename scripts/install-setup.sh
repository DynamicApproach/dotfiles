#!/bin/bash
# Check if Xcode command-line tools are installed
if ! command -v xcode-select &>/dev/null; then
    echo "Installing Xcode command-line tools..."
    xcode-select --install
else
    echo "Xcode command-line tools are already installed."
fi
# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew and installed formulae
echo "Updating Homebrew..."
brew update
brew upgrade

echo "Done!"

# Install iTerm2 if it's not already installed
if ! brew list --cask iterm2 &>/dev/null; then
    echo "Installing iTerm2..."
    brew install --cask iterm2
else
    echo "iTerm2 is already installed."
fi

# Install fig if it's not already installed
if ! command -v fig &>/dev/null; then
    echo "Installing fig..."
    brew install fig
else
    echo "fig is already installed."
fi

# Install waketime if it's not already installed
if ! command -v wakatime &>/dev/null; then
    echo "Installing waketime..."
    brew install waketime
else
    echo "waketime is already installed."
fi
# Install Visual Studio Code if it's not already installed
if ! brew list --cask visual-studio-code &>/dev/null; then
    echo "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
else
    echo "Visual Studio Code is already installed."
fi

# Install diff-so-fancy if it's not already installed
if ! command -v diff-so-fancy &>/dev/null; then
    echo "Installing diff-so-fancy..."
    brew install diff-so-fancy
else
    echo "diff-so-fancy is already installed."
fi

# Install delta if it's not already installed
if ! command -v delta &>/dev/null; then
    echo "Installing delta..."
    brew install git-delta
else
    echo "delta is already installed."
fi

# Install zsh if it's not already installed
if ! command -v zsh &>/dev/null; then
    echo "Installing zsh..."
    brew install zsh
else
    echo "zsh is already installed."
fi

# Install Oh My Zsh if it's not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Install Powerlevel10k theme for Oh My Zsh if it's not already installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme for Oh My Zsh..."
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "Powerlevel10k theme for Oh My Zsh is already installed."
fi

# Copy zshrc config if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "Copying zshrc config..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi
cp "{{ .chezmoi.sourceDir }}/dotfiles/.zshrc" "$HOME/.zshrc"

# Copy Powerlevel10k config if it exists
if [ -f "$HOME/.p10k.zsh" ]; then
    echo "Copying Powerlevel10k config..."
    cp "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.backup"
fi
cp "{{ .chezmoi.sourceDir }}/dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"

echo "Done!"

# Install PowerShell 7 if it's not already installed
if ! brew list --cask powershell &>/dev/null; then
    echo "Installing PowerShell 7..."
    brew install --cask powershell
else
    echo "PowerShell 7 is already installed."
fi

# Install Oh My Posh if it's not already installed
if ! pwsh -c "Get-InstalledModule -Name oh-my-posh" &>/dev/null; then
    echo "Installing Oh My Posh..."
    pwsh -c "Install-Module oh-my-posh -Scope CurrentUser"
else
    echo "Oh My Posh is already installed."
fi

# Copy Oh My Posh theme config if it exists
if [ -f "$HOME/.oh-my-posh/themes/ohmyposh.omp.json" ]; then
    echo "Copying Oh My Posh theme config..."
    cp "$HOME/.oh-my-posh/themes/ohmyposh.omp.json" "$HOME/.oh-my-posh/themes/ohmyposh.omp.json.backup"
fi
cp "{{ .chezmoi.sourceDir }}/dotfiles/ohmyposh.omp.json" "$HOME/.oh-my-posh/themes/"

# Add PowerShell alias to zshrc config if it doesn't already exist
if ! grep -q "alias pwsh=pwsh-preview" "$HOME/.zshrc" &>/dev/null; then
    echo "Adding PowerShell alias to zshrc config..."
    cat <<EOF >>~/.zshrc
alias pwsh=pwsh-preview
EOF
else
    echo "PowerShell alias already exists in zshrc config."
fi

echo "Done!"

# Install NVM if it's not already installed
if ! command -v nvm &>/dev/null; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    source "$HOME/.nvm/nvm.sh"
else
    echo "NVM is already installed."
fi
echo "Done!"

# Install Docksal if it's not already installed
if ! command -v fin &>/dev/null; then
    echo "Installing Docksal..."
    curl -fsSL https://get.docksal.io | sh
else
    echo "Docksal is already installed."
fi

# Install Drush if it's not already installed
if ! command -v drush &>/dev/null; then
    echo "Installing Drush..."
    composer global require drush/drush
else
    echo "Drush is already installed."
fi
# Check if Docker Desktop is already installed
if ! command -v docker &>/dev/null; then
    echo "Docker Desktop is not installed. Installing Docker Desktop..."
    # Download the Docker Desktop .dmg file
    curl -L "https://desktop.docker.com/mac/stable/Docker.dmg" -o "Docker.dmg"
    # Mount the .dmg file
    hdiutil attach Docker.dmg
    # Copy the Docker app to the Applications folder
    cp -R /Volumes/Docker/Docker.app /Applications
    # Unmount the .dmg file
    hdiutil detach /Volumes/Docker
    # Remove the .dmg file
    rm Docker.dmg
else
    echo "Docker Desktop is already installed."
fi

echo "Done!"
