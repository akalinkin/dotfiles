#!/bin/bash

# $ crontab -u $USER -e
# For cron: */3 * * * * /home/$USER/dotfiles/.scripts/battery-low-notification.sh
# Requires linux with notify-send



BATTINFO=`acpi -b`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:15:00 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send "Low battery" "$BATTINFO"
fi

