#!/bin/bash
#
# Create and go to a directory
# author: @planetsLightningArrester
# shellcheck disable=SC2059

test -z "$1" && printf "\n[${TC_LIGHTRED}ERROR${TC_NOCOLOR}] Missing the dir name argument\n\n" && return-error;

mkdir -p "$1" && cd "$1" || return-error;

# EOF
