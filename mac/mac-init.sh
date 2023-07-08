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
brew install zsh aom fontconfig jpeg-xl libzip pcre2 apr freetds krb5 little-cms2 php \
apr-util freetype libavif lz4 php@8.1 argon2 gd libidn2 m4 readline aspell gettext libnghttp2 \
micro rtmpdump atuin gh libpng ncurses sqlite autoconf giflib libpq node starship brotli \
git-delta libsodium node@16 tidy-html5 c-ares gmp libssh2 nvm unixodbc ca-certificates gpatch \
libtiff oniguruma webp composer highway libtool openexr xz coreutils icu4c libunistring \
openldap zsh curl imath libuv openssl@1.1 zstd diff-so-fancy jpeg-turbo libvmaf pcre \
--cask github iterm2 background-music fig visual-studio-code discord keepingyouawake docker \
microsoft-teams nushell 
check_status "Tools and casks installation"

# Install Python pip package manager
echo "Installing Python pip..."
sudo easy_install pip
check_status "pip installation"

# Install Wakatime using pip
echo "Installing Wakatime..."
sudo pip3 install wakatime
check_status "Wakatime installation"

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
export PATH="/usr/local/opt/php@8.1/bin:$PATH"
export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
export PATH="/usr/local/bin:$HOME/.composer/vendor/bin:/usr/local/etc/php@8.2/bin:$PATH"
export STARSHIP_DISTRO="TLJ 🍎 - "
source /usr/local/opt/antidote/share/antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
eval "$(atuin init zsh)"
eval "$(starship init zsh)"


# Everything is done
echo "Script completed successfully!"
