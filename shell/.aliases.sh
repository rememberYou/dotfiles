#!/bin/sh

unalias -a

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