#!/bin/sh
#
# Executed by login shells.
# Not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

# Cache directory for Ccache.
export CCACHE_DIR="$XDG_CACHE_DIR/ccache"
# Tells Ccache to only use compilers in this directory.
export CCACHE_PATH="/usr/bin"

# Use emacsclient as default text editor.
export EDITOR="emacsclient -a '' -t"

# Useful to inform Polybar of GitHub's token.
GITHUB_ACCESS_TOKEN="$(gpg -qd "$HOME/.gnupg/shared/.github-token.gpg")"
export GITHUB_ACCESS_TOKEN

# Identify the private key.
GPGKEY="$(gpg -K | awk 'NR==4 {print $1}' | sed 's/4096R\///g')"
export GPGKEY

# Used by gpg-agent.
GPG_TTY="$(tty)"
export GPG_TTY

# Manage the storage history of the commands.
export HISTCONTROL='ignorespace:erasedups'
# Increase the history file size.
export HISTFILESIZE=1000
# Ignore the archiving of the following commands.
export HISTIGNORE='exit:poweroff:reboot:shutdown'
# Increase the history size.
export HISTSIZE=10000

# Related to Java.
export JAVA_HOME="/usr/lib/jvm/default-runtime"
export JDK_HOME="/usr/lib/jvm/default"

# Prevent `less` from storing the history.
export LESSHISTFILE="-"

# Disable warning for GTK-based applications.
export NO_AT_BRIDGE=1

# Set length of passwords generated by pass.
export PASSWORD_STORE_GENERATED_LENGTH=50

# Allows you to use $HOME/bin's bash scripts anywhere.
export PATH="$PATH:$HOME/bin"
if [ ! -d "$HOME/bin" ]; then
    mkdir -p "$PATH"
fi

# Loads the specified modules and other codes when Python starts.
export PYTHONSTARTUP="$HOME/.pythonrc"

# Increase the history save size.
export SAVEHIST=10000

# Tell the Shell used by default.
export SHELL=${SHELL:-/bin/bash}

# Use termite as default terminal.
export TERMINAL="termite"

# Add temporary files according to the user.
export TMPDIR="/tmp/$USER"
if [ ! -d "$TMPDIR" ]; then
    mkdir -m 700 "$TMPDIR"
fi

# Create extra folders for XDG.
export XDG_CACHE_DIR="$HOME/.cache"
export XDG_CONFIG_DIR="$HOME/.config"
export XDG_DATA_DIR="$HOME/.local/share"
mkdir -p "$XDG_CACHE_DIR" "$XDG_CONFIG_DIR" "$XDG_DATA_DIR"

# Path to the oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Start graphical server if i3 is not already running on TTY1.
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep -x i3 || exec startx
fi

# Start graphical server if sway is not already running on TTY2.
if [ "$(tty)" = "/dev/tty2" ]; then
    pgrep -x sway || exec sway

    export XKB_DEFAULT_LAYOUT=us
    export XKB_DEFAULT_OPTIONS=caps:escape
    export XKB_DEFAULT_VARIANT=intl
fi

# Aliases
# ----------------------------------------

# Convertions
alias doc2pdf="libreoffice --headless --convert-to pdf *.docx"
alias odt2pdf="libreoffice --headless --convert-to pdf *.odt"

# Battery
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'

# Display
alias ls='ls --color=auto'

# Docker
alias dke="docker exec -it $1 sh"
alias dkr="docker run -d -P --name $1 $2"

# Emoji
alias cpangel="xclip -selection clipboard \$HOME/Documents/Emojis/angel"
alias cpheart="xclip -selection clipboard \$HOME/Documents/Emojis/heart"
alias cpkiss="xclip -selection clipboard \$HOME/Documents/Emojis/kiss"
alias cpumbrella="xclip -selection clipboard \$HOME/Documents/Emojis/umbrella"
alias cpsad="xclip -selection clipboard \$HOME/Documents/Emojis/sad"
alias cpsmile="xclip -selection clipboard \$HOME/Documents/Emojis/smile"

# GNU Emacs
alias ec="emacsclient -a '' -t"
alias moc="mu cfind --format=org-contact"

# GPG
alias gpgC="gpg --recipient \$GPGKEY --encrypt"
alias gpgDP="gpg --delete-keys"
alias gpgDS="gpg --delete-secret-keys"
alias gpgE="gpg --edit-key"
alias gpgG="gpg --full-generate-key"
alias gpgLP="gpg --list-keys"
alias gpgLS="gpg -K"
alias gpgR="gpg-connect-agent reloadagent /bye"

# LaTeX
alias xelatex="xelatex --shell-escape"

# Navigation
alias gD="cd ~/Downloads/"
alias gde="cd ~/Desktop/"
alias gdo="cd ~/Documents"
alias gp="cd ~/Pictures/"
alias gw="cd ~/Pictures/Wallpapers/2560x1440/"
alias gW="cd ~/Pictures/Wallpapers/"

# nmcli
alias list_wifi="nmcli device wifi list"

# pacman
alias inpac="pacman -Qmq | sort"
alias mymakepkg="makepkg -sirc"

# systemctl
alias services="systemctl list-unit-files | grep enabled && systemctl --user list-unit-files | grep enabled"

# top
alias top_mem="top -b -o +%MEM | head -n 22"
alias top_cpu="top -b -o +%MEM | head -n 22"

# Traduction
alias de="trans --brief :de"
alias en="trans --brief :en"
alias fr="trans --brief :fr"
alias it="trans --brief :it"
alias nl="trans --brief :nl"

# youtube-dl
alias yeam="youtube-dl --embed-thumbnail --extract-audio --audio-format mp3 --audio-quality 0 -o '~/Music/%(title)s.%(ext)s'"
