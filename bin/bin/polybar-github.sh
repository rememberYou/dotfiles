#!/bin/sh
#
# This script retrieves unread notifications from your GitHub account using a
# token.
#
# To use this script, make sure you have the following dependencies installed:
# `curl`, `jq`, `ttf-font-awesome`.
#
# NOTE: `polybar-github` can also be used outside of polybar by replacing the
# following line: echo -e "%{F#cb4b16} %{F-}$unread"
# by: echo " $unread"
#
# WARNING: in order to easily share this script without security risk, it is
# recommended to place the JSON part containing the sensitive information in a
# separate GPG file.

# Replace the path below with yours.
TOKEN="/home/$USER/Sync/shared/.github-token.gpg"
url="https://api.github.com/notifications?access_token=$(gpg -qd "$TOKEN")"
notifications=$(curl -fs "$url" | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "%{F#cb4b16} %{F-}$notifications"
else
    echo " 0"
fi
