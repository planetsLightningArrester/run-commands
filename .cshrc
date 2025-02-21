#!/bin/csh
# shellcheck disable=SC1071
# shellcheck disable=SC1090

#######################################################
# Based aliases and scripts on zachbrowne.me
# Edited by @planetsLightningArrester
#######################################################

###############################################################################################################
#																																																							#
# Tips for csh users !!																																												#
#																																																							#
#   1) Don't use it																																														#
#     a) Top Ten Reasons not to use the C shell => https://www.grymoire.com/unix/CshTop10.txt									#
#     b) Csh Programming Considered Harmful => https://www-uxsup.csx.cam.ac.uk/misc/csh.html									#
#     c) Csh Programming Considered Harmful 2 => http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/					#
#     d) ShellCheck only supports sh/bash/dash/ksh scripts. Sorry! => https://www.shellcheck.net/wiki/SC1071	#
#   2) Use Bash instead :)																																										#
#																																																							#
###############################################################################################################

# Unset all alias to prevent error on recsh
unalias -a;

# Define the shell
setenv SHELL "/bin/csh"
setenv nobeep

# Prevent Perl warning when SSHing. Make sure to ssh with `ssh -t <hostname> /bin/bash` or `ssh -t <hostname> /bin/csh`
# setenv LC_CTYPE "en_US.UTF-8"
# setenv LC_ALL "en_US.UTF-8"

# Source global definitions
if ( -e /dv/tools/bin/dvbase ) then
	eval `/dv/tools/bin/dvbase`;
endif

# Create a "return-error" alias in C-Shell to `exit 1` whenever a function fails
# This is also defined in Bash with the same name, but there it's replaced by `return 1`
alias return-success 'exit 0'
alias return-error 'exit 1'

# Create the "set-alias" alias in C-Shell to be compatible with the "./functions/set-alias".
# Sourcing from "./functions/set-alias" in C-Shell won't work, but works in Bash
alias set-alias 'alias \!*'
setenv __host__ "`hostname`"

# Use special functions
# ? Only adding "functions/" to PATH wouldn't allow to source it
foreach func ( "`ls $HOME/run-commands/functions`" )
	if ( "$func" =~ "*.s" ) then
		setenv has_to_source "TRUE";
	else
		setenv has_to_source "FALSE";
	endif
	set func_name="${func:r}";
	# Do  not overwrite csh built-ins nor re-define set-alias
	if ( "$func_name" != "set-alias" && "$func_name" != "setenv" && "$func_name" != "unsetenv" ) then
    if ( "$has_to_source" == "TRUE" ) then
      set-alias "$func_name" "source $HOME/run-commands/functions/$func"
    else
      if ( "$func_name" != "ssh" || "$__host__" != "PC-$USER" ) then
        set-alias "$func_name" "$HOME/run-commands/functions/$func"
      endif
    endif
		/bin/chmod 744 "$HOME/run-commands/functions/$func";
	endif
end
unsetenv __host__

#######################################################
# ENVIRONMENT
#######################################################

# Define terminal colors
setenv TC_LIGHTGRAY "%{\033[0;37m"
setenv TC_WHITE "%{\033[1;37m"
setenv TC_BLACK "%{\033[0;30m"
setenv TC_DARKGRAY "%{\033[1;30m%}"
setenv TC_RED "%{\033[0;31m%}"
setenv TC_LIGHTRED "%{\033[1;31m%}"
setenv TC_GREEN "%{\033[0;32m%}"
setenv TC_LIGHTGREEN "%{\033[1;32m"
setenv TC_BROWN "%{\033[0;33m%}"
setenv TC_YELLOW "%{\033[1;33m%}"
setenv TC_BLUE "%{\033[0;34m%}"
setenv TC_LIGHTBLUE "%{\033[1;34m%}"
setenv TC_MAGENTA "%{\033[0;35m"
setenv TC_LIGHTMAGENTA "%{\033[1;35m"
setenv TC_CYAN "%{\033[0;36m"
setenv TC_LIGHTCYAN "%{\033[1;36m"
setenv TC_NOCOLOR "%{\033[0m%}"

# Source common envs
source "$HOME/run-commands/env/common";

# Source common envs
source "$HOME/run-commands/env/conda";

# Source private envs. Leave it as the last to be sourced, so private envs gonna have higher prevalence
test -e "$HOME/run-commands/env/.$USER" && source "$HOME/run-commands/env/.$USER";

#######################################################
# ALIAS
#######################################################
# To temporarily bypass an alias, we precede the command with a \
# EG: the ls command is aliased, but to use the normal ls command you would type \ls

# Source common aliases
source "$HOME/run-commands/aliases/common";

# Source private aliases. Leave it as the last to be sourced, so private aliases gonna have higher prevalence
test -e "$HOME/run-commands/aliases/.$USER" && source "$HOME/run-commands/aliases/.$USER";

#######################################################
# Set the command prompt
#######################################################

alias precmd 'set __cmd_status=$status && source $HOME/run-commands/prompt/csh'

# EOF

