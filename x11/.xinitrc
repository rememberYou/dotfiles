#!/bin/bash

PATH=$PATH:$HOME:$HOME/bin/

user_resources=$HOME/.Xresources

if [ -f "$user_resources" ]; then
    xrdb -merge "$user_resources"
fi

setxkbmap us_qwerty-fr
start-pulseaudio-x11 &

exec i3

# source ~/.zprofile
# sway
