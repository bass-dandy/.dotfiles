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

    function powerline_precmd() {
        PS1="$(powerline-shell --shell zsh $?)"
    }

    function install_powerline_precmd() {
      for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
          return
        fi
      done
      precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
        install_powerline_precmd
    fi
elif test -n "$BASH_VERSION"; then
    # don't put duplicate lines or lines starting with space in the history (bash)
    HISTCONTROL=ignoreboth

    # check the window size after each command and update the values of LINES and COLUMNS (bash)
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    function _update_ps1() {
        PS1=$(powerline-shell $?)
    }

    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi

# exports
export EDITOR=vim
export TERM=xterm-256color-italic

# Keep ssh credentials when ssh-ing
ssh-add -q

. ~/.aliases
