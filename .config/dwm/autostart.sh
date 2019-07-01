#!/bin/bash
#
# autostart.sh
# chmod 775
#
# Starts the programs after you are logged in

nitrogen --restore &
dropbox start &
telegram &

dte(){
  dte="$(date +"%a, %b %d \ue77d %H:%M")"
  echo -e "$dte"
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d/%d\n", $3 / 1024.0 / 1024.0 , $2 / 1024.0 / 1024.0 }'`
  echo -e "\uf85a $mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  temp=`sensors | grep "Physical\|Package" | cut -d " " -f 5`
  echo -e "\ue266 $cpu% $temp"
}

bat(){
  battery=`upower -e | grep BAT`
  [[ -z "$battery" ]] && return
  BATTINFO=`acpi -b`
  status="\uf590" # unknown
  if [[ `echo $BATTINFO | grep Discharging` ]]; then
    status="\uf578"
  fi
  if [[ `echo $BATTINFO | grep Charging` ]]; then
    status="\uf583"
  fi
  pers=`acpi -b | cut -d "," -f 2 | sed -e 's/^[[:space:]]*//'`

  echo -e "$status $pers"
}

while true; do
     xsetroot -name "$(bat) | $(cpu) | $(mem) | $(dte)"
     sleep 10s    # Update time every ten seconds
done &

