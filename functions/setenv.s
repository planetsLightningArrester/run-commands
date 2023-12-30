#!/bin/bash
#
# Make setenv compatible with Bash
# author: @planetsLightningArrester

v_name="$1";
shift;
export "$v_name"="$*";

# EOF