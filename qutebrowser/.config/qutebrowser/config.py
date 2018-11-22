import os.path

config.bind('h', 'run-with-count 2 scroll left')
config.bind('j', 'run-with-count 2 scroll down')
config.bind('k', 'run-with-count 2 scroll up')
config.bind('l', 'run-with-count 2 scroll right')

config.bind('<Shift-h>', 'run-with-count 20 scroll left')
config.bind('<Shift-j>', 'run-with-count 20 scroll down')
config.bind('<Shift-k>', 'run-with-count 20 scroll up')
config.bind('<Shift-l>', 'run-with-count 20 scroll right')

config.bind('<Ctrl-Tab>', 'tab-next')
config.bind('<Ctrl-Shift-tab>', 'tab-prev')

config.bind('zh', 'back')
config.bind('zl', 'forward')

c.auto_save.session = True
c.completion.web_history.max_items = 10000
c.content.default_encoding = 'utf-8'
c.content.pdfjs = True
c.downloads.location.directory = os.path.expanduser('~/Downloads')
c.downloads.location.prompt = False
c.editor.command = ['em', '{}']
c.keyhint.delay = 100
c.scrolling.smooth = True
c.tabs.background = True
c.tabs.title.format = '{perc}{title}'

c.fonts.monospace = 'monospace'
c.fonts.completion.category = '11pt bold monospace'
c.fonts.completion.entry = '11pt monospace'
c.fonts.tabs = '11pt monospace'
c.fonts.statusbar = '11pt monospace'
c.fonts.downloads = '11pt monospace'
c.fonts.hints = 'bold 10px monospace'
c.fonts.debug_console = '11pt monospace'
c.fonts.keyhint = '11pt monospace'
c.fonts.messages.error = '11pt monospace'
c.fonts.messages.warning = '11pt monospace'
c.fonts.messages.info = '11pt monospace'
c.fonts.prompts = '11pt monospace'

c.hints.uppercase = True

c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'aur': 'http://aur.archlinux.org/packages.php?O=0&L=0&C=0&K={}',
    'aw': 'https://wiki.archlinux.org/index.php/Special:Search?search={}',
    'gr': 'http://github.com/search?q={}',
    'gu': 'https://github.com/search?q={}&type=Users',
    'gc': 'https://github.com/search?q={}&type=Code',
    'r': 'https://reddit.com/r/{}',
    'y': 'https://www.youtube.com/results?search_query={}&search=Search'
}

config.bind(',d', 'spawn youtube-dl -o ~/Videos/%(title)s.%(ext)s {url}')
