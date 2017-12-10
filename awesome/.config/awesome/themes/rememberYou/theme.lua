-------------------------------
--    "rememberYou" theme    --
--     Terencio Agozzino     --
--     License:  GNU GPL v2  --
-------------------------------

local theme_assets = require("beautiful.theme_assets")
local theme = {}

theme.confdir = os.getenv("HOME") .. "/.config/awesome/themes/rememberYou"
theme.wallpaper = theme.confdir .. "/wallpapers/wall.png"

-- Color scheme
black  = "#000000"
cyan   = "#6bbed2"
grey   = "#747474"
orange = "#f1af5f"
red    = "#ff5137"
white  = "#dddcff"

theme.font                                      = "Terminus 8"

-- Titlebar background.
theme.bg_normal                                 = black
theme.bg_focus                                  = black
theme.bg_urgent                                 = black

-- Titlebar foreground.
theme.fg_normal                                 = grey
theme.fg_focus                                  = orange
theme.fg_urgent                                 = red
theme.fg_minimize                               = "#ffffff"

-- Windows's border.
theme.border_width                              = 1
theme.border_normal                             = "#1c2022"
theme.border_focus                              = "#606060"
theme.border_marked                             = "#3ca4d8"

-- Menu's details.
theme.menu_border_width                         = 0
theme.menu_bg_normal                            = "#050505dd"
theme.menu_bg_focus                             = "#050505dd"
theme.menu_fg_normal                            = "#aaaaaa"
theme.menu_fg_focus                             = orange
theme.menu_submenu_icon                         = theme.confdir .. "/icons/submenu/submenu.png"
theme.menu_height                               = 15
theme.menu_width                                = 130

-- Layouts Icons.
theme.layout_tile                               = theme.confdir .. "/icons/layouts/tilew.png"
theme.layout_tilegaps                           = theme.confdir .. "/icons/layouts/tilegapsw.png"
theme.layout_tileleft                           = theme.confdir .. "/icons/layouts/tileleftw.png"
theme.layout_tilebottom                         = theme.confdir .. "/icons/layouts/tilebottomw.png"
theme.layout_tiletop                            = theme.confdir .. "/icons/layouts/tiletopw.png"
theme.layout_fairv                              = theme.confdir .. "/icons/layouts/fairvw.png"
theme.layout_fairh                              = theme.confdir .. "/icons/layouts/fairhw.png"
theme.layout_spiral                             = theme.confdir .. "/icons/layouts/spiralw.png"
theme.layout_dwindle                            = theme.confdir .. "/icons/layouts/dwindlew.png"
theme.layout_max                                = theme.confdir .. "/icons/layouts/maxw.png"
theme.layout_fullscreen                         = theme.confdir .. "/icons/layouts/fullscreenw.png"
theme.layout_magnifier                          = theme.confdir .. "/icons/layouts/magnifierw.png"
theme.layout_floating                           = theme.confdir .. "/icons/layouts/floatingw.png"

-- Tags Icons.
theme.taglist_font                              = "FontAwesome 8"
theme.taglist_fg_occupied                       = white

-- Titlebar Icons.
theme.titlebar_close_button_normal              = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.confdir .. "/icons/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.confdir .. "/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.confdir .. "/icons/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.confdir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- Widgets Icons.
theme.widget_ac                                 = theme.confdir .. "/icons/widgets/ac.png"
theme.widget_batt                               = theme.confdir .. "/icons/widgets/bat.png"
theme.widget_clock                              = theme.confdir .. "/icons/widgets/clock.png"
theme.widget_cpu                                = theme.confdir .. "/icons/widgets/cpu.png"
theme.widget_fs                                 = theme.confdir .. "/icons/widgets/fs.png"
theme.widget_mail                               = theme.confdir .. "/icons/widgets/mail.png"
theme.widget_mem                                = theme.confdir .. "/icons/widgets/mem.png"
theme.widget_netdown                            = theme.confdir .. "/icons/widgets/net_down.png"
theme.widget_netup                              = theme.confdir .. "/icons/widgets/net_up.png"
theme.widget_note                               = theme.confdir .. "/icons/widgets/note.png"
theme.widget_note_on                            = theme.confdir .. "/icons/widgets/note_on.png"
theme.widget_temp                               = theme.confdir .. "/icons/widgets/temp.png"
theme.widget_vol                                = theme.confdir .. "/icons/widgets/spkr.png"
theme.widget_weather                            = theme.confdir .. "/icons/widgets/dish.png"

-- Generate Awesome icon.
theme.awesome_icon = theme_assets.awesome_icon(
   theme.menu_height, theme.bg_focus, theme.fg_focus
)

return theme
