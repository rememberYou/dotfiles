#!/bin/sh
#
# This script allows you to notify new incoming emails using an imap server like
# isync or offlineimap.
#
# To use this script with the logo, make sure you have installed Font Awesome,
# available with the `ttf-font-awesome` package
#
# NOTE: `polybar-mail` can also be used outside of polybar by replacing the
# following line: echo -e "%{F#cb4b16} %{F-}$numfiles"
# by: echo " $numfiles"

shopt -s nullglob

# Replace the path below with yours.
numfiles=(~/Maildir/gmail/INBOX/new/*)
numfiles=${#numfiles[@]}

if [ $numfiles -gt 0 ] ; then
    echo "%{F#cb4b16} %{F-}$numfiles"
else
    echo " $numfiles"
fi
