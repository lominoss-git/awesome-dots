-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal         = "xfce4-terminal"
browser          = "firefox"
wallpaper_setter = "nitrogen"
editor           = "micro"
editor_cmd       = terminal .. " -e " .. editor

show_titlebars   = true

-- Default superkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
superkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.max,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- -- {{{ Menu
-- -- Create a launcher widget and a main menu
-- myawesomemenu = {
   -- { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   -- { "Manual", terminal .. " -e man awesome" },
   -- { "Edit config", editor_cmd .. " " .. awesome.conffile },
   -- { "Restart", awesome.restart },
   -- { "Quit", function() awesome.quit() end },
-- }
--
-- myapplicationsmenu = {
   -- { "Terminal", terminal },
   -- { "Browser", browser },
   -- { "Wallpaper setter", wallpaper_setter },
-- }
--
-- mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu },
                                    -- { "Applications", myapplicationsmenu }
                                  -- }
                        -- })
--
-- -- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     -- -- menu = mymainmenu })
--
-- -- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
-- local taglist_buttons = gears.table.join(
                    -- awful.button({ }, 1, function(t) t:view_only() end),
                    -- awful.button({ superkey }, 1, function(t)
                                              -- if client.focus then
                                                  -- client.focus:move_to_tag(t)
                                              -- end
                                          -- end),
                    -- awful.button({ }, 3, awful.tag.viewtoggle),
                    -- awful.button({ superkey }, 3, function(t)
                                              -- if client.focus then
                                                  -- client.focus:toggle_tag(t)
                                              -- end
                                          -- end),
                    -- awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    -- awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                -- )
--
-- local tasklist_buttons = gears.table.join(
                     -- awful.button({ }, 1, function (c)
                                              -- if c == client.focus then
                                                  -- c.minimized = true
                                              -- else
                                                  -- c:emit_signal(
                                                      -- "request::activate",
                                                      -- "tasklist",
                                                      -- {raise = true}
                                                  -- )
                                              -- end
                                          -- end),
                     -- awful.button({ }, 3, function()
                                              -- awful.menu.client_list({ theme = { width = 250 } })
                                          -- end),
                     -- awful.button({ }, 4, function ()
                                              -- awful.client.focus.byidx(1)
                                          -- end),
                     -- awful.button({ }, 5, function ()
                                              -- awful.client.focus.byidx(-1)
                                          -- end))

-- local function set_wallpaper(s)
    -- -- Wallpaper
    -- if beautiful.wallpaper then
        -- local wallpaper = beautiful.wallpaper
        -- -- If wallpaper is a function, call it with the screen
        -- if type(wallpaper) == "function" then
            -- wallpaper = wallpaper(s)
        -- end
        -- gears.wallpaper.maximized(wallpaper, s, true)
    -- end
