#!/bin/bash

# This script records a screencast with audio and video.
# It runs an appropriate record script for either ALSA and Pulseaudio.
# It also names files smartly to prevent overwrites.

# Picks a file name for the output file based on availability:
while [[ -f $HOME/Videos/screencast$n.mkv ]]
do
	n=$((n+1))
done
filename="$HOME/Videos/screencast$n.mkv"

# For Pulseaudio with ALSA:
record_pulse() { \
ffmpeg -y \
-f x11grab \
-framerate 60 \
-s 1920x1080 \
-i :0.0 \
-f alsa -i default \
-r 30 \
 -c:v libx264rgb -crf 0 -preset ultrafast -c:a flac $filename ;}
#-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \

# For ALSA:
record_alsa() { \
ffmpeg -y \
-f x11grab \
-s 1920x1080 \
-i :0.0 \
-thread_queue_size 1024 \
 -f alsa -ar 44100 -i hw:1 \
 -c:v libx264 -r 30 -c:a flac $filename ;}
#-s $(xdpyinfo | grep dimensions | awk '{print $2;}') \

if [[ $(pgrep -x pulseaudio) ]]; then record_pulse; else record_alsa; fi &
# Updating i3blocks recording icon:
# echo ⏺️ > ~/.scripts/.recording && pkill -RTMIN+9 i3blocks
