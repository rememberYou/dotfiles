# Based on the Nord color palette.
background="#1d1f21"
foreground="#c5c8c6"

black="#282a2e"
blue="#5f819d"
cyan="#8abeb7"
green="#8c9440"
magenta="#85678f"
red="#a54242"
white="#707880"
yellow="#de935f"

# Edit panes borders.
set-option -g pane-active-border-bg $background
set-option -g pane-active-border-fg $cyan
set-option -g pane-border-bg $background
set-option -g pane-border-fg $white

# Edit the status line.
set-option -g status-bg $background
set-option -g status-fg $foreground
set-option -g status-position bottom

# Edit windows.
setw -g window-status-current-attr bold
setw -g window-status-current-bg $background
setw -g window-status-current-fg $cyan

setw -g window-status-bg $background
setw -g window-status-fg $white