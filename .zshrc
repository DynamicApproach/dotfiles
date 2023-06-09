# Fig pre block. Keep at the top of this file.
if [[ "$OSTYPE" == "darwin"* ]]; then
  [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
fi

####################### ALIAS ####################
alias ls="ls -aG"
alias buildwork="composer install && ./scripts/wny/install-docksal-drupal.sh && fin blt sync:refresh"
alias root="cd /"
alias home="cd $HOME"
alias docs="cd $HOME/Documents"
alias work="cd $HOME/Projects"
alias refresh="omz reload"
alias up="cd .."
alias Root="cd /"
alias docker-clean="docker rm -f $(docker ps -a -q)"
alias work-update="fin update"
alias editzsh="micro ~/.zshrc"
alias Home="cd $HOME"
alias Docs="cd $HOME/Documents"
alias WORK="cd $HOME/Projects"
alias Work="cd $HOME/Projects"
alias Refresh="omz reload"
alias Up="cd .."
###################### END ALIAS ###################
# Set up the prompt
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# custom configuration for zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Function for creating a new branch
create_branch() {
  echo "Are you working on d8 or d10? (d8/d10): \c"
  read version

  if [ "$version" = "d10" ]; then
    git checkout main-WIP-D10
  else
    git checkout WIP
  fi

  echo "Enter the NDD name: \c"
  read name

  branch_name="NDD-$name"

  if git diff-index --quiet HEAD --; then
    # no changes in the working directory
    git checkout -b $branch_name
  else
    # changes in the working directory
    while true; do
      echo "You have uncommitted changes. Do you want to (s)tash them, (c)ommit them to the new branch, or (d)iscard them? (s/c/d): \c"
      read choice

      case $choice in
      s | S)
        git stash
        git checkout -b $branch_name
        break
        ;;
      c | C)
        git commit -a -m "save work in progress"
        git checkout -b $branch_name
        break
        ;;
      d | D)
        git checkout -- .
        git checkout -b $branch_name
        break
        ;;
      *)
        echo "Invalid option."
        ;;
      esac
    done
  fi
}
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [[ "$OSTYPE" == "darwin"* ]]; then
  source /Users/thomas/.docker/init-zsh.sh || true  # Added by Docker Desktop
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  export PATH="/usr/local/opt/php@8.1/bin:$PATH"
  export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
  export PATH="/usr/local/bin:$HOME/.composer/vendor/bin:/usr/local/etc/php@8.2/bin:$PATH"
  export STARSHIP_DISTRO="TLJ 🍎 - "
  source /usr/local/opt/antidote/share/antidote/antidote.zsh
  antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
  eval "$(atuin init zsh)"
  eval "$(starship init zsh)"
else
  eval "$(dircolors -b)"
  export STARSHIP_DISTRO="TLJ 🎆 - "
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  source /home/thomas/.antidote/antidote.zsh
  antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
  chprompt_func() {
    # Specify the path to the directory with the different configs
    config_dir=~/.configs/

    # Store the config files as elements of an array
    ConfigFiles=("${(@f)$(ls $config_dir)}")

    echo "Choose which prompt you want"

    for i in {1..${#ConfigFiles}}; do
        echo "[$i] ${ConfigFiles[i]}"
    done

    read choice

    # Replace the contents of the starship.toml file with the contents of the chosen prompt
    cat "${config_dir}/${ConfigFiles[choice]}" > ~/.config/starship.toml
}

  alias chprompt='chprompt_func'
  eval "$(atuin init zsh)"
  export STARSHIP_CONFIG=/mnt/c/Users/lloyd/.config/starship.toml
  eval "$(starship init zsh)"
fi

# Fig post block. Keep at the bottom of this file.
if [[ "$OSTYPE" == "darwin"* ]]; then
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
fi