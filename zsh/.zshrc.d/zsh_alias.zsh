# alias cat=bat
alias ls=exa
alias lsd='exa -D1'
alias reload!="source ~/.zshrc"


# Shortcuts
alias d="cd ~/Documents/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/Repos"
alias g="git"

alias genpass='openssl rand -base64 32'

# SSH Cloud: do not store server key, since IPs tend to change
alias sshc='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'


# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }' | sort -n"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"