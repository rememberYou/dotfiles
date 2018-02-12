# Executed by zsh(1) for interactive shells.

ZSH_THEME="geoffgarside"
plugins=(git)

# ----------------------------------------

HISTCONTROL='ignorespace:erasedups'
HISTFILE="$HOME/.local/share/zsh_history"
HISTFILESIZE=1000
HISTIGNORE='exit'
HISTSIZE=10000
SAVEHIST=10000

setopt always_to_end          # move the cursor to the end of the word after each completion.
setopt auto_cd                # if command is a path, cd into it.
setopt auto_pushd             # make cd push old dir in dir stack.
setopt auto_resume            # treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt brace_ccl              # expand expressions in braces to allow things like `echo {a-g}`.
setopt cdable_vars            # add '~' to every cd commands which the argument is not a directory and does not begin with a slash.
setopt combining_chars        # display combining characters correctly.
setopt complete_in_word       # make the cursor stays there and completion is done from both ends.
setopt extended_history       # save each command's beginning timestamp and the duration to the history file.
setopt glob_dots              # include dotfiles in globbing.
setopt hist_expire_dups_first # cause the oldest history event that has a duplicate to be lost before losing a unique event from the list.
setopt hist_find_no_dups      # when searching for history entries in the line editor, do not display duplicates of a line previously found.
setopt hist_ignore_all_dups   # avoid duplication when adding a new command.
setopt hist_ignore_dups       # do not enter command lines into the history list if they are duplicates of the previous event.
setopt hist_ignore_space      # remove command lines from the history list when the first character on the line is a space.
setopt hist_save_no_dups      # when writing out the history file, older commands that duplicate newer ones are omitted.
setopt hist_verify            # show before executing history commands.
setopt inc_append_history     # add commands as they are typed, don't wait until shell exit.
setopt interactive_comments   # allow comments even in interactive shells.
setopt long_list_jobs         # list jobs in the long format by default.
setopt nomultios              # no perform implicit tees or cats when multiple redirections are attempted (e.g. no things like: `< a < b > c`).
setopt nonomatch              # if a pattern for filename generation has no matches, leaving it unchanged instead of printing an error.
setopt notify                 # report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt path_dirs              # perform a path search even on command names with slashes in them.
setopt posix_builtins         # allow builtin to execute shell builtin commands.
setopt prompt_subst           # parameter expansion, command substitution and arithmetic expansion are performed in prompts.
setopt pushd_ignore_dups      # no duplicates in dir stack.
setopt pushd_silent           # no dir stack after pushd or popd.
setopt pushd_to_home          # `pushd` = `pushd $HOME`
setopt rc_quotes              # allow the character sequence `''' to signify a single quote within singly quoted strings.
setopt rm_star_silent         # do not query the user before executing `rm *' or `rm path/*'.
setopt share_history          # import new commands from the history file, and append typed commands to the history file.

unsetopt beep                 # no bell on error.
unsetopt bg_nice              # no lower priority for background jobs.
unsetopt check_jobs           # no report the status of background and suspended jobs before exiting a shell with job control.
unsetopt flow_control         # output flow control via start/stop characters is disabled in the shell's editor.
unsetopt hist_beep            # no bell on error in history.
unsetopt hup                  # no hup signal at shell exit.

# Aliases
# ----------------------------------------

# Convertions
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
alias cpangel="xclip -selection clipboard $HOME/Documents/Emojis/angel"
alias cpheart="xclip -selection clipboard $HOME/Documents/Emojis/heart"
alias cpkiss="xclip -selection clipboard $HOME/Documents/Emojis/kiss"
alias cpumbrella="xclip -selection clipboard $HOME/Documents/Emojis/umbrella"
alias cpsad="xclip -selection clipboard $HOME/Documents/Emojis/sad"
alias cpsmile="xclip -selection clipboard $HOME/Documents/Emojis/smile"

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
alias en="trans --brief :en"
alias fr="trans --brief :fr"

# youtube-dl
alias yeam="youtube-dl --extract-audio --audio-format mp3"

# zsh
alias zshconfig="emacsclient ~/.zshrc"


# Sources
# ----------------------------------------

. $ZSH/oh-my-zsh.sh


# ----------------------------------------

# Refresh gpg-agent tty in case user switches into an X Session
gpg-connect-agent updatestartuptty /bye >/dev/null
