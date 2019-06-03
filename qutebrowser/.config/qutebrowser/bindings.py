config.bind('<Ctrl-Shift-tab>', 'tab-prev')
config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('<Ctrl-h>', 'history')
config.bind('<Ctrl-r>', 'config-source')

config.bind('<Shift-h>', 'run-with-count 20 scroll left')
config.bind('<Shift-j>', 'run-with-count 20 scroll down')
config.bind('<Shift-k>', 'run-with-count 20 scroll up')
config.bind('<Shift-l>', 'run-with-count 20 scroll right')

config.bind('<', 'back')
config.bind('>', 'forward')
config.bind('h', 'run-with-count 2 scroll left')
config.bind('j', 'run-with-count 2 scroll down')
config.bind('k', 'run-with-count 2 scroll up')
config.bind('l', 'run-with-count 2 scroll right')

config.bind("xE", 'open -t -- https://translate.google.com/#en/fr/{primary}')
config.bind("xF", 'open -t -- https://translate.google.com/#fr/en/{primary}')

config.bind("xjn", "set content.javascript.enabled true")
config.bind("xjf", "set content.javascript.enabled false")

config.bind(';m', 'hint links spawn mpv {hint-url}')

config.bind(',d', 'spawn youtube-dl -o ~/Videos/%(title)s.%(ext)s {url}')
config.bind(',m', 'spawn mpv {url}')
config.bind(',P', 'spawn --userscript qutepass.py')
config.bind(',pp', 'spawn --userscript qutepass.py --password-only')
config.bind(',pu', 'spawn --userscript qutepass.py --username-only')
