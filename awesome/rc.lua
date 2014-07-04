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
memintro:set_text("   Mem:")

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
vicious.register(tempwidget, vicious.widgets.thermal, " $1C  ", 20, {"thermal_zone0", "sys"} )

-- Clock text box
mytextclock = awful.widget.textclock(" %a %b %d, %I:%M ", 20)

--- }}}
-- {{{ Theming

beautiful.init("/home/mike/.config/awesome/theme.lua")
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- }}}
-- {{{ Random Wallpapers (NOT IMPLEMENTED)

-- Get the list of files from a directory. Must be all images or folders and non-empty. 
-- function scanDir(directory)
-- local i, fileList, popen = 0, {}, io.popen
-- for filename in popen([[find "]] ..directory.. [[" -type f):lines() do
-- i = i + 1
-- fileList[i] = filename
-- end
-- return fileList
-- end
-- wallpaperList = scanDir("/data/wallpapers/mypics/")

-- Apply a random wallpaper on startup.
-- gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], s, true)

-- Apply a random wallpaper every changeTime seconds.
-- changeTime = 60
-- wallpaperTimer = timer { timeout = changeTime }
-- wallpaperTimer:connect_signal("timeout", function()
-- gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], s, true)

-- stop the timer (we don't need multiple instances running at the same time)
-- wallpaperTimer:stop()

-- restart the timer
-- wallpaperTimer.timeout = changeTime
-- wallpaperTimer:start()
-- end)

-- initial start when rc.lua is first run
-- wallpaperTimer:start()

-- }}}
-- {{{ Aliases

terminal = "/home/mike/bin/termattach"
terminalnotmux = "urxvtc"
terminaljoin = "/home/mike/bin/termjoin"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

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
    layouts[1], layouts[1], layouts[3], layouts[3],
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
-- {{{ Wibox

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ Mod4 }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ Mod4 }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end)
)
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
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
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
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
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

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
--awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewprev),
awful.button({ }, 5, awful.tag.viewnext)
))
-- }}}

