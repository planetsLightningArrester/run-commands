#!/bin/bash
#
# Set alias in Bash using C-Shell syntax
# author: @planetsLightningArrester
# shellcheck disable=SC2139

a_name="$1" && shift && alias "$a_name"="$*"

# EOF
