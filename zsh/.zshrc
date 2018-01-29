# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/someone/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='emacsclient'
else
    export EDITOR='nano'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias zshconfig="emacsclient ~/.zshrc"

alias yeam="youtube-dl --extract-audio --audio-format mp3"

function pdf2eps {
    inkscape $1 --export-eps=$2
}

# Converts
alias pdf2eps=pdf2eps $1 $2
alias doc2pdf="libreoffice --headless --convert-to pdf *.docx"
alias odt2pdf="libreoffice --headless --convert-to pdf *.odt"

# Battery
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'

# Docker
alias dke="docker exec -it $1 sh"
alias dkr="docker run -d -P --name $1 $2"

# Emacs
alias ec='emacsclient -a "" -c'

# Emoji
alias cpangel="xclip -selection clipboard /home/someone/Documents/Emojis/angel"
alias cpheart="xclip -selection clipboard /home/someone/Documents/Emojis/heart"
alias cpkiss="xclip -selection clipboard /home/someone/Documents/Emojis/kiss"
alias cpumbrella="xclip -selection clipboard /home/someone/Documents/Emojis/umbrella"
alias cpsad="xclip -selection clipboard /home/someone/Documents/Emojis/sad"
alias cpsmile="xclip -selection clipboard /home/someone/Documents/Emojis/smile"

# GPG
alias gpgC="gpg --recipient $GPGKEY --encrypt"
alias gpgDP="gpg --delete-keys"
alias gpgDS="gpg --delete-secret-keys"
alias gpgE="gpg --edit-key"
alias gpgG="gpg --full-generate-key"
alias gpgLP="gpg --list-keys"
alias gpgLS="gpg -K"
alias gpgR="gpg-connect-agent reloadagent /bye"

# LaTeX
alias cleartex="rm -rf *(.aux|.log|.nav|.out|.snm|.toc|synctex\.gz|.blg|.bbl)"
alias xelatex="xelatex --shell-escape"

# nmcli
alias list_wifi="nmcli device wifi list"

# systemctl
alias services="systemctl list-unit-files | grep enabled && systemctl --user list-unit-files | grep enabled"

# top
alias top_mem="top -b -o +%MEM | head -n 22"
alias top_cpu="top -b -o +%MEM | head -n 22"

# pacman
alias inpac="pacman -Qmq | sort"
alias mymakepkg="makepkg -sirc"

# Navigation
alias gD="cd ~/Downloads/"
alias gde="cd ~/Desktop/"
alias gdo="cd ~/Documents"

alias gp="cd ~/Pictures/"
alias gw="cd ~/Pictures/Wallpapers/2560x1440/"
alias gW="cd ~/Pictures/Wallpapers/"

export PATH="/home/someone/.gem/ruby/2.4.0/bin:$PATH"
export GPGKEY="$(gpg -K | awk 'NR==4 {print $1}' | sed 's/4096R\///g')"

# set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X Session
gpg-connect-agent updatestartuptty /bye >/dev/null

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# [13:29:19] someone:heroku-dadada git:(master*) $ gem install travis
# WARNING:  You don't have /home/someone/.gem/ruby/2.4.0/bin in your PATH,
# 	  gem executables will not run.
# Successfully installed travis-1.8.8
# Parsing documentation for travis-1.8.8
# Done installing documentation for travis after 1 seconds
# 1 gem installed

# journalctl -b -1