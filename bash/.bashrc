#!/bin/bash
#
# Executed by bash(1) for interactive non-login shells.

[ -f "$XDG_CONFIG_HOME/sh/aliases" ] && . "$XDG_CONFIG_HOME/sh/aliases"

HISTFILE="$HOME/.local/share/bash_history"

shopt -s autocd                  # If command is a path, cd into it.
shopt -s checkjobs               # List the status of any stopped and running jobs before exiting an interactive shell.
shopt -s checkwinsize            # Check the window size after each command.
shopt -s cmdhist                 # Save all lines of a multiple line command in the same history entry.
shopt -s dotglob                 # Include dotfiles in globbing.
shopt -s gnu_errfmt              # Write shell error messages in the standard GNU error message format.
shopt -s histappend              # Append the history list to the file named by the value of HISTFILE.
shopt -s histreedit              # Give the opportunity to re-edit a failed history substitution.
shopt -s histverify              # Show before executing history commands.
shopt -s lithist                 # Multi-line commands are saved to the history with embedded new lines.
shopt -s no_empty_cmd_completion # Avoid completion on an empty line.
