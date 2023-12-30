#!/bin/bash
#
# Goes up a specified number of directories  (i.e. up 4)
# author: @planetsLightningArrester
# shellcheck disable=SC2006,SC2046,SC2154,SC2059

# Check argument
test -z "$1" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] One has to specify how many levels to go up, e.g., 'up 4'\n\n" && return-error;

# Going up
setenv n_of_lines "$1";
setenv d `bash -c 'yes "../" 2>/dev/null | head -n "$n_of_lines" | tr -d "\n"'`;

# Move to it if exists
test ! -e "$d" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Can't go up that many levels\n\n" && return-error;
test -e "$d" && cd "$d" && return-success;

# EOF
