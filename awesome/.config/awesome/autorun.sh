#!/usr/bin/env bash

function run {
    if ! pgrep $1 ; then
        $@&
    fi
}

# Set the terminal transparent.
run compton -f

# Set the default brightness.
run xbacklight -set 60

# Run xbindkey.
run xbindkeys

# Launches daemons.
run emacs --daemon

# Launches applets.
run nm-applet
run redshift-gtk -l 50.4814:4.5488
run caffeine

if xrandr | grep -q 'HDMI2 connected' ; then
    xrandr --output eDP1 --auto --primary --output HDMI2 --right-of eDP1 --auto
elif xrandr | grep -q 'HDMI1 connected' ; then
    xrandr --output eDP1 --auto --primary --output HDMI1 --right-of eDP1 --auto
fi

# Locker
run xautolock -time 10 -locker 'xtrlock'
