#!/bin/sh
#
# This script retrieves unread messages from your Reddit account using a JSON
# link.
#
# To use this script, make sure you have the following dependencies installed:
# `curl`, `jq`, `ttf-font-awesome`.
#
# NOTE: `polybar-reddit` can also be used outside of polybar by replacing the
# following line: echo -e "%{F#cb4b16} %{F-}$unread"
# by: echo " $unread"
#
# WARNING: in order to easily share this script without security risk, it is
# recommended to place the JSON part containing the sensitive information in a
# separate GPG file.

# Replace this path by yours.
reddit_gpg="/home/$USER/.gnupg/shared/.reddit-json.gpg"
url="https://www.reddit.com/message/unread/.json?feed=$(gpg -qd "$reddit_gpg")"
unread=$(curl -sf "$url" | jq '.["data"]["children"] | length')

case "$unread" in
    ''|*[!0-9]*)
	unread=0
esac;

if [ "$unread" -gt 0 ]; then
    echo "%{F#cb4b16} %{F-}$unread"
else
    echo " 0"
fi
