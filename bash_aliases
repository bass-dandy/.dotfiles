# Make everything colorful
alias ls='ls -FG'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Get pid by process name
alias pid='ps -deafww | grep -v "grep" | grep -i'

# Verbosely make parent dirs if they don't exist
alias mkdir='mkdir -pv'

# Shortcuts
alias su='sudo'
alias ..='cd ..'
alias ...='cd ../..'
alias lsa='ls -a'

# Typos
alias clera='clear'

# ssh shortcuts
alias pipeline3='ssh -i ~/.ssh/id_rsa christian_dinh@172.16.2.40 -p 2222'
