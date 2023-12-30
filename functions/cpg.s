#!/bin/bash
#
# Copy and go to the directory
# author: @planetsLightningArrester
# shellcheck disable=SC2006,SC2046,SC2059

############################################
# Copy and go to the directory
############################################

setenv FROM "$1";
setenv TO "$2";

test -z "$FROM" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing the origin argument\n\n" && return-error;
test ! -e "$FROM" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Origin argument '$FROM' not found.\n\n" && return-error;
test -z "$TO" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing the destination argument\n\n" && return-error;

test ! -d "$FROM" && test -d "$TO" && cp "$FROM" "$TO" && cd "$TO" && return-success;
test ! -d "$FROM" && test ! -d "$TO" && cp "$FROM" "$TO" && cd `dirname "$TO"` && return-success;
test -d "$FROM" && test -d "$TO" && cp -r "$FROM" "$TO" && cd "$TO"/`basename "$FROM"` && return-success;
test -d "$FROM" && test ! -d "$TO" && cp -r "$FROM" "$TO" && cd "$TO" && return-success;

# EOF
