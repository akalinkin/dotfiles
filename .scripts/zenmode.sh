#!/bin/bash
# This script toggle Zen mode
STATUSFILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.zenmodestatus"

usage="$(basename "$0") [-h] [-m n] -- toggle or enable/disable terminal ZenMode 

where: 
    -h  show this help text
    -m  set mode (0 - disabled, 1 - enabled)"

# Process args
MODE=-1
while getopts :hm: option; do
  case "${option}" in
    h) echo "$usage"; exit;;
    m) MODE=${OPTARG};;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

# toggle FullScreen (require wmctrl)
toggle_full_screen() {
  wmctrl -r ':ACTIVE:' -b toggle,fullscreen
}

# disable arrow keys
disable_arrow_kews() {
  xmodmap -e "keycode 111 = "
  xmodmap -e "keycode 113 = "
  xmodmap -e "keycode 114 = "
  xmodmap -e "keycode 116 = "
}

# enable arrow keys
enable_arrow_keys() {
  xmodmap -e "keycode 111 = Up NoSymbol Up NoSymbol Up"
  xmodmap -e "keycode 113 = Left NoSymbol Left NoSymbol Left"
  xmodmap -e "keycode 114 = Right NoSymbol Right NoSymbol Right"
  xmodmap -e "keycode 116 = Down NoSymbol Down NoSymbol Down"
}

disable_mouse() {
  # xinput set-prop 10 "Device Enabled" 0	# Ubuntu 18.04
  xinput set-prop 14 "Device Enabled" 0		# Debian Stretch
}

enable_mouse() {
  xinput set-prop 14 "Device Enabled" 1
}

enable_mode() {
  disable_arrow_kews
  disable_mouse
  toggle_full_screen
  notify-send -u low -t 1500 -a DOTFILES_SCRIPT "PowerUser" "ZenMode <b>Enabled</b>
\r
\r<i>ArrowKeys:</i> disabled
\r<i>Mouse:</i> disabled
\r<i>Fullscreen:</i> enabled"
}

disable_mode() {
  enable_arrow_keys 
  enable_mouse
  toggle_full_screen
  notify-send -u low -t 1500 -a DOTFILES_SCRIPT "PowerUser" "ZenMode <b>Disabled</b>
\r
\r<i>ArrowKeys:</i> enabled
\r<i>Mouse:</i> enabled
\r<i>Fullscreen:</i> disabled"
}

if [ "$MODE" = -1 ]; then
# TODO: Echo line below only in Verbose mode
#  echo "ZenMode param was not passed. Try to get from saved state"
  if [ ! -w "$STATUSFILE" ]; then
    MODE=1
  else 
    MODE=`cat $STATUSFILE`
    # toggle mode
    if [ "$MODE" = 1 ]; then MODE=0; else MODE=1;fi
  fi
elif [ "$MODE" = 0 ] || [ "$MODE" = 1 ]; then
  # it's alright the value in acceptable range
  # TODO: Echo line below only in Verbose mode
  echo "Correct -m option value"
else 
  echo "Incorrect -m option value"
  echo "$usage" >&2
  exit -1
fi

echo "$MODE" > $STATUSFILE

if [ "$MODE" = 0 ]; then disable_mode; fi
if [ "$MODE" = 1 ]; then enable_mode; fi

