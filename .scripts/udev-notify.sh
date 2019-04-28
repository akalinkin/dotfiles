#!/bin/bash

# run monitor:
# $ udevadm monitor --kernel --property --subsystem-match=usb
# plug in usb flashm find and copy product from output
#
# $ sudo vim /etc/udev/rules.d/key-usb-flash-notify.rules
# SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="$PRODUCT", RUN+="/bin/su $USER --command='/home/$USER/dotfiles/.scripts/udev-notify.sh'"
# replace $USER,$PRODUCT with related values
# save and close file, reload rules
# $ sudo udevadm control --reload

DISPLAY=:0.0 /usr/bin/notify-send "Keys flash" "Keys flash {$ACTION}"
# TODO: // Mount usb, openLuks -> with key passphrase request
