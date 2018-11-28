import os.path

c.completion.web_history.max_items = 10000
c.content.default_encoding = 'utf-8'
c.content.pdfjs = True
c.downloads.location.directory = os.path.expanduser('~/Downloads')
c.downloads.location.prompt = False
c.downloads.remove_finished = 10000
c.editor.command = ['em', '{}']
c.hints.uppercase = True
c.keyhint.delay = 100
c.scrolling.smooth = True
c.tabs.background = True
c.tabs.title.format = '{perc}{title}'

# Load binding setting.
config.source('bindings.py')

# Load fonts setting.
config.source('fonts.py')

# Load search engines setting.
config.source('search_engines.py')

# Load nord theme setting.
config.source('themes/nord.py')
