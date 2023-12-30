#!/bin/bash
#
# Find and replace expression in files of 
# the current directory. Uses `grep` to find
# and `sed` to replace
# author: @planetsLightningArrester
# shellcheck disable=SC2059

setenv FIND "$1";
setenv REPLACE "$2";

test -z "$FIND" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing FIND word pattern\n\n" && return-error;
test -z "$REPLACE" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing REPLACE pattern\n\n" && return-error;

grep -rl "$FIND" . | xargs sed -r -i "$REPLACE";

# EOF
