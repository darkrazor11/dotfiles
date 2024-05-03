#!/bin/bash
xset s 500 &
xrandr | grep 'HDMI-1-0 connected' | ifne xrandr --output HDMI-1-0 --auto --left-of eDP-1
TOUCHPAD_ID=`xinput | grep 'PIXA3848:00 093A:3848 Touchpad' | cut -f 2 | cut -f 2 -d =`
xinput set-prop $TOUCHPAD_ID "libinput Tapping Enabled" 1
xinput set-prop $TOUCHPAD_ID "libinput Natural Scrolling Enabled" 1
setxkbmap -layout us