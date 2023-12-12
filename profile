# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# exports
export EDITOR=vim
export TERM=xterm-256color-italic

# Keep ssh credentials when ssh-ing
ssh-add -q

# init nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

    # begin powerline-shell config
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

    # run nvm use when .nvmrc is present
    autoload -U add-zsh-hook
    load-nvmrc() {
      local nvmrc_path
      nvmrc_path="$(nvm_find_nvmrc)"

      if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version
        nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
          nvm install
        elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
          nvm use
        fi
      elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
      fi
    }
    add-zsh-hook chpwd load-nvmrc
    load-nvmrc
elif test -n "$BASH_VERSION"; then
    # don't put duplicate lines or lines starting with space in the history (bash)
    HISTCONTROL=ignoreboth

    # check the window size after each command and update the values of LINES and COLUMNS (bash)
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # powerline-shell config
    function _update_ps1() {
        PS1=$(powerline-shell $?)
    }
    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi

    # run nvm use when .nvmrc is present
    cdnvm() {
        command cd "$@" || return $?
        nvm_path="$(nvm_find_up .nvmrc | command tr -d '\n')"

        # If there are no .nvmrc file, use the default nvm version
        if [[ ! $nvm_path = *[^[:space:]]* ]]; then

            declare default_version
            default_version="$(nvm version default)"

            # If there is no default version, set it to `node`
            # This will use the latest version on your machine
            if [ $default_version = 'N/A' ]; then
                nvm alias default node
                default_version=$(nvm version default)
            fi

            # If the current version is not the default version, set it to use the default version
            if [ "$(nvm current)" != "${default_version}" ]; then
                nvm use default
            fi
        elif [[ -s "${nvm_path}/.nvmrc" && -r "${nvm_path}/.nvmrc" ]]; then
            declare nvm_version
            nvm_version=$(<"${nvm_path}"/.nvmrc)

            declare locally_resolved_nvm_version
            # `nvm ls` will check all locally-available versions
            # If there are multiple matching versions, take the latest one
            # Remove the `->` and `*` characters and spaces
            # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
            locally_resolved_nvm_version=$(nvm ls --no-colors "${nvm_version}" | command tail -1 | command tr -d '\->*' | command tr -d '[:space:]')

            # If it is not already installed, install it
            # `nvm install` will implicitly use the newly-installed version
            if [ "${locally_resolved_nvm_version}" = 'N/A' ]; then
                nvm install "${nvm_version}";
            elif [ "$(nvm current)" != "${locally_resolved_nvm_version}" ]; then
                nvm use "${nvm_version}";
            fi
        fi
    }
    alias cd='cdnvm'
    cdnvm "$PWD" || exit
fi

. ~/.aliases

eval "$("$(brew --prefix)"/bin/brew shellenv)"

eval "$(rbenv init - zsh)"
