#!/bin/zsh
#
# Executed by zsh(1) for interactive shells.

ZSH_THEME="geoffgarside"

# ----------------------------------------


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
export HISTFILE="$HOME/.local/share/zsh_history"
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


# zsh
alias zshconfig="emacsclient ~/.zshrc"

# Sources
# ----------------------------------------

. $ZSH/oh-my-zsh.sh

if ! [ -d "$HOME/.zplug" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

. ~/.zplug/init.zsh

if type zplug >/dev/null 2>&1; then
	zplug "rupa/z", use:z.sh
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    if ! zplug check --verbose; then
	print - "Install? [y/N]: "
	if read -s; then
	    zplug install;
	fi
    fi
    zplug load
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'

# ----------------------------------------

# Add only functional commands to the history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# Refresh gpg-agent tty in case user switches into an X Session
gpg-connect-agent updatestartuptty /bye >/dev/null
