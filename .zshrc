####################### ALIAS ####################
alias ls="ls -aG"
alias buildfront="cd /Users/Thomas_Lloyd-Jones/Projects/Kodak_Com-Front_End_Nuxt && npm ci && npm run dev"
alias buildcraft="cd /Users/Thomas_Lloyd-Jones/Projects/Kodak_Com-Craft_CMS && ddev start "
alias root="cd /"
alias home="cd $HOME"
alias docs="cd $HOME/Documents"
alias Docs="cd $HOME/Documents"
alias refresh="omz reload"
alias up="cd .."
alias Up="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias Root="cd /"
alias docker-clean="docker rm -f $(docker ps -a -q)"
alias work-update="fin update"
alias editzsh="micro ~/.zshrc"
alias Home="cd $HOME"
alias WORK="cd $HOME/Projects"
alias Work="cd $HOME/Projects"
alias work="cd $HOME/Projects"
alias Refresh="omz reload"

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
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Function for creating a new branch
create_branch() {
   printf "Are you working on dev or poc? "
   read version
   if [ "$version" = "dev" ]; then
       git checkout dev
   else
       git checkout poc
   fi

   printf "Enter the issue number: "
   read numm
   printf "Enter the issue title: "
   read name
   # Replace spaces in branch name with underscores and convert to lowercase
   branch_name="tlj/$numm-${name// /_}"
   branch_name=${branch_name,,}

   # Check if the current directory is a git repository
   if ! git rev-parse --git-dir > /dev/null 2>&1; then
       echo "Error: not a git repository."
       return 1
   fi

   # Check if there are changes in the working directory
   if git diff-index --quiet HEAD --; then
       git checkout -b "$branch_name"
   else
       while true; do
           printf "You have uncommitted changes. Do you want to (s)tash them, (c)ommit them to the new branch, or (d)iscard them? (s/c/d): "
           read choice
           case $choice in
           [sS])
               git stash
               git checkout -b "$branch_name"
               break
               ;;
           [cC])
               git commit -a -m "Save work in progress"
               git checkout -b "$branch_name"
               break
               ;;
           [dD])
               git checkout -- .
               git checkout -b "$branch_name"
               break
               ;;
           *)
               echo "Invalid option."
               ;;
           esac
       done
   fi
}


# Paths
export PATH="/usr/local/opt/php@8.1/bin:$PATH"
export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/usr/local/bin:$HOME/.composer/vendor/bin:/usr/local/etc/php@8.2/bin:$PATH"
export STARSHIP_DISTRO="TLJ 🍎 - "
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh" 
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  
export PATH="/opt/homebrew/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"




# On-Site Proxy
export http_proxy=
#export http_proxy=
export https_proxy=$http_proxy
export rsync_proxy=$http_proxy
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$http_proxy
export RSYNC_PROXY=$http_proxy

