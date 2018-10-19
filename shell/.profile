#!/bin/sh
#
# Executed by login shells.
# Not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
# shellcheck disable=SC1090
# shellcheck disable=SC2174

. ~/.environ

# Tell the Shell used by default.
export SHELL=${SHELL:-/bin/bash}

# Path to the oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Create the XDG folders if it's not done yet.
test -d "$XDG_CACHE_HOME"  || mkdir -p -m 0700 "$XDG_CACHE_HOME"
test -d "$XDG_CONFIG_HOME" || mkdir -p -m 0700 "$XDG_CONFIG_HOME"
test -d "$XDG_DATA_HOME"   || mkdir -p -m 0700 "$XDG_DATA_HOME"

if [ "$BASH" ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
