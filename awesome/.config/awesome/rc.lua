--[[
   Awesome WM config
   Author: Terencio Agozzino
   Mail: terencio.agozzino@gmail.com
   Website: http://terencio-agozzino.com/
   GitHub: https://github.com/rememberYou/
--]]

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")
local lain = require("lain")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Wifi library
local net_widgets = require("net_widgets")

-- Useful variables
local brightness = "60"

-- {{{ Function definitions

function notify_gnotify(ntype, text)
   local color = beautiful.fg_normal
   if ntype == "info" then
      color = "#f9f9f9"
   elseif ntype == "warn" then
      color = "#f2de99"
   elseif ntype == "danger" then
      color = "#f29999"
   end
   naughty.notify({
	 timeout = 0.5,
	 text="<span color='" .. color .. "'>" .. awful.util.escape(text) .. "</span> "
   })
end

function notify_brightness(text)
   local brightness = tonumber(brightness)
   if brightness == 15 then
      notify_gnotify("danger", text)
   else
      notify_gnotify("warn", text)
   end
end

-- Scan directory, and optionally filter outputs
-- From: https://gist.github.com/anonymous/9072154f03247ab6e28c
function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    print(filter)
    for filename in popen('ls -a "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end

function update_brightness(direction)
   if direction == "up" and math.floor(brightness) < 90 then
      awful.spawn("xbacklight -inc 15")
      brightness = brightness + "15"
   elseif direction == "down" and math.floor(brightness) > 15 then
      awful.spawn("xbacklight -dec 15")
      brightness = brightness - "15"
   end
   notify_brightness("Brightness: " .. math.floor(brightness) .. "%")
end

--- }}}

-- Enable VIM help for hotkeys widget when client with matching name is opened:
require("awful.hotkeys_popup.keys.vim")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Pick a random wallpaper every x times

-- Be careful, the path only work with the full absolute
wp_index = 1
wp_timeout = 300
wp_path = "/home/someone/Pictures/Wallpapers/"
wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") end
wp_files = scandir(wp_path, wp_filter)

-- Setup the timer
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()

  -- Set wallpaper to current index for all screens
  for s = 1, screen.count() do
    gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
  end

  -- Stop the timer (we don't need multiple instances running at the same time)
  wp_timer:stop()

  -- Get next random index
  wp_index = math.random( 1, #wp_files)

  --Restart the timer
  wp_timer.timeout = wp_timeout
  wp_timer:start()
end)

-- Initial start when rc.lua is first run
wp_timer:start()

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.gap_single_client = true
beautiful.init("~/.config/awesome/themes/rememberYou/theme.lua")
beautiful.useless_gap = 15

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
edit = "emacsclient"
editor = os.getenv("EDITOR") or edit
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "Lock", "xtrlock" },
   { "Logout", function() awesome.quit() end },
   { "Reboot", "reboot" },
   { "Refresh", awesome.restart },
   { "Shutdown", "shutdown -h now" }
}