-- end
--
-- -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "FGX" }, s, awful.layout.layouts[1])
    -- awful.tag({ "dev", "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx" }, s, awful.layout.layouts[1])
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    -- awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

    -- -- Create a promptbox for each screen
    -- s.mypromptbox = awful.widget.prompt()
    -- -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- -- -- We need one layoutbox per screen.
    -- -- s.mylayoutbox = awful.widget.layoutbox(s)
    -- -- s.mylayoutbox:buttons(gears.table.join(
                           -- -- awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           -- -- awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           -- -- awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           -- -- awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- -- Create a taglist widget
    -- s.mytaglist = awful.widget.taglist {
        -- screen  = s,
        -- filter  = awful.widget.taglist.filter.all,
        -- buttons = taglist_buttons
    -- }
--
    -- -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist {
        -- screen  = s,
        -- filter  = awful.widget.tasklist.filter.currenttags,
        -- buttons = tasklist_buttons
    -- }
--
    -- -- Create the wibox
    -- s.mywibox = awful.wibar({ position = "top", screen = s })
--
    -- -- Add widgets to the wibox
    -- s.mywibox:setup {
        -- layout = wibox.layout.align.horizontal,
        -- { -- Left widgets
            -- layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            -- s.mytaglist,
            -- s.mypromptbox,
        -- },
        -- s.mytasklist, -- Middle widget
        -- { -- Right widgets
            -- layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            -- wibox.widget.systray(),
            -- mytextclock,
            -- s.mylayoutbox,
        -- },
    -- }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    -- awful.button({ }, 3, function () end),

    -- Switch tags on desktop scroll
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Cheat sheet
    awful.key({ superkey }, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}
              ),

    -- Hide/show Bar
    awful.key({ superkey }, "b", function() awful.util.spawn("polybar-msg cmd toggle") end,
              {description="toggle polybar's visibility", group="polybar"}
              ),

    -- Hide/show titlebars
    awful.key({ superkey, "Shift" }, "b",
          function ()
              local c = client.focus
              if c then
                  awful.titlebar.toggle(c, "top")
              end
          end,
          {description="toggle titlebar visibility", group="awesome"}
          ),

    -- Launch terminal
    awful.key({ superkey }, "t",      function() awful.spawn(terminal) end,
              {description="Launch terminal emulator", group="applications"}
              ),

    awful.key({ superkey }, "Return", function() awful.spawn(terminal) end,
              {description="Launch terminal emulator", group="applications"}
              ),

    -- Applications keychord
    awful.key({ superkey }, "a", function()
        local grabber
        grabber =
            awful.keygrabber.run(
                function(_, key, event)
                    if event == "release" then return end

                    if     key == "t" then awful.spawn(terminal)
                    elseif key == "b" then awful.spawn(browser)
                    elseif key == "e" then awful.spawn(editor_cmd)
                    elseif key == "w" then awful.spawn(wallpaper_setter)
                    end
                    awful.keygrabber.stop(grabber)
                    end
               )
        end,
        {description = "Applications keychord", group = "applications"}
        ),

    -- Rofi
    awful.key({ superkey }, "p", function() awful.spawn.with_shell("polybar-msg cmd show ; rofi -show drun") end,
              {description="Rofi launcher", group="applications"}
              ),
    -- Rofi keychord
    awful.key( { superkey, "Shift" }, "p", function()
        local grabber
        grabber =
            awful.keygrabber.run(
                function(_, key, event)
                    if event == "release" then return end

                    if     key == "a" then awful.spawn.with_shell("polybar-msg cmd show ; rofi -show drun")
                    elseif key == "r" then awful.spawn.with_shell("polybar-msg cmd show ; rofi -show run")
                    elseif key == "p" then awful.spawn.with_shell("polybar-msg cmd show ; sh ~/.config/rofi/scripts/rofi-exit.sh")
                    elseif key == "w" then awful.spawn.with_shell("polybar-msg cmd show ; rofi -show window")
                    elseif key == "f" then awful.spawn.with_shell("polybar-msg cmd show ; rofi -show filebrowser")
                    elseif key == "s" then awful.spawn.with_shell("polybar-msg cmd show ; rofi -show ssh")
                    end
                    awful.keygrabber.stop(grabber)
                    end
               )
        end,
        {description = "Rofi scripts keychord", group = "applications"}
        ),

    -- Switch focus to next/previous window
    awful.key({ superkey }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index",     group = "client"}
        ),
    awful.key({ superkey, "Shift" }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
        ),

    -- Swap windows
    awful.key({ superkey }, "h", function () awful.client.swap.global_bydirection("left")  end,
              {description = "swap with left client",   group = "client"}
              ),
    awful.key({ superkey }, "l", function () awful.client.swap.global_bydirection("right") end,
              {description = "swap with right client",  group = "client"}
              ),
    awful.key({ superkey }, "k", function () awful.client.swap.global_bydirection("up")    end,
              {description = "swap with top client",    group = "client"}
              ),
    awful.key({ superkey }, "j", function () awful.client.swap.global_bydirection("down")  end,
              {description = "swap with bottom client", group = "client"}
              ),

    -- Resize windows
    awful.key({ superkey, "Shift" }, "h",     function () awful.tag.incmwfact(-0.02)  end,
              {description = "decrease master width factor", group = "layout"}
              ),
    awful.key({ superkey, "Shift" }, "j",     function () awful.client.incwfact( 0.1) end,
              {description = "increase slave height factor", group = "layout"}
              ),
    awful.key({ superkey, "Shift" }, "k",     function () awful.client.incwfact(-0.1) end,
              {description = "decrease slave height factor", group = "layout"}
              ),
    awful.key({ superkey, "Shift" }, "l",     function () awful.tag.incmwfact( 0.02)  end,
              {description = "increase master width factor", group = "layout"}
              ),

    -- Switch layouts
    awful.key({ superkey, "Control" }, "h",     function () awful.layout.set(awful.layout.suit.tile)        end,
              {description = "Switch to master and stack layout (master on the left)",   group = "layout"}
              ),
    awful.key({ superkey, "Control" }, "j",     function () awful.layout.set(awful.layout.suit.tile.top)    end,
              {description = "Switch to master and stack layout (master on the bottom)", group = "layout"}
              ),
    awful.key({ superkey, "Control" }, "k",     function () awful.layout.set(awful.layout.suit.tile.bottom) end,
              {description = "Switch to master and stack layout (master on the top)",    group = "layout"}
              ),
    awful.key({ superkey, "Control" }, "l",     function () awful.layout.set(awful.layout.suit.tile.left)   end,
              {description = "Switch to master and stack layout (master on the right)",  group = "layout"}
              ),
    awful.key({ superkey }, "space", function () awful.layout.inc( 1)                            end,
              {description = "select next",                                              group = "layout"}
              ),
    awful.key({ superkey, "Shift" }, "space", function () awful.layout.inc(-1)                            end,
              {description = "select previous",                                          group = "layout"}
              ),

    -- Restart and quit Awesome
    awful.key({ superkey, "Control" }, "r",      awesome.restart,
              {description = "reload awesome", group = "awesome"}
              ),
    awful.key({ superkey, "Shift" }, "Escape", awesome.quit,
              {description = "quit awesome",   group = "awesome"}
              ),

    -- Unminize windows
    awful.key({ superkey, "Shift" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}
              )
)

