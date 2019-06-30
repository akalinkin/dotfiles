#!/bin/bash
#
# autostart.sh
# chmod 775
#
# Starts the programs after you are logged in


nitrogen --restore &
dropbox start &

dte(){
  dte="$(date +"%a, %b %d | %l:%M%p")"
  echo -e "$dte \ue77d" # 
}

mem(){
  mem=`free | awk '/Mem/ {printf "%d/%d\n", $3 / 1024.0, $2 / 1024.0 }'`
  echo -e "\uf85a $mem"
}

cpu(){
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep 0.5
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -e "\ue266 $cpu%"
}

while true; do
     xsetroot -name "$(cpu) | $(mem) | $(dte)"
     sleep 10s    # Update time every ten seconds
done &

