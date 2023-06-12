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

# Install tools
echo "Installing tools..."
brew install zsh aom fontconfig jpeg-xl libzip pcre2 apr freetds krb5 little-cms2 php \
apr-util freetype libavif lz4 php@8.1 argon2 gd libidn2 m4 readline aspell gettext libnghttp2 \
micro rtmpdump atuin gh libpng ncurses sqlite autoconf giflib libpq node starship brotli \
git-delta libsodium node@16 tidy-html5 c-ares gmp libssh2 nvm unixodbc ca-certificates gpatch \
libtiff oniguruma webp composer highway libtool openexr xz coreutils icu4c libunistring \
openldap zsh curl imath libuv openssl@1.1 zstd diff-so-fancy jpeg-turbo libvmaf pcre
check_status "Tools installation"

# Install casks
echo "Installing casks..."
brew install --cask github iterm2 background-music fig visual-studio-code discord keepingyouawake \
docker microsoft-teams
check_status "Casks installation"

# Set the font URL
font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"

# Set the destination directory
dest_dir="$HOME/Library/Fonts"

# Download the zip file
curl -L $font_url -o font.zip

# Unzip the font files
unzip -o font.zip -d fonts_temp

# Move font files to destination directory
find ./fonts_temp -name "*.ttf" -exec mv {} $dest_dir \;

# Remove temporary directories and files
rm -rf fonts_temp font.zip

echo "The font has been successfully installed."

# Set ZSH as your default shell
echo "Setting ZSH as default shell..."
chsh -s $(which zsh)
check_status "Setting ZSH as default shell"

# Install Composer
echo "Installing Composer..."
brew install composer
check_status "Composer installation"

# Install Drush
echo "Installing Drush..."
composer global require drush/drush
check_status "Drush installation"

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh
check_status "GitHub CLI installation"
# Copy zshrc config if it exists
if [ -f "$HOME/.zshrc" ]; then
    echo "Copying existing zshrc config to backup..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    check_status "Backing up existing .zshrc"
fi

echo "Moving new .zshrc into place..."
cp ../.zshrc "$HOME/.zshrc"
check_status "Moving new .zshrc"

echo "Moving new starship into place..."
cp ../Starship.toml "$HOME/.config/starship.toml"
check_status "Moving new starship.toml"

# Copy zsh_plugins.txt if it exists
if [ -f "$HOME/.zsh_plugins.txt" ]; then
    echo "Copying existing zsh_plugins.txt to backup..."
    cp "$HOME/.zsh_plugins.txt" "$HOME/.zsh_plugins.txt.backup"
    check_status "Backing up existing .zsh_plugins.txt"
fi
echo "Moving new .zsh_plugins.txt into place..."
cp ../.zsh_plugins.txt "$HOME/.zsh_plugins.txt"
check_status "Moving new .zsh_plugins.txt"

# Set Micro as the default terminal editor for the current user
echo "Setting Micro as default terminal editor..."
echo 'export VISUAL="micro"' >> ~/.zshrc
echo 'export EDITOR="micro"' >> ~/.zshrc
check_status "Setting Micro as default terminal editor"

# Create aliases for "edit" and "micro" for the current user
echo "Creating aliases..."
echo 'alias edit="micro"' >> ~/.zshrc
echo 'alias micro="/usr/local/bin/micro"' >> ~/.zshrc
check_status "Alias creation"

# Add Composer's global bin directory to the system's list of paths.
echo "Updating PATH in .zshrc..."
echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.zshrc
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
check_status "PATH update"

# Reload ZSH config
echo "Reloading ZSH configuration..."
source ~/.zshrc
check_status "Reloading ZSH configuration"

# Everything is done
echo "Script completed successfully!"
