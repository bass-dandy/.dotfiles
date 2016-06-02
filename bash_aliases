# Make everything colorful
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ssh shortcuts
alias lab='ssh -X ctdinh93@linux.cs.utexas.edu'

# Fuck python 2
alias python='python3'
alias pip='pip3'

# Get pid by process name
alias pid='ps -deafww | grep -v "grep" | grep -i'

# Verbosely make parent dirs if they don't exist
alias mkdir='mkdir -pv'

# Shortcuts
alias su='sudo'
alias ..='cd ..'
alias ...='cd ../..'
