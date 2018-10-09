#!/bin/bash
#
# Imports various system-wide snippets, most importantly,
# "/etc/X11/xinit/xinitrc.d/50-systemd-user.sh". Of course you can do that
# directly from your own xinitrc, but if you source the files in /etc/X11, then
# you automatically get any updates Arch distributes.
for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    if [ -x "$f" ]; then
	. "$f"
    fi
done

if [ -f "$HOME/.Xresources" ]; then
    xrdb -merge "$HOME/.Xresources"
fi

setxkbmap us_qwerty-fr
start-pulseaudio-x11 &

exec i3