clientkeys = gears.table.join(
    -- Toggle window states
    awful.key({ superkey }, "f",
              function (c)
                  c.fullscreen = not c.fullscreen
                  c:raise()
              end,
              {description = "toggle fullscreen", group = "client"}
              ),
    awful.key({ superkey }, "w",      awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}
              ),
    awful.key({ superkey }, "o",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}
              ),

    -- Close windows
    awful.key({ superkey, "Shift" }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}
              ),

    -- Swap master with slave window
    awful.key({ superkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}
              ),

    -- Minimize windows
    awful.key({ superkey }, "n",
              function (c)
                  -- The client currently has the input focus, so it cannot be
                  -- minimized, since minimized clients can't have the focus.
                  c.minimized = true
              end,
              {description = "minimize", group = "client"}
              )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ superkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}
                  ),

        -- Toggle tag display.
        awful.key({ superkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}
                  ),

        -- Move client to tag.
        awful.key({ superkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                              tag:view_only()
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}
                  ),

        -- Toggle tag on focused client.
        awful.key({ superkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"}
                  )
    )
end

clientbuttons = gears.table.join(
    -- Switch focus with mouse
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    -- Move window with mouse
    awful.button({ superkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),

    -- Resize window with mouse
    awful.button({ superkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),

    -- Kill window with mouse
    awful.button({ superkey, "Shift" }, 2, function (c)
        -- c:emit_signal("request::activate", "mouse_click", {raise = true})
        c:kill()
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      except_any = { class = {"Polybar"} },
      properties = { size_hints_honor = false,
                     border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
     }

    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = show_titlebars }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
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
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = 23}) : setup {
        { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.ontopbutton    (c),
            -- buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c),
                layout  = wibox.layout.flex.horizontal
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.minimizebutton  (c),
            awful.titlebar.widget.maximizedbutton (c),
            awful.titlebar.widget.closebutton     (c),
            awful.titlebar.widget.stickybutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

awful.titlebar.enable_tooltip = false

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
    -- c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart programs
awful.spawn.with_shell("compton --config ~/.config/compton/compton.conf")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("~/.config/polybar/launch.sh")

awful.screen.connect_for_each_screen(function(s)
    s.padding = {
        left = 20,
        right = 20,
        top = 20,
        bottom = 20
    }
end)
