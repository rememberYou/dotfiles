# Set default prefix.
set-option -g prefix C-c

# Default term.
set-option -g default-terminal "screen-256color"

# Time in milliseconds for which tmux waits after an escape.
set -sg escape-time 0

# Keep commands history and set its limit.
set-option -g history-file ~/.cache/tmux/history
set-option -g history-limit 10000