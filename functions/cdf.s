#!/bin/bash
#
# Change the directory to the dirname of a given path
# author: @planetsLightningArrester
# shellcheck disable=SC2006,SC2046,SC2059

setenv MAIN_PATH "$1";
test -z "$MAIN_PATH" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing the destination argument\n\n" && return-error;

setenv TO `dirname "$MAIN_PATH"`;
test ! -e "$TO" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Destination '$TO' not found.\n\n" && return-error;

cd "$TO" && return-success;

# EOF
