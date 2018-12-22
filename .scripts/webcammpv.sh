#!/bin/bash
STATUSFILE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.webcammpvstatus"
usage="$(basename "$0") [-h] [-m n] -- zen mode script

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

start_mpv() {
  mpv --geometry=416x312-20-40 --ontop --border=no /dev/video0 &
  echo $! >/tmp/webcammpv.pid
}

stop_mpv() {
  kill $(cat /tmp/webcammpv.pid)
}

if [ "$MODE" = 0 ]; then
  echo "WebCamMpv: Disabled"
#  disable_mode
elif [ "$MODE" = 1 ]; then
  echo "WebCamMpv: Enabled"
#  enable_mode
elif [ "$MODE" = -1 ]; then
  echo "WebCamMpv param was not passed. Try to get from saved state"
  if [ ! -w "$STATUSFILE" ]; then
    MODE=1
    echo "$MODE" >> $STATUSFILE
  else 
    MODE=`cat $STATUSFILE`
    # toggle mode
    if [ "$MODE" = 1 ]; then MODE=0; else MODE=1;fi
  fi
else 
  echo "Incorrect -m option value"
  echo "$usage" >&2
  exit -1
fi

if [ "$MODE" = 0 ]; then stop_mpv; fi
if [ "$MODE" = 1 ]; then start_mpv; fi

