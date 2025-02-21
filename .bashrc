#!/bin/bash
# shellcheck disable=SC1090,SC1091

#######################################################
# Based aliases and scripts on zachbrowne.me
# Edited by @planetsLightningArrester
#######################################################

# Unset all alias to prevent error on rebash
unalias -a

# Define the shell
export SHELL="/bin/bash"
export nobeep

# Prevent Perl warning when SSHing. Make sure to ssh with `ssh -t <hostname> /bin/bash` or `ssh -t <hostname> /bin/csh`
# export LC_CTYPE="en_US.UTF-8"
# export LC_ALL="en_US.UTF-8"

# Source global definitions
[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f /etc/profile ]] && . /etc/profile
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  # shellcheck source=/dev/null
  . /etc/bash_completion
fi

# Prevent Bash from escaping $ when completing paths with env vars
shopt -u progcomp

# Create a "return-error" alias in Bash to `return 1` whenever a function fails, instead of `exit 1`
# Otherwise, sourcing a script that returns `exit 1` would close the terminal
# This is also defined in C-Shell with the same name, but there it's replaced by `exit 1`
alias return-success='return 0'
alias return-error='return 1'

# Create the "set-alias" alias in Bash to enable sourcing the alias set by "./functions/set-alias".
# Sourcing from "./functions/set-alias" in Bash works, but won't work in C-Shell
alias set-alias='source $HOME/run-commands/functions/set-alias.s'
__host__="$(hostname)"

# Use special functions
# ? Only adding "functions/" to PATH wouldn't allow to source it
functions="$(ls "$HOME"/run-commands/functions)"
while IFS= read -r func; do
  # Do  not overwrite Bash built-ins nor re-define set-alias
  if [[ "$func" != "export.s" ]] && [[ "$func" != "unset.s" ]]; then
    if [[ "$func" = *.s* ]]; then
      set-alias "${func%.*}" "source $HOME/run-commands/functions/$func"
    else
      if [[ "$func" != "ssh" ]] || [[ "${__host__}" != "PC-${USER}" ]]; then
        set-alias "${func%.*}" "$HOME/run-commands/functions/$func"
      fi
    fi
    /bin/chmod 744 "$HOME/run-commands/functions/$func"
  fi
done < <(printf '%s\n' "$functions")
unset __host__

#######################################################
# ENVIRONMENT
#######################################################

# Define terminal colors
export TC_LIGHTGRAY="\[\033[0;37m\]"
export TC_WHITE="\[\033[1;37m\]"
export TC_BLACK="\[\033[0;30m\]"
export TC_DARKGRAY="\[\033[1;30m\]"
export TC_RED="\[\033[0;31m\]"
export TC_LIGHTRED="\[\033[1;31m\]"
export TC_GREEN="\[\033[0;32m\]"
export TC_LIGHTGREEN="\[\033[1;32m\]"
export TC_BROWN="\[\033[0;33m\]"
export TC_YELLOW="\[\033[1;33m\]"
export TC_BLUE="\[\033[0;34m\]"
export TC_LIGHTBLUE="\[\033[1;34m\]"
export TC_MAGENTA="\[\033[0;35m\]"
export TC_LIGHTMAGENTA="\[\033[1;35m\]"
export TC_CYAN="\[\033[0;36m\]"
export TC_LIGHTCYAN="\[\033[1;36m\]"
export TC_NOCOLOR="\[\033[0m\]"

# Source common envs
source ~/run-commands/env/common

# Source conda envs
source ~/run-commands/env/conda

# Source private envs. Leave it as the last to be sourced, so private envs gonna have higher prevalence
test -e "$HOME/run-commands/env/.$USER" && source "$HOME/run-commands/env/.$USER"

#######################################################
# GENERAL ALIAS'S
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Source common aliases
source ~/run-commands/aliases/common

# Source private aliases. Leave it as the last to be sourced, so private aliases gonna have higher prevalence
test -e ~/run-commands/aliases/."$USER" && source ~/run-commands/aliases/."$USER"

#######################################################
# Set the command prompt
#######################################################

PROMPT_COMMAND='export __cmd_status=$? && source $HOME/run-commands/prompt/bash'

# EOF
