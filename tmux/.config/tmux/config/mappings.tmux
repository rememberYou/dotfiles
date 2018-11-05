# Send prefix.
unbind-key C-b
bind-key C-c send-prefix

# Force the reload of the config file.
bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded config"

# Switch panes.
bind-key -n h select-pane -L
bind-key -n l select-pane -R
bind-key -n j select-pane -U
bind-key -n k select-pane -D

# Split windows.
bind-key 3 split-window -h
bind-key 2 split-window -v

# Kill windows without prompt.
unbind-key &
bind-key x kill-window