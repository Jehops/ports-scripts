#!/bin/sh

# find port(s) in a local ports tree
#
# Usage: fp [-i] <search term>
#
# -i: case insensitive search
# <search term> may contain quoted glob patterns
#
# The only variable expected in ${HOME}/.ports.conf (with the sample
# value, /usr/ports):
#
# portsd='/usr/ports' # path to the local ports directory
#
# Examples:
#
# % fp stump\*
# x11-wm/stumpwm
#
# % fp -i "Stump*"
# x11-wm/stumpwm

. "$HOME/.ports.conf"

find="/usr/bin/find"
sed="/usr/bin/sed"

while getopts ":i" opt; do
  case $opt in
    i)  i_opt='-i' ;;
    \?) fatal "Invalid option: -$OPTARG" ;;
  esac
done
shift $(( OPTIND - 1 ))

if [ "$i_opt" = "-i" ]; then
  $find $portsd -type d -depth 2 -iname "$1" | $sed -e "s|$portsd/||"
else
  $find $portsd -type d -depth 2 -name "$1" | $sed -e "s|$portsd/||"
fi
