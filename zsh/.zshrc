#!/bin/zsh
#
# Executed by zsh(1) for interactive shells.

ZSH_THEME="geoffgarside"

[ -f "$XDG_CONFIG_HOME/sh/aliases" ] && . "$XDG_CONFIG_HOME/sh/aliases"

export HISTFILE="$XDG_DATA_HOME/zsh_history"

setopt always_to_end          # Move the cursor to the end of the word after each completion.
setopt auto_cd                # If command is a path, cd into it.
setopt auto_pushd             # Make cd push old dir in dir stack.
setopt auto_resume            # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt brace_ccl              # Expand expressions in braces to allow things like `echo {a-g}`.
setopt cdable_vars            # Add '~' to every cd commands which the argument is not a directory and does not begin with a slash.
setopt combining_chars        # Display combining characters correctly.
setopt complete_in_word       # Make the cursor stays there and completion is done from both ends.
setopt extended_history       # Save each command's beginning timestamp and the duration to the history file.
setopt glob_dots              # Include dotfiles in globbing.
setopt hist_expire_dups_first # Cause the oldest history event that has a duplicate to be lost before losing a unique event from the list.
setopt hist_find_no_dups      # When searching for history entries in the line editor, do not display duplicates of a line previously found.
setopt hist_ignore_all_dups   # Avoid duplication when adding a new command.
setopt hist_ignore_dups       # Do not enter command lines into the history list if they are duplicates of the previous event.
setopt hist_ignore_space      # Remove command lines from the history list when the first character on the line is a space.
setopt hist_save_no_dups      # When writing out the history file, older commands that duplicate newer ones are omitted.
setopt hist_verify            # Show before executing history commands.
setopt inc_append_history     # Add commands as they are typed, don't wait until shell exit.
setopt interactive_comments   # Allow comments even in interactive shells.
setopt long_list_jobs         # List jobs in the long format by default.
setopt nomultios              # No perform implicit tees or cats when multiple redirections are attempted (e.g. no things like: `< a < b > c`).
setopt nonomatch              # If a pattern for filename generation has no matches, leaving it unchanged instead of printing an error.
setopt notify                 # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt path_dirs              # Perform a path search even on command names with slashes in them.
setopt posix_builtins         # Allow builtin to execute shell builtin commands.
setopt prompt_subst           # Parameter expansion, command substitution and arithmetic expansion are performed in prompts.
setopt pushd_ignore_dups      # No duplicates in dir stack.
setopt pushd_silent           # No dir stack after pushd or popd.
setopt pushd_to_home          # `pushd` = `pushd $HOME`
setopt rc_quotes              # Allow the character sequence `''' to signify a single quote within singly quoted strings.
setopt rm_star_silent         # Do not query the user before executing `rm *' or `rm path/*'.
setopt share_history          # Import new commands from the history file, and append typed commands to the history file.

unsetopt beep                 # No bell on error.
unsetopt bg_nice              # No lower priority for background jobs.
unsetopt check_jobs           # No report the status of background and suspended jobs before exiting a shell with job control.
unsetopt flow_control         # Output flow control via start/stop characters is disabled in the shell's editor.
unsetopt hist_beep            # No bell on error in history.
unsetopt hup                  # No hup signal at shell exit.

alias zshcfg="emacsclient ~/.zshrc"

plugins=(z zsh-autosuggestions zsh-syntax-highlighting)

. ~/.config/oh-my-zsh/oh-my-zsh.sh

if [ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=11'

# Add only functional commands to the history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }
