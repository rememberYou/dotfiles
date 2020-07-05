import os.path

c.qt.force_platform = 'xcb'
c.completion.web_history.max_items = 10000
c.content.default_encoding = "utf-8"
c.content.javascript.enabled = False
c.content.pdfjs = True
c.downloads.location.directory = os.path.expanduser("~/Downloads")
c.downloads.location.prompt = False
c.downloads.remove_finished = 10000
c.editor.command = ["em", "{}"]
c.hints.uppercase = True
c.keyhint.delay = 100
c.scrolling.smooth = True
c.tabs.background = True
c.tabs.title.format = "{perc}{current_title}"
c.url.default_page = "https://news.ycombinator.com/"

# Load binding setting.
config.source("bindings.py")

# Load fonts setting.
config.source("fonts.py")

# Load search engines setting.
config.source("search_engines.py")

# Load nord theme setting.
config.source("themes/nord.py")

js_whitelist = [
    "*://*.youtube.com/*",
    "*://127.0.0.1/*",
    "*://darksky.net/*",
    "*://deepl.com/*",
    "*://duckduckgo.com/*",
    "*://github.com/*",
    "*://localhost/*",
    "*://news.ycombinator.com/*",
    "*://reddit.com/*",
    "*://translate.google.com/*",
]

private_whitelist = os.path.expanduser(
    "~/.config/qutebrowser/private-whitelist"
)
if os.path.exists(private_whitelist):
    with open(private_whitelist) as f:
        js_whitelist += filter(lambda l: bool(l), f.read().split("\n"))

for site in js_whitelist:
    with config.pattern(site) as p:
        p.content.javascript.enabled = True
