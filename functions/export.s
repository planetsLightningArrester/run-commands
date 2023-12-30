#!/bin/csh
#
# Make export compatible with C-Shell
# author: @planetsLightningArrester
# shellcheck disable=all

set expression = "$*";
# No arguments, print environment set
if ( "$expression" == "" ) then
  env
else
  set split = ($expression:q:as/=/ /)
  set envName = "$split[1]"
  set expression = `echo "$expression" | sed -r -e "s/$envName\s*=//g"`
  set envName = `trim $envName`
  # No assignments, just declare the variable
  if ( ${#split} == 1 ) then
    setenv $envName;
  else
    setenv $envName "$expression";
  endif
endif

# EOF