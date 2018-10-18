#!/bin/bash
# This script toggle Nightmare mode

usage="$(basename "$0") [-h] [-m n] -- nightmare mode script

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
  xinput set-prop 10 "Device Enabled" 0	
}

enable_mouse() {
  xinput set-prop 10 "Device Enabled" 1
}

enable_mode() {
  disable_arrow_kews
  disable_mouse
}

disable_mode() {
  enable_arrow_keys 
  enable_mouse
}

if [ "$MODE" = 0 ]; then
  echo "NightmareMode: Disabled"
  disable_mode
elif [ "$MODE" = 1 ]; then
  echo "NightmareMode: Enabled"
  enable_mode
elif [ "$MODE" = -1 ]; then
  echo "NightmareMode param was not passed. Try to get from TODO: some state"
else 
  echo "Incorrect -m option value"
  echo "$usage" >&2
  exit -1
fi





