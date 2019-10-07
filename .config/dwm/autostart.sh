#!/bin/bash 
#
# autostart.sh
#
# Starts the programs after you are logged in

/usr/bin/compton --config /home/alex/.config/compton/compton.conf -b
nitrogen --restore &
conky &

dropbox start &
nextcloud &
telegram &
gnome-pomodoro --no-default-window &
upwork &

dte(){
  dte="$(date +"%a, %b %d \ue77d %H:%M")"
  echo -e "\ufa19 $dte"
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
  [[ -z "$battery" ]] && echo -e "\uf1e6" && return
  BATTINFO=`acpi -b`
  status="\uf590" # unknown
  if [[ `echo $BATTINFO | grep Discharging` ]]; then
    status="\uf578"
  fi
  if [[ `echo $BATTINFO | grep Charging` ]]; then
    status="\uf583"
  fi
  pers=`acpi -b | cut -d "," -f 2 | sed -e 's/^[[:space:]]*//'`

  if [[ "$status" == "\uf590" ]]; then
  	echo -e "$status $pers"
  fi
}

dockerinfo(){
  status="\uf308 ?"
  if hash docker 2>/dev/null; then
    count=`docker ps -q | wc -l `
    status="\uf308 $count"
  fi

  echo -e "$status"
}

crypto-btc-usd(){
  result=`/home/alex/.scripts/exchange_rate_btc_usd.sh`

  echo -e "\uf15a $result"
}

taskwarrior(){
  result=`task status:pending count`

  echo -e "\uf4a0 $result"
}

while true; do
     xsetroot -name "$(taskwarrior) $(crypto-btc-usd) $(dockerinfo) $(bat)  $(dte)"
     sleep 10s    # Update time every ten seconds
done &

