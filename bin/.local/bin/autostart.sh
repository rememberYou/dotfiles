#!/bin/sh
#
# Started by i3 to launch programs.

have() { type "$1" > /dev/null 2>&1; }

if have caffeine; then
    caffeine &
fi

if have compton; then
    if [ -f "$XDG_CONFIG_HOME/compton/compton.conf" ]; then
	compton --config "$XDG_CONFIG_HOME/compton/compton.conf" &
    else
	compton &
    fi
fi

if have dunst; then
    dunst &
fi

if have emacs; then
    emacs --daemon &
fi

if have feh; then
    feh --no-fehbg --bg-center `wallpaper.py` &
fi

if have nm-applet; then
    nm-applet &
fi

if have mpd; then
    [ ! -s ~/.config/mpd/pid ] && mpd &
fi

if have polybar; then
    [ -f "$XDG_CONFIG_HOME/polybar/launch.sh" ] && . "$XDG_CONFIG_HOME/polybar/launch.sh" &
fi

if have razercfg; then
    razercfg -r 4 &
fi

if have redshift-gtk; then
    redshift-gtk -l `whereami.py` &
fi

if have syncthing; then
    syncthing -no-browser &
fi

if have unclutter; then
    unclutter --ignore-scrolling --jitter 2 &
fi

if have xbindkeys; then
    [ -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" ] && xbindkeys -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" &
fi
