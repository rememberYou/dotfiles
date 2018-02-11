# Executed by bash(1) for interactive non-login shells.

HISTCONTROL='ignorespace:erasedups'
HISTFILE="$HOME/.local/share/bash_history"
HISTFILESIZE=1000
HISTIGNORE='exit'
HISTSIZE=10000

shopt -s autocd                  # if command is a path, cd into it.
shopt -s checkjobs               # lists the status of any stopped and running jobs before exiting an interactive shell.
shopt -s checkwinsize            # checks the window size after each command.
shopt -s cmdhist                 # save all lines of a  multipleline command in the same history entry.
shopt -s dotglob                 # include dotfiles in globbing.
shopt -s gnu_errfmt              # write shell error messages in the standard GNU error message format.
shopt -s histappend              # append the history list to the file named by the value of HISTFILE.
shopt -s histreedit              # give the opportunity to re-edit a failed history substitution.
shopt -s histverify              # show before executing history commands.
shopt -s lithist                 # multi-line commands are saved to the history with embedded new lines.
shopt -s no_empty_cmd_completion # avoid completion on an empty line.


# ----------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
