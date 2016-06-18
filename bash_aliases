# Make everything colorful
alias ls='ls -FG'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Get pid by process name
alias pid='ps aux | awk '"'"'{cmd=$11; for(i=12;i<=NF;i++){cmd=cmd" "$i}; printf "%-10s %-6s %s\n", $1,$2,cmd}'"'"' | grep -v grep | grep -i -e '"'"'^user * pid * command$'"'"' -e '

# Verbosely make parent dirs if they don't exist
alias mkdir='mkdir -pv'

# Shortcuts
alias su='sudo'
alias ..='cd ..'
alias ...='cd ../..'
alias lsa='ls -a'

# Typos
alias clera='clear'
alias celar='clear'

# ssh shortcuts
alias pipeline3='ssh -i ~/.ssh/id_rsa christian_dinh@172.16.2.40 -p 2222'
