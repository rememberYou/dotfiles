#!/bin/bash

user_resources=$HOME/.Xresources

if [ -f "$user_resources" ]; then
    xrdb -merge "$user_resources"
fi

start-pulseaudio-x11 &

exec i3
# source ~/.zprofile
# sway