-- {{{ Key bindings

globalkeys = awful.util.table.join(
awful.key({ "Control", "Mod1"           }, "Left", 
function ()  
    awful.tag.viewprev()
    c = awful.client.getmaster()
    if c then
        client.focus = c
        c:raise()
    end
end
),
awful.key({ "Control", "Mod1"          }, "Right",
function ()  
    awful.tag.viewnext() 
    c = awful.client.getmaster()
    if c then
        client.focus = c
        c:raise()
    end
end
),
awful.key({ "Control", "Mod1"          }, "Escape", awful.tag.history.restore),

awful.key({ Mod4,           }, "j",
function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
end),
awful.key({ Mod4,           }, "k",
function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end),
--awful.key({ Mod4,           }, "w", function () mymainmenu:show() end),

-- Layout manipulation
awful.key({ Mod4, "Mod1"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ Mod4, "Mod1"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({"Control", "Mod1"}, "space", function () awful.screen.focus_relative( 1) end),
awful.key({ Mod4, "Shift" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ Mod4,           }, "u", awful.client.urgent.jumpto),
awful.key({ "Mod1",           }, "Tab",
function ()
    awful.client.focus.byidx(1)
    if client.focus then
        client.focus:raise()
    end
end),

-- Standard program
awful.key({ "Control", "Mod1"          }, "t", function () awful.util.spawn(terminal) end),
awful.key({ "Control", "Mod1"          }, "e", function () awful.util.spawn(terminalnotmux) end),
awful.key({ "Control", "Mod1"          }, "a", function () awful.util.spawn(terminaljoin) end),
awful.key({ "Control", "Mod1"          }, "f", function () awful.util.spawn("chromium") end),
awful.key({ "Control", "Mod1"          }, "g", function () awful.util.spawn("google-chrome") end),
awful.key({ "Control", "Mod1"          }, "m", function () awful.util.spawn("mendeleydesktop") end),
awful.key({ "Control", "Mod1"          }, "c", function () awful.util.spawn("xcalc") end),
awful.key({                            }, "XF86Calculator", function () awful.util.spawn("kcalc") end),
awful.key({ Mod4, "Control"          }, "p", function () awful.util.spawn_with_shell("/home/mike/bin/playertoggle") end),
awful.key({ "Control", Mod4          }, "n", function () awful.util.spawn_with_shell("/home/mike/bin/playernext") end),
awful.key({ "Control", Mod4          }, "b", function () awful.util.spawn_with_shell("/home/mike/bin/playerprev") end),
awful.key({ "Control"                           }, "KP_Right", function () awful.util.spawn_with_shell("/home/mike/bin/playernext") end),
awful.key({                            }, "XF86Launch9", function () awful.util.spawn_with_shell("/home/mike/bin/playernext") end),
awful.key({                            }, "XF86Launch8", function () awful.util.spawn_with_shell("/home/mike/bin/playerprev") end),
awful.key({ "Control"                           }, "KP_Left", function () awful.util.spawn_with_shell("/home/mike/bin/playerprev") end),
awful.key({ "Control", Mod4          }, "l", function () awful.util.spawn_with_shell("amixer set Master 2%+ > /dev/null") end),
awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell("amixer set Master 2%+ > /dev/null") end),
awful.key({"Control"}, "KP_Up", function () awful.util.spawn_with_shell("amixer set Master 2%+ > /dev/null") end),
awful.key({ "Control", Mod4          }, "k", function () awful.util.spawn_with_shell("amixer set Master 2%- > /dev/null") end),
awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell("amixer set Master 2%- > /dev/null") end),
awful.key({"Control"}, "KP_Down", function () awful.util.spawn_with_shell("amixer set Master 2%- > /dev/null") end),
awful.key({}, "XF86AudioMute", function () awful.util.spawn_with_shell("amixer set Master toggle > /dev/null") end),
awful.key({"Control", Mod4}, "m", function () awful.util.spawn_with_shell("amixer set Master toggle > /dev/null") end),
awful.key({}, "XF86AudioPlay", function () awful.util.spawn_with_shell("/home/mike/bin/playertoggle > /dev/null") end),
awful.key({"Control"}, "KP_Begin", function () awful.util.spawn_with_shell("/home/mike/bin/playertoggle > /dev/null") end),
awful.key({Mod4}, "Return", function () awful.util.spawn_with_shell("/home/mike/bin/pgup") end),
awful.key({Mod4, "Shift"}, "Return", function () awful.util.spawn_with_shell("/home/mike/bin/pgdown") end),
awful.key({ Mod4, "Control", "Mod1" }, "r", awesome.restart),
awful.key({ Mod4, "Control", "Mod1"   }, "q", awesome.quit),
awful.key({Mod4}, "e", revelation),

awful.key({Mod4}, "KP_Left", function() awful.util.spawn_with_shell("xdotool mousemove_relative -- -15 0") end),
awful.key({Mod4}, "KP_Right", function() awful.util.spawn_with_shell("xdotool mousemove_relative -- 15 0") end),
awful.key({Mod4}, "KP_Up", function() awful.util.spawn_with_shell("xdotool mousemove_relative -- 0 -15") end),
awful.key({Mod4}, "KP_Down", function() awful.util.spawn_with_shell("xdotool mousemove_relative -- 0 15") end),
awful.key({Mod4}, "KP_Begin", function() awful.util.spawn_with_shell("xdotool click --clearmodifiers 1") end),
awful.key({Mod4, "Mod1"}, "KP_Begin", function() awful.util.spawn_with_shell("xdotool click --clearmodifiers 3") end),
awful.key({Mod4, "Control", "Mod1"}, "KP_Begin", function() awful.util.spawn_with_shell("xdotool click --clearmodifiers 2") end),



awful.key({ Mod4, "Mod1"          }, "l",     function () awful.tag.incmwfact( 0.05)    end),
awful.key({ Mod4, "Mod1"          }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ Mod4, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ Mod4, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
--awful.key({ Mod4, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
--awful.key({ Mod4, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ Mod4, "Mod1" , "Control" }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ Mod4, "Mod1", "Control", "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ Mod4, "Control" }, "n", awful.client.restore),

-- Prompt
awful.key({ Mod4 },            "r",     function () mypromptbox[mouse.screen]:run() end),

awful.key({ Mod4 }, "x",
function ()
    awful.prompt.run({ prompt = "Run Lua code: " },
    mypromptbox[mouse.screen].widget,
    awful.util.eval, nil,
    awful.util.getdir("cache") .. "/history_eval")
end),
-- Menubar
awful.key({ "Control", "Mod1" }, "r", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
awful.key({ Mod4,           }, "g",      function (c) c.fullscreen = not c.fullscreen  end),
awful.key({ Mod4, "Mod1"   }, "c",      killnoplasma ),
awful.key({ Mod4,     }, "f",  awful.client.floating.toggle                     ),
awful.key({ Mod4, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ Mod4,           }, "o",      awful.client.movetoscreen                        ),
awful.key({ Mod4,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ Mod4,           }, "n",
function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end),
awful.key({ Mod4,           }, "m",
function (c)
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
    awful.key({ "Control" }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        if tags[screen][i] then
            awful.tag.viewonly(tags[screen][i])
            c = awful.client.getmaster()
            if c then
                client.focus = c
                c:raise()
            end
        end
    end),
    awful.key({ "Control", "Mod1"  }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        if screen == 1 then
            screen = 2
        else
            screen = 1
        end
        if tags[screen][i] then
            awful.screen.focus(screen)
            awful.tag.viewonly(tags[screen][i])
            c = awful.client.getmaster()
            if c then
                client.focus = c
                c:raise()
            end
        end
    end),
    awful.key({ Mod4, "Control" }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        if tags[screen][i] then
            awful.tag.viewtoggle(tags[screen][i])
        end
    end),
    awful.key({ "Mod1", Mod4, "Control" }, "#" .. i + 9,
    function ()
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
    awful.key({ "Control", "Shift" }, "#" .. i + 9,
    function ()
        if client.focus and tags[client.focus.screen][i] then
            awful.client.movetotag(tags[client.focus.screen][i])
        end
    end),
    awful.key({ "Control", "Shift", "Mod1" }, "#" .. i + 9,
    function ()
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
    awful.key({ Mod4, "Control", "Shift" }, "#" .. i + 9,
    function ()
        if client.focus and tags[client.focus.screen][i] then
            awful.client.toggletag(tags[client.focus.screen][i])
        end
    end),
    awful.key({"Mod1",  Mod4, "Control", "Shift" }, "#" .. i + 9,
    function ()
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



clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ "Mod1" }, 1, awful.mouse.client.move),
awful.button({ "Mod1" }, 3, awful.mouse.client.resize))

-- }}}
-- {{{ Get active outputs
-- local function outputs()
-- local outputs = {}
-- local xrandr = io.popen("xrandr -q")
-- if xrandr then
-- for line in xrandr:lines() do
-- output = line:match("^([%w-]+) connected ")
-- if output then
-- outputs[#outputs + 1] = output
-- end
-- end
-- xrandr:close()
-- end

-- return outputs
-- end

-- local function arrange(out)
-- -- We need to enumerate all the way to combinate output. We assume
-- -- we want only an horizontal layout.
-- local choices  = {}
-- local previous = { {} }
-- for i = 1, #out do
-- -- Find all permutation of length `i`: we take the permutation
-- -- of length `i-1` and for each of them, we create new
-- -- permutations by adding each output at the end of it if it is
-- -- not already present.
-- local new = {}
-- for _, p in pairs(previous) do
-- for _, o in pairs(out) do
-- if not awful.util.table.hasitem(p, o) then
-- new[#new + 1] = awful.util.table.join(p, {o})
-- end
-- end
-- end
-- choices = awful.util.table.join(choices, new)
-- previous = new
-- end

-- return choices
-- end

-- -- Build available choices
-- local function menu()
-- local menu = {}
-- local out = outputs()
-- local choices = arrange(out)

-- for _, choice in pairs(choices) do
-- local cmd = "xrandr"
-- -- Enabled outputs
-- for i, o in pairs(choice) do
-- cmd = cmd .. " --output " .. o .. " --auto"
-- if i > 1 then
-- cmd = cmd .. " --right-of " .. choice[i-1]
-- end
-- end
-- -- Disabled outputs
-- for _, o in pairs(out) do
-- if not awful.util.table.hasitem(choice, o) then
-- cmd = cmd .. " --output " .. o .. " --off"
-- end
-- end

-- local label = ""
-- if #choice == 1 then
-- label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
-- else
-- for i, o in pairs(choice) do
-- if i > 1 then label = label .. " + " end
-- label = label .. '<span weight="bold">' .. o .. '</span>'
-- end
-- end

-- menu[#menu + 1] = { label,
-- cmd,
-- "/usr/share/icons/Tango/32x32/devices/display.png"}
-- end

-- return menu
-- end

-- -- Display xrandr notifications from choices
-- local state = { iterator = nil,
-- timer = nil,
-- cid = nil }
-- local function xrandr()
-- -- Stop any previous timer
-- if state.timer then
-- state.timer:stop()
-- state.timer = nil
-- end

-- -- Build the list of choices
-- if not state.iterator then
-- state.iterator = awful.util.table.iterate(menu(),
-- function() return true end)
-- end

-- -- Select one and display the appropriate notification
-- local next  = state.iterator()
-- local label, action, icon
-- if not next then
-- label, icon = "Keep the current configuration", "/usr/share/icons/Tango/32x32/devices/display.png"
-- state.iterator = nil
-- else
-- label, action, icon = unpack(next)
-- end
-- state.cid = naughty.notify({ text = label,
-- icon = icon,
-- timeout = 4,
-- screen = mouse.screen, -- Important, not all screens may be visible
-- font = "Free Sans 18",
-- replaces_id = state.cid }).id

-- -- Setup the timer
-- state.timer = timer { timeout = 4 }
-- state.timer:connect_signal("timeout",
-- function()
-- state.timer:stop()
-- state.timer = nil
-- state.iterator = nil
-- if action then
-- awful.util.spawn(action, false)
-- end
-- end)
-- state.timer:start()
-- end

-- -- }}}

-- globalkeys = awful.util.table.join(awful.key({Mod4}, "F1", xrandr))
-- Set keys
root.keys(globalkeys)

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
        rule = { name = "XCalc" },
        properties = { floating = true }
    },
    {
        rule = { class = "R_x11" },
        properties = {floating = true },
        callback = function(c) c:geometry({x=950, y=30, width=600, height=400}) end
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

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--
os.execute("/home/mike/bin/run_nmapp &")
-- os.execute("wicd &")
-- os.execute("/home/mike/bin/myconky")


-- vim: fdm=marker
