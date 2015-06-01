-- {{{ Load libraries
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
vicious = require("vicious")
widgets = require("vicious.widgets")
-- }}}

host = (widgets.os()[4])

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
        text = err })
        in_error = false
    end)
end
-- }}}
-- {{{ Smoother operations with KDE (don't kill plasma objects)

-- local isplasma = function(c)
-- return awful.rules.match(c,{class="Plasma"})
-- end
-- local killnoplasma = function(c)
-- if isplasma(c) then
-- c.minimized=false
-- else
-- c.kill(c)
-- end
-- return true
-- end

-- }}}
-- {{{ Make widgets

-- {{{ Cmus info
-- Initialize widget
cmus_widget = wibox.widget.textbox()
-- Register widget
vicious.register(cmus_widget, vicious.widgets.cmus,
    function (widget, args)
        if args["{status}"] == "Stopped" then 
            return " - "
        else
            return '   '..args["{status}"]..' '.. args["{artist}"]..' - '.. args["{title}"]..'    '
        end
    end, 4)
--}}}

-- Memory progressbar
memwidget = awful.widget.progressbar()
memwidget:set_width(10)
-- memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color({
    type = "linear",
    from = { 0, 0 },
    to = { 10,0 },
    stops = { {0, "#00FF4A"}, {0.5, "#31B758"}, {.9, "#D5F7DF"} }
})
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)

-- Memory text box
memintro = wibox.widget.textbox()
memintro:set_text("Mem: ")

-- CPU graph
cpuwidgetg = awful.widget.graph()
cpuwidgetg:set_width(50)
cpuwidgetg:set_background_color("#494B4F")
cpuwidgetg:set_color("E0E0E0")
vicious.register(cpuwidgetg, vicious.widgets.cpu, "$1")

-- CPU text box
cpuintro = wibox.widget.textbox()
cpuintro:set_text("   Cpu:")

-- Battery progressbar
batwidget = awful.widget.progressbar()
batwidget:set_width(10)
-- batwidget:set_height(14)
batwidget:set_vertical(true)
batwidget:set_background_color("#494B4F")
batwidget:set_border_color(nil)
batwidget:set_color({
    type = "linear",
    from = { 0, 0 },
    to = { 10,0 },
    stops = { {0, "#00BFFF"}, {0.5, "#1DA1CD"}, {.9, "#E1F7FF"} }
})
vicious.register(batwidget, vicious.widgets.bat, "$2", 30, "BAT0")

-- Battery text box
batintro = wibox.widget.textbox()
vicious.register(batintro, vicious.widgets.bat, "$3", 30, "BAT0")

-- Need some extra space
batspace = wibox.widget.textbox()
batspace:set_text("   ")

-- Temperature text box
tempwidget = wibox.widget.textbox()
if host == "buddy" then
    vicious.register(tempwidget, vicious.widgets.therm2, " $1C  ", 20, {"hwmon0", "hwmon"} )
else
    vicious.register(tempwidget, vicious.widgets.thermal, " $1C  ", 20, {"thermal_zone0", "sys"} )
end

-- Clock text box
mytextclock = awful.widget.textclock(" %a %b %d, %I:%M ", 20)

--- }}}
-- {{{ Theming

beautiful.init("/home/mike/.config/awesome/theme.lua")
-- if beautiful.wallpaper then
--     for s = 1, screen.count() do
--         gears.wallpaper.maximized(beautiful.wallpaper, s, true)
--     end
-- end

-- }}}
-- {{{ Random Wallpapers

-- function to return list of wallpapers
function scandir(directory, findPics)
    local i = 0
    local t = {}
    if not findPics then
        findPics = function(s) return true end
    end
    for filename in io.popen('ls -a "'..directory..'"'):lines() do
        if findPics(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end

-- Seconds until wallpaper swap
wp_timeout = 600
-- Wallpaper dir
wp_path = "/data/wallpapers/"

-- Files that are wallpapers
wp_pics = function(s) return string.match(s, "%.png$") or string.match(s, "%.jpg$") or string.match(s, "%.bmp$") end

wp_files = scandir(wp_path, wp_pics)

wp_index = math.random(1, #wp_files)
for s = 1, screen.count() do
    gears.wallpaper.fit(wp_path .. wp_files[wp_index], s)
end

wp_new = function()
    wp_index = math.random(1, #wp_files)
    for s = 1, screen.count() do
        gears.wallpaper.fit(wp_path .. wp_files[wp_index], s)
    end
end

wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout",
    function()
        wp_timer:stop()
        wp_new()
        wp_timer.timeout = wp_timeout
        wp_timer:start()
    end)

wp_timer:start()

-- }}} Random Wallpapers
-- {{{ Aliases

terminaltmux = "/home/mike/bin/termattach"
terminalmusic = "/home/mike/bin/termmusic"
terminalnotmux = "roxterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminalnotmux .. " -e " .. editor
WK = "Mod4"
AK = "Mod1"
CK = "Control"
SK = "Shift"

-- }}}
-- {{{ Layouts and tags

local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

tags = {
    names= {1,2,3,4,5,6,7,8,9},
    layout={layouts[1], layouts[1], layouts[1], layouts[1],
    layouts[1], layouts[1], layouts[1], layouts[3],
    layouts[1]}
}

for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- }}}
-- {{{ Menu (NOT IMPLEMENTED)

-- Create a laucher widget and a main menu
-- myawesomemenu = {
-- { "manual", terminal .. " -e man awesome" },
-- { "edit config", editor_cmd .. " " .. awesome.conffile },
-- { "restart", awesome.restart },
-- { "quit", awesome.quit }
-- }

-- mymainmenu = awful.menu({ 
-- items = { 
-- { "awesome", myawesomemenu, beautiful.awesome_icon },
-- { "open terminal", terminal } 
-- })

-- mylauncher = awful.widget.launcher({ 
-- image = beautiful.awesome_icon
-- menu = mymainmenu 
-- })

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- {{{ Top bar

-- Create a wibox for each screen and add it
mywibox = {}
mylayoutbox = {}

mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ WK }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ WK }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() then
                awful.tag.viewonly(c:tags()[1])
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ width=250 })
        end
    end),
    awful.button({ }, 4, function ()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.button({ }, 5, function ()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end))

for s = 1, screen.count() do
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(cmus_widget)
    right_layout:add(memintro)
    right_layout:add(memwidget)
    right_layout:add(batspace)
    right_layout:add(batintro)
    right_layout:add(batwidget)
    right_layout:add(cpuintro)
    right_layout:add(cpuwidgetg)
    right_layout:add(tempwidget)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end

-- }}}
-- {{{ Key bindings

-- Moving around tags
globalkeys = awful.util.table.join(
    awful.key({CK, AK}, "Left",  awful.tag.viewprev),
    awful.key({CK, AK}, "Right", awful.tag.viewnext),
    awful.key({CK, AK}, "Escape", awful.tag.history.restore),
    awful.key({CK, AK}, "space", function() awful.screen.focus_relative(1) end),

    -- Moving around clients
    awful.key({WK}, "j", function()
        awful.client.focus.byidx( 1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({WK}, "k", function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({AK}, "Tab", function()
        awful.client.focus.byidx(1)
        if client.focus then
            client.focus:raise()
        end
    end),
    awful.key({SK, AK}, "Tab", function()
        awful.client.focus.byidx(-1)
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Layout manipulation
    awful.key({WK, AK}, "j", function() awful.client.swap.byidx(  1) end),
    awful.key({WK, AK}, "k", function() awful.client.swap.byidx( -1) end),
    awful.key({WK, AK}, "l", function() awful.tag.incmwfact( 0.05)   end),
    awful.key({WK, AK}, "h", function() awful.tag.incmwfact(-0.05)   end),
    awful.key({WK, SK}, "h", function() awful.tag.incnmaster( 1)     end),
    awful.key({WK, SK}, "l", function() awful.tag.incnmaster(-1)     end),
    awful.key({WK, CK, AK}, "h", function() awful.tag.incncol( 1)   end),
    awful.key({WK, CK, AK}, "l", function() awful.tag.incncol(-1)   end),
    awful.key({WK, CK, AK},     "space", function() awful.layout.inc(layouts,  1) end),
    awful.key({WK, AK, CK, SK}, "space", function() awful.layout.inc(layouts, -1) end),

    -- Launch Programs
    awful.key({CK, AK}, "t", function() awful.util.spawn(terminalnotmux) end),
    awful.key({CK, AK}, "e", function() awful.util.spawn(terminalnotmux) end),
    awful.key({CK, AK}, "a", function() awful.util.spawn(terminaltmux) end),
    awful.key({CK, AK}, "f", function() awful.util.spawn("chromium") end),
    awful.key({CK, AK}, "g", function() awful.util.spawn("google-chrome") end),
    awful.key({CK, AK}, "c", function() awful.util.spawn("xcalc") end),
    awful.key({CK, AK}, "m", function() awful.util.spawn("mendeleydesktop") end),

    awful.key({}, "XF86Calculator", function () awful.util.spawn("xcalc") end),

    -- Media
    awful.key({CK, WK}, "p", function () awful.util.spawn_with_shell("playertoggle") end),
    awful.key({CK, WK}, "n", function () awful.util.spawn_with_shell("playernext") end),
    awful.key({CK, WK}, "b", function () awful.util.spawn_with_shell("playerprev") end),
    awful.key({CK, WK}, "l", function () awful.util.spawn_with_shell("volinc") end),
    awful.key({CK, WK}, "k", function () awful.util.spawn_with_shell("voldec") end),
    awful.key({CK, WK}, "m", function () awful.util.spawn_with_shell("volmute") end),

    awful.key({}, "XF86AudioPlay", function () awful.util.spawn_with_shell("playertoggle") end),
    awful.key({}, "XF86AudioNext", function () awful.util.spawn_with_shell("playernext") end),
    awful.key({}, "XF86AudioPrev", function () awful.util.spawn_with_shell("playerprev") end),
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell("volinc") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell("voldec") end),
    awful.key({}, "XF86AudioMute", function () awful.util.spawn_with_shell("volmute") end),

    -- Switch page up/page down and web forward back
    awful.key({WK}, "Return", function () awful.util.spawn_with_shell("pgup") end),
    awful.key({WK, SK}, "Return", function () awful.util.spawn_with_shell("pgdown") end),

    -- Awesome commands
    awful.key({WK, CK, AK}, "r", awesome.restart),
    awful.key({WK, CK, AK}, "q", awesome.quit),
    awful.key({WK, CK, AK}, "n", function() wp_new() end),

    -- Menubar
    awful.key({ CK, AK }, "r", function() menubar.show() end)
)

-- Keys that operate on a client
clientkeys = awful.util.table.join(
    awful.key({WK, AK}, "c", function(c) c.kill(c) end),
    awful.key({WK, AK}, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({WK}, "F11", function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({WK}, "f", awful.client.floating.toggle),
    awful.key({WK}, "o", awful.client.movetoscreen),
    awful.key({WK}, "t", function (c) c.ontop = not c.ontop            end),
    awful.key({WK}, "m", function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c.maximized_vertical   = not c.maximized_vertical
    end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
    keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
    awful.key({CK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if tags[screen][i] then
            awful.tag.viewonly(tags[screen][i])
            -- c = awful.client.getmaster()
            -- if c then
                -- client.focus = c
                -- c:raise()
            -- end
        end
    end),
    awful.key({CK, AK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if screen == 1 then
            screen = 2
        else
            screen = 1
        end
        if tags[screen][i] then
            awful.screen.focus(screen)
            awful.tag.viewonly(tags[screen][i])
            -- c = awful.client.getmaster()
            -- if c then
                -- client.focus = c
                -- c:raise()
            -- end
        end
    end),
    awful.key({WK, CK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if tags[screen][i] then
            awful.tag.viewtoggle(tags[screen][i])
        end
    end),
    awful.key({AK, WK, CK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if screen == 1 then
            screen = 2
        else
            screen = 1
        end
        if tags[screen][i] then
            awful.tag.viewtoggle(tags[screen][i])
        end
    end),
    awful.key({CK, SK}, "#" .. i + 9, function ()
        if client.focus and tags[client.focus.screen][i] then
            awful.client.movetotag(tags[client.focus.screen][i])
        end
    end),
    awful.key({CK, SK, AK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if screen == 1 then
            screen = 2
        else
            screen = 1
        end
        if client.focus and tags[screen][i] then
            awful.client.movetotag(tags[screen][i])
        end
    end),
    awful.key({WK, CK, SK}, "#" .. i + 9, function ()
        if client.focus and tags[client.focus.screen][i] then
            awful.client.toggletag(tags[client.focus.screen][i])
        end
    end),
    awful.key({AK, WK, CK, SK}, "#" .. i + 9, function ()
        local screen = mouse.screen
        if screen == 1 then
            screen = 2
        else
            screen = 1
        end
        if client.focus and tags[screen][i] then
            awful.client.toggletag(tags[screen][i])
        end
    end))
end

-- Set keys
root.keys(globalkeys)

-- }}}
-- {{{ Mouse buttons on clients

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ AK }, 1, awful.mouse.client.move),
    awful.button({ AK }, 3, awful.mouse.client.resize)
)

-- }}}
-- {{{ Per class rules

awful.rules.rules =
{
    {
        rule = { },
        properties = { border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        keys = clientkeys,
        maximized_vertical = false,
        maximized_horizontal = false,
        buttons = clientbuttons }
    },
    {
        rule = { class = "MPlayer" },
        properties = { floating = true }
    },
    {
        rule = { name = "CRAN mirror" },
        properties = { floating = true }
    },
    {
        rule = { class = "XCalc" },
        properties = { floating = true }
    },
    {
        rule = { class = "R_x11" },
        properties = {floating = true, ontop = true },
    },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}

-- }}}
-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
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
        ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

-- client.connect_signal("tagged",function(c,new_tag)
--    if ( #(new_tag:clients())==1 ) then
--        c.maximized_horizontal = true
--        c.maximized_vertical = true
--    end
-- end)

-- client.connect_signal("untagged",function(c,old_tag)
--    if ( #(old_tag:clients())==1 ) then
--        local myclients = old_tag:clients()
--        for _,cl in ipairs(myclients) do             
--           cl.maximized_horizontal = true
--           cl.maximized_vertical = true
--        end
--    end
-- end)

-- client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
-- client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("focus",
    function(c)
        local curidx = awful.tag.getidx()
        local nc = #( tags[client.focus.screen][curidx]:clients() )
        if nc == 1 or curidx == 8 then
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_normal
        else
            c.border_width = beautiful.border_width
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
        c.border_width = beautiful.border_width
    end)
-- client.connect_signal("unfocus",
--     function(c)
--         c.border_width = "3"
--         c.border_color = "#000000"
--     end)

-- }}}
-- {{{ Run some commands

os.execute("/home/mike/bin/run_nmapp &")
-- os.execute("wicd &")
-- os.execute("/home/mike/bin/myconky")

-- }}}
-- vim: fdm=marker