mymainmenu = awful.menu({ items = { { "Options", myawesomemenu },
			     { "User Terminal", terminal }
}
		       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
markup = lain.util.markup

--
--
-- [ UTILS ]
--
--

spacer = wibox.widget.textbox(' ')
sep = wibox.widget.textbox(' | ')

--
--
-- [ CENTER LAYOUT WIDGETS ]
--
--

-- Mail widget.
local mailicon = wibox.widget.imagebox(beautiful.widget_mail)
local mailwidget = lain.widget.imap({
      server   = "imap.gmail.com",
      mail     = "terencio.agozzino@gmail.com",
      password = "gpg -d /home/someone/.passwd/gmail.gpg",
      settings = function()
	 mailicon:set_image(beautiful.widget_mail)
	 if mailcount > 0 then
	    widget:set_markup(markup("#cccccc", mailcount .. " "))
	 else
	    widget:set_text("0")
	 end
	 mailicon:emit_signal("widget::redraw_needed")
	 mailicon:emit_signal("widget::layout_changed")
      end
})

-- Up/down flow rate.
local netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
local netdowninfo = wibox.widget.textbox()
local netupicon = wibox.widget.imagebox(beautiful.widget_netup)
local netupinfo = lain.widget.net({
      settings = function()
	 widget:set_markup(markup("#e54c62", net_now.sent .. " "))
	 netdowninfo:set_markup(markup("#87af5f", net_now.received .. " "))
      end
})

-- Network widget.
net_wireless = net_widgets.wireless({
      interface="wlp4s0",
      font = "Monospace 10",
      indent = 0,
})

net_wired = net_widgets.indicator({
      interfaces  = {"enp0s31f6"},
      timeout     = 5
})

net_internet = net_widgets.internet({indent = 0, timeout = 5})

-- Volume widget.
local volicon = wibox.widget.imagebox(beautiful.widget_vol)
local volumewidget = lain.widget.alsa({
      timeout = 0.1,
      settings = function()
	 if volume_now.status == "off" then
	    widget:set_markup(markup("#7493d2", volume_now.level .. "M "))
	 else
	    widget:set_markup(markup("#7493d2", volume_now.level .. "% "))
	 end
      end
})

-- Memory widget.
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local memwidget = lain.widget.mem({
      settings = function()
	 widget:set_markup(markup("#e0da37", mem_now.perc .. "% "))
      end
})

-- CPU widget.
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpuwidget = lain.widget.cpu({
      settings = function()
	 widget:set_markup(markup("#e33a6e", cpu_now.usage .. "% "))
      end
})

-- File system (/) widget.
local fsicon = wibox.widget.imagebox(beautiful.widget_fs)
local fswidget = lain.widget.fs({
      settings = function()
	 local home_used = tonumber(fs_info["/home used_p"]) or 0
	 widget:set_markup(markup("#80d9d8", fs_now.used .. "% "))
      end
})

-- CPU's temperature widget.
local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local tempwidget = lain.widget.temp({
      settings = function()
	 widget:set_markup(markup("#f1af5f", coretemp_now .. "°C "))
      end
})

-- Battery
local baticon = wibox.widget.imagebox(beautiful.widget_batt)
local batwidget = lain.widget.bat({
      battery = "BAT0",
      timeout = 10,
      settings = function()
	 if bat_now.status == "Charging" then
	    baticon:set_image(beautiful.widget_ac)
	    widget:set_markup(markup("#db842f", bat_now.perc .. "% (AC)"))
	 elseif bat_now.status == "Full" or bat_now.status == "Unknown" then
	    baticon:set_image(beautiful.widget_ac)
	    widget:set_markup(markup("#db842f", "AC"))
	 else
	    baticon:set_image(beautiful.widget_batt)
	    widget:set_markup(bat_now.perc .. "% (" .. bat_now.time .. ")")
	 end
      end
})

--
--
-- [ RIGHT LAYOUT WIDGETS ]
--
--

-- Textclock widget.
os.setlocale(os.getenv("LANG")) -- to localize the clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", "%a %d %b, %H:%M"))
mytextclock.font = "Carbin Bold 8"

-- Calendar.
local calendar = lain.widget.calendar({
      attach_to = { mytextclock },
      notification_preset = {
	 font = "Monospace 10"
      }
})

-- Nickname text.
nicktext = wibox.widget.textbox(markup("#dddddd", '<b>' .. "rememberYou " .. '</b>'))

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " ", " ", " ", " ", " ", " ", " ", " " }, s, awful.layout.layouts[3])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, nil, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
     s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
	    layout = wibox.layout.fixed.horizontal,
            mylauncher,
     	    s.mytaglist,
	    s.mypromptbox,
     	    wibox.container.constraint(s.mytasklist, "exact", s.workarea.width/3.2),
         },
     	{ -- Middle widget
     	   layout = wibox.layout.fixed.horizontal,
     	   calendar,
     	   clockicon,
     	   mytextclock,
     	},
         { -- Right widgets
     	   layout = wibox.layout.fixed.horizontal,

     	   mailicon,
     	   mailwidget,

     	   netdownicon,
     	   netdowninfo,
     	   mynet,
     	   netupicon,
     	   netupinfo,

     	   net_wireless,

     	   volicon,
     	   volumewidget,

     	   memicon,
     	   memwidget,

     	   cpuicon,
     	   cpuwidget,

	   -- Got a problem with this when doing dual screen.
	   -- fsicon,
	   -- fswidget,

     	   tempicon,
     	   tempwidget,

     	   mybattery,
     	   baticon,
     	   batwidget,

     	   sep,

     	   -- mykeyboardlayout,

     	   wibox.widget.systray(),

     	   spacer,
     	   s.mylayoutbox,
         },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings

globalkeys = gears.table.join(

   -- Lock the screen
   awful.key({ modkey, "Control" }, "l", function () awful.spawn("xtrlock") end,
      {description = "locker", group = "others"}),

   -- Toggle statusbar
   awful.key({ modkey }, "b",
      function ()
	 myscreen = awful.screen.focused()
	 myscreen.mywibox.visible = not myscreen.mywibox.visible
      end,
      {description = "toggle statusbar", group = "client"}
   ),

   -- Resize the Window
   awful.key({ modkey, "Shift" }, "j", function () awful.client.moveresize(0, 0, 0, 40) end,
       {description = "resize down", group = "window"}),
   awful.key({ modkey, "Shift" }, "k", function () awful.client.moveresize(0, 0, 0, -40) end,
       {description = "Shift top", group = "window"}),
   awful.key({ modkey, "Shift" }, "h", function () awful.client.moveresize(0, 0, -40, 0) end,
       {description = "resize left", group = "window"}),
   awful.key({ modkey, "Shift" }, "l", function () awful.client.moveresize(0, 0, 40, 0) end,
       {description = "resize right", group = "window"}),

   -- Move the Window
   awful.key({ modkey, "Control", "Shift" }, "j", function () awful.client.moveresize(0, 40, 0, 0) end,
       {description = "move down", group = "window"}),
   awful.key({ modkey, "Control", "Shift" }, "k", function () awful.client.moveresize(0, -40, 0, 0) end,
       {description = "move top", group = "window"}),
   awful.key({ modkey, "Control", "Shift" }, "h", function () awful.client.moveresize(-40, 0, 0, 0) end,
       {description = "move left", group = "window"}),
   awful.key({ modkey, "Control", "Shift" }, "l", function () awful.client.moveresize(40, 0, 0, 0) end,
       {description = "move right", group = "window"}),

   -- Volume/Microphone Keys
   awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q -D pulse sset Master 5%-", false) end,
      {description = "audio lower volume", group = "sound"}),
   awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q -D pulse sset Master 5%+", false) end,
      {description = "audio raise volume", group = "sound"}),
   awful.key({}, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) end,
      {description = "audio mute volume", group = "sound"}),
   awful.key({}, "XF86AudioMicMute", function () awful.spawn("amixer sset Capture toggle") end,
      {description = "audio mute microphone", group = "sound"}),

   -- Media Keys
   awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause", false) end,
      {description = "audio play", group = "media"}),
   awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next", false) end,
      {description = "audio next", group = "media"}),
   awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous", false) end,
      {description = "audio previous", group = "media"}),

   -- Brightness
   awful.key({}, "XF86MonBrightnessDown", function () update_brightness("down") end,
      {description = "brightness down", group = "brightness"}),
   awful.key({}, "XF86MonBrightnessUp", function () update_brightness("up") end,
      {description = "brightness up", group = "brightness"}),

   -- Screenshot
   awful.key({ modkey, 'Control'}, "Print", function () awful.util.spawn_with_shell("sleep 0.5 && scrot -q 100 -s -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'", false) end,
      {description = "screenshot with region", group = "screenshot"}),
   awful.key({ modkey, }, "Print", function () awful.spawn("scrot -q 100 -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'", false) end,
      {description = "screenshot", group = "screenshot"}),

    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    { rule = { class = "URxvt" },
      properties = { screen = 1, tag = " " } },

    { rule = { class = "Chromium" },
      properties = { screen = 1, tag = " " } },

    { rule = { class = "Emacs" },
      properties = { screen = 1, tag = " " } },

    { rule = { class = "Spotify" },
      properties = { screen = 1, tag = " " } },

   { rule = { class = "skypeforlinux" },
     properties = { screen = 1, tag = " " } },

   { rule = { class = "Gimp" },
     properties = { screen = 1, tag = " " } },

   { rule = { class = "Steam" },
     properties = { screen = 1, tag = " " } },

   { rule = { class = "Vmware" },
     properties = { screen = 1, tag = " " } },

   { rule = { class = "TeamViewer" },
     properties = { screen = 1, tag = " " } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c)
			 c.border_color = beautiful.border_focus
			 c.opacity = 1
end)
client.connect_signal("unfocus", function(c)
			 c.border_color = beautiful.border_normal
			 c.opacity = 0.85
end)
-- }}}

-- Startup programs
awful.util.spawn_with_shell("~/.config/awesome/autorun.sh")
