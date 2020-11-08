# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# print the weather
curl "wttr.in?format=3"

# shell-specific configs
if test -n "$ZSH_VERSION"; then
    # don't put duplicate lines or lines starting with space in the history
    setopt EXTENDED_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_NO_STORE
    setopt HIST_REDUCE_BLANKS
    setopt HIST_VERIFY
elif test -n "$BASH_VERSION"; then
    # don't put duplicate lines or lines starting with space in the history (bash)
    HISTCONTROL=ignoreboth

    # check the window size after each command and update the values of LINES and COLUMNS (bash)
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi

# exports
export EDITOR=vim

# Keep ssh credentials when ssh-ing
ssh-add -q

. ~/.aliases
