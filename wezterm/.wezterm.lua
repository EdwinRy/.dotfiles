local wezterm = require 'wezterm'
local config = {}

-- function scheme_for_appearance(appearance)
--     if appearance:find "Dark" then
--         return "Catppuccin Mocha"
--     else
--         return "Catppuccin Latte"
--     end
-- end

-- config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.color_scheme = "Catppuccin Mocha"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 50

config.adjust_window_size_when_changing_font_size = false

-- config.freetype_load_flags = 'NO_HINTING'
-- config.font_antialias = 'Subpixel'
-- config.font_antialias = 'Greyscale'

config.font = wezterm.font_with_fallback {
    { family = "JetBrains Mono", weight = "Medium" },
    'Fira Code',
    'Hack Nerd Mono',
}
-- config.front_end = "WebGpu"
-- config.freetype_load_target = "HorizontalLcd"
config.font_size = 12.5
config.initial_cols = 100
config.initial_rows = 25

config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}


config.leader = { key = 'a', mods = 'CMD' }

local resizeFactor = 15
local bigResizeFactor = 50

local function splitKeys()
    local keys = {
        {
            key = 'v',
            mods = 'LEADER',
            action = wezterm.action {
                SplitHorizontal = { domain = "CurrentPaneDomain" }
            }
        },
        {
            key = '%',
            mods = 'LEADER',
            action = wezterm.action {
                SplitVertical = { domain = "CurrentPaneDomain" }
            }
        },
    }
    return keys
end

local function paneNavigationKeys()
    local keyConfig = {
        { key = 'h', direction = 'Left', mod = 'LEADER' },
        { key = 'j', direction = 'Down', mod = 'LEADER'},
        { key = 'k', direction = 'Up', mod = 'LEADER'},
        { key = 'l', direction = 'Right', mod = 'LEADER'},

        { key = 'h', direction = 'Left', mod = 'CMD' },
        { key = 'j', direction = 'Down', mod = 'CMD'},
        { key = 'k', direction = 'Up', mod = 'CMD'},
        { key = 'l', direction = 'Right', mod = 'CMD'},

        { key = 'LeftArrow', direction = 'Left', mod = 'LEADER' },
        { key = 'DownArrow', direction = 'Down', mod = 'LEADER'},
        { key = 'UpArrow', direction = 'Up', mod = 'LEADER'},
        { key = 'RightArrow', direction = 'Right', mod = 'LEADER'},

        { key = 'LeftArrow', direction = 'Left', mod = 'CMD' },
        { key = 'DownArrow', direction = 'Down', mod = 'CMD'},
        { key = 'UpArrow', direction = 'Up', mod = 'CMD'},
        { key = 'RightArrow', direction = 'Right', mod = 'CMD'},
    }

    local keys = {}

    for _, c in pairs(keyConfig) do
        table.insert(keys, {
            key = c.key,
            mods = c.mod,
            action = wezterm.action {
                ActivatePaneDirection = c.direction
            }
        })
    end

    return keys
end

local function tabNavigationKeys()
    return {
        {
            key = '[',
            mods = "CMD",
            action = wezterm.action {
                ActivateTabRelative = -1
            }
        },
        {
            key = ']',
            mods = "CMD",
            action = wezterm.action {
                ActivateTabRelative = 1
            }
        },
        {
            key = '[',
            mods = "CMD|META",
            action = wezterm.action {
                MoveTabRelative = -1
            }
        },
        {
            key = ']',
            mods = "CMD|META",
            action = wezterm.action {
                MoveTabRelative = 1
            }
        },
        {
            key = 't',
            mods = 'CMD',
            action = wezterm.action {
                SpawnTab = "DefaultDomain"
            }
        },
    }
end


local function paneResizeKeys()
    local keyConfig = {
        { key = 'h', direction = 'Left', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'j', direction = 'Down', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'k', direction = 'Up', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'l', direction = 'Right', mod = 'CMD|META', resizeFactor = resizeFactor },

        { key = 'h', direction = 'Left', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'j', direction = 'Down', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'k', direction = 'Up', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'l', direction = 'Right', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },

        { key = 'LeftArrow', direction = 'Left', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'DownArrow', direction = 'Down', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'UpArrow', direction = 'Up', mod = 'CMD|META', resizeFactor = resizeFactor },
        { key = 'RightArrow', direction = 'Right', mod = 'CMD|META', resizeFactor = resizeFactor },

        { key = 'LeftArrow', direction = 'Left', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'DownArrow', direction = 'Down', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'UpArrow', direction = 'Up', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
        { key = 'RightArrow', direction = 'Right', mod = 'CMD|META|SHIFT', resizeFactor = bigResizeFactor },
    }
    
    local keys = {}

    for _, c in pairs(keyConfig) do
        table.insert(keys, {
            key = c.key,
            mods = c.mod,
            action = wezterm.action {
                AdjustPaneSize = { c.direction, c.resizeFactor }
            }
        })
    end

    return keys
end


config.keys = {
    {
        key = 'x',
        mods = 'LEADER',
        action = wezterm.action {
            CloseCurrentPane = { confirm = false }
        }
    },
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action.TogglePaneZoomState
    },
    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.ShowTabNavigator
    },
    {
        key = 'K',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
    },
    {
        key = 'r',
        mods = 'LEADER',
        action = wezterm.action.RotatePanes 'Clockwise'
    },
    {
        key = 'R',
        mods = 'LEADER',
        action = wezterm.action.RotatePanes 'CounterClockwise'
    },
}

local extraKeys = {
    splitKeys(),
    paneNavigationKeys(),
    tabNavigationKeys(),
    paneResizeKeys(),
}

for _, keys in ipairs(extraKeys) do
    for _, k in ipairs(keys) do
        table.insert(config.keys, k)
    end
end

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    local zoomed = ''
    if tab.active_pane.is_zoomed then
        zoomed = '[Z] '
    end

    local index = ''
    if #tabs > 1 then
        index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
    end

    return "nvim bootloader: " .. zoomed .. index .. tab.active_pane.title
end)


return config
