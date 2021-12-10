#!/bin/sh
#
# Started by sway to launch programs.

have() { type "$1" > /dev/null 2>&1; }

if  pgrep sway && have mako; then
	mako --background-color "#2e3440" --border-color "#5e81ac" --font "Source Code Pro Medium 12" --padding 20 --default-timeout 10000 &
fi

if have emacs; then
    emacs --daemon &
fi

if have gammastep; then
    gammastep -l `whereami.py` &
fi

if have mpd; then
    [ ! -s ~/.config/mpd/pid ] && mpd &
fi

if have razercfg; then
    razercfg -r 4 &
fi

if have syncthing; then
    syncthing -no-browser &
fi

if have xbindkeys; then
    [ -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" ] && xbindkeys -f "$XDG_CONFIG_HOME/X11/xbindkeysrc" &
fi

# if have feh; then
#     feh --no-fehbg --bg-center `wallpaper.py` &
# fi

# if have polybar; then
#     [ -f "$XDG_CONFIG_HOME/polybar/launch.sh" ] && . "$XDG_CONFIG_HOME/polybar/launch.sh" &
# fi
