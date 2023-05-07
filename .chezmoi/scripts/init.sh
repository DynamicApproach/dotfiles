#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)" # Get the path of the directory containing the script
BASH_PROFILE="{{.chezmoi.sourceDir}}/.chezmoi/dotfiles/.bash_profile"  # Set the path of the .bash_profile file to the same directory as the script
PROJECTS_DIR="$HOME/Projects"
echo "Checking for $PROJECTS_DIR..."
if [ ! -d "$PROJECTS_DIR" ]; then
  echo "Creating $PROJECTS_DIR..."
  mkdir "$PROJECTS_DIR"
fi

if [ -f "$BASH_PROFILE" ]; then
  echo "Copying .bash_profile to $HOME..."
  cp "$BASH_PROFILE" "$HOME"
  echo "Done!"
else
  echo "Error: $BASH_PROFILE not found."
fi
# Create SSH config file if it doesn't exist
if [ ! -f "$HOME/.ssh/config" ]; then
  echo "Creating SSH config file..."
  touch "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
fi

# Check if the SSH configuration already exists in the config file
if grep -Fxq "Host *.github.com" "$HOME/.ssh/config" && grep -Fxq "AddKeysToAgent yes" "$HOME/.ssh/config" && grep -Fxq "IdentityFile ~/.ssh/id_ed25519" "$HOME/.ssh/config" && grep -Fxq "IdentityFile ~/.ssh/acquia" "$HOME/.ssh/config" && grep -Fxq "Match all" "$HOME/.ssh/config" && grep -Fxq "Include ~/.fig/ssh" "$HOME/.ssh/config"; then
  echo "SSH configuration already exists in ~/.ssh/config."
else
  # Append the new SSH configuration to the config file
  echo "Appending SSH configuration to ~/.ssh/config..."
  cat <<EOF >>"$HOME/.ssh/config"
Host *.github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
  IdentityFile ~/.ssh/acquia

# Fig ssh integration. Keep at the bottom of this file.
Match all
  Include ~/.fig/ssh
EOF
fi
echo "Done!"
chmod +x install-setup.sh docksal-fix.sh micro.sh wakatime.sh

# Execute the scripts in order
echo "Executing install-setup.sh..."
.{{.chezmoi.sourceDir}}/scripts/install-setup.sh
echo "Executing docksal-fix.sh..."
.{{.chezmoi.sourceDir}}/scripts/docksal-fix.sh
echo "Executing micro.sh..."
.{{.chezmoi.sourceDir}}/scripts/micro.sh
echo "Executing wakatime.sh..."
.{{.chezmoi.sourceDir}}/scripts/wakatime.sh

# Activate zsh
echo "Activating zsh..."
chsh -s /bin/zsh

echo "Done!"
