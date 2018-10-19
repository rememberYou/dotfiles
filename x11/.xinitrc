#!/bin/sh
#
# Executed by startx (run your window manager from here)
# shellcheck disable=SC1090
# shellcheck disable=SC1091

# Imports various system-wide snippets.
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do	
	[ -x "$f" ] && . "$f"
    done
    unset f
fi

cd ~ || exit

# Set the brightness.
xbacklight -set 40

# Turn off the bell.
xset -b

# Load global profiles.
[ -f /etc/profile ] && . /etc/profile
[ -f ~/.profile ] && . ~/.profile

# Load specific X11 profiles.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Load X11 resources.
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

setxkbmap us_qwerty-fr

# Start graphical server if there is not already a session running on TTY1.
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep -x i3 || exec ssh-agent i3
fi
