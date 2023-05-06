# Fig pre block. Keep at the top of this file.

[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"

# get current branch in git repo

function parse_git_branch() {

    BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

    if [ ! "${BRANCH}" == "" ]; then

        STAT=$(parse_git_dirty)

        echo "[${BRANCH}${STAT}]"

    else

        echo ""

    fi

}

export PS1="\[\e[31m\]\\$ \[\e[m\]\[\e[33m\]\d \[\e[m\]\[\e[36m\]\@ \[\e[m\]\[\e[35m\]\w \[\e[m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\] $ \[\e[m\] "

# Fig post block. Keep at the bottom of this file.

[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
