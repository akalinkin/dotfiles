#!/bin/bash
# For cron: */20 10-21 * * MON,TUE,WED,THU,FRI env DISPLAY=:0.0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /home/$USER/dotfiles/.scripts/taskwarrior-popup.sh
# Requires linux with notify-send and canberra-gtk-play which are default on Ubuntu

num=`/usr/bin/task active | /usr/bin/wc -l`
if [ $num -gt "1" ]
  then
    /usr/bin/notify-send "Tasks" "`/usr/bin/task active | /usr/bin/awk '{ print "["$1"] "$6"@"$5  }' | /usr/bin/tail -n +4 | /usr/bin/head -n -2`" 
#    canberra-gtk-play --file=/usr/share/sounds/gnome/default/alerts/drip.ogg
  else
    /usr/bin/notify-send "Tasks" "So long without active task" 
#    canberra-gtk-play --file=/usr/share/sounds/ubuntu/stereo/dialog-question.ogg
fi
