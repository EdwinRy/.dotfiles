if ! command -v lsd > /dev/null 2>&1
then
    return
fi
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
