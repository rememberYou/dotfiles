# Send prefix.
unbind C-b
bind C-c send-prefix

# Reload the configuration file.
bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded config"

# Switch panes.
bind h select-pane -L
bind j select-pane -U
bind k select-pane -D
bind l select-pane -R

# Resize panes.
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Split windows.
bind 3 split-window -h
bind 2 split-window -v

# Kill windows without prompt.
unbind &
bind x kill-window