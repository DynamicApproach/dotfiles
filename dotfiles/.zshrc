# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VISUAL="micro"
export EDITOR="micro"
export PATH="$HOME/.local/bin:$PATH"
alias edit="micro"
alias micro="~/.local/bin/micro"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

export EDITOR=micro
# Keep tons of lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=8500
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github acquia
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source $HOME/antigen.zsh
    
# Load the oh-my-zsh's library
antigen use oh-my-zsh



antigen bundle <<EOBUNDLES
    # Bundles from the default repo (robbyrussell's oh-my-zsh)
    git
    ssh-agent
    # Syntax highlighting bundle.
    zsh-users/zsh-syntax-highlighting
    # Fish-like auto suggestions
    #zsh-users/zsh-autosuggestions
	antigen-bundle drush
	antigen-bundle composer
	antigen-bundle git-prompt
	antigen-bundle github
	antigen-bundle vscode
	antigen-bundle iterm2
	antigen-bundle zsh-users/zsh-syntax-highlighting
	antigen bundle colored-man
	antigen bundle zsh-users/zsh-history-substring-search # load after zsh-syntax-highlighting
    # Extra zsh completions
    zsh-users/zsh-completions
    
EOBUNDLES

# Load the theme
antigen theme romkatv/powerlevel10k

# Tell antigen that you're done
antigen apply

alias ls="ls -a"
alias buildwork="composer install && ./scripts/wny/install-docksal-drupal.sh && fin blt sync:refresh && fin drush uli"
alias root="cd /"
alias home="cd $HOME"
alias HOME="cd $HOME"
alias docs="cd $HOME/Documents"
alias work="cd $HOME/Projects"
alias refresh="omz update && omz reload"
alias up="cd .."
alias Root="cd /"
alias docker-clean="docker rm -f $(docker ps -a -q)"
alias work-update="fin update"
alias editzsh="micro ~/.zshrc"
alias Home="cd $HOME"
alias Docs="cd $HOME/Documents"
alias Work="cd $HOME/Projects"
# custom configuration for zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
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
        s|S)
          git stash
          git checkout -b $branch_name
          git stash apply
          break
          ;;
        c|C)
          git add .
          git commit -m "Changes for $branch_name"
          git checkout -b $branch_name
          break
          ;;
        d|D)
          git checkout -b $branch_name
          git reset --hard HEAD
          break
          ;;
        *)
          echo "Invalid choice. Please enter 's', 'c', or 'd'."
          ;;
      esac
    done
  fi

  git status
}


source /Users/thomas/.docker/init-zsh.sh || true # Added by Docker Desktop

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/php@8.1/bin:$PATH"
export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
export PATH="/usr/local/bin:$HOME/.composer/vendor/bin:/usr/local/etc/php@8.2/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
