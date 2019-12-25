#!/bin/bash
# Get the maximum volume of any pulseaudio sink channel
# amixer get Master | egrep -o "[0-9]+%"
set -e

vol=$(amixer get Master | awk -F'[]%[]' '/%/ {if ($5 == "off") { print "MM" } else { print $2 }}' | head -n 1)

# echo "vol:$vol"


if [ "$vol" -le 0 ] || [ "$vol" = "MM" ]; then
	msg="<fn=2>\uf6a9</fn>"
elif [ "$vol" -ge 1 ] && [ "$vol" -le 50 ]; then
	msg="<fn=2>\uf027</fn>"
elif [ "$vol" -ge 51 ] && [ "$vol" -le 100 ]; then
	msg="<fn=2>\uf028</fn>"
elif [ "$vol" -ge 101 ]; then
	msg="<fc=#FF0000><fn=2>\uf028</fn></fc>"
else
	msg="<fn=2>\uf026<fn>?"
fi

echo -e $msg

exit 0
