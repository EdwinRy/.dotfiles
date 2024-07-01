local wezterm = require 'wezterm'
local config = {}

-- config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Catppuccin Macchiato"

function scheme_for_appearance(appearance)
    if appearance:find "Dark" then
        return "Catppuccin Mocha"
    else
        return "Catppuccin Latte"
    end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- config.freetype_load_flags = 'NO_HINTING'
config.font_antialias = 'Subpixel'
-- config.font_antialias = 'Greyscale'

config.font = wezterm.font_with_fallback {
    { family = "JetBrains Mono", weight = "Medium" },
    'Fira Code',
    'Hack Nerd Mono',
}
-- config.front_end = "WebGpu"
-- config.freetype_load_target = "HorizontalLcd"
config.font_size = 12.0
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

config.keys = {
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
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action {
            ActivatePaneDirection = "Left"
        }
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = wezterm.action {
            ActivatePaneDirection = "Right"
        }
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = wezterm.action {
            ActivatePaneDirection = "Down"
        }
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = wezterm.action {
            ActivatePaneDirection = "Up"
        }
    },
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
    {
        key = 'h',
        mods = 'CMD|META',
        action = wezterm.action {
            AdjustPaneSize = { 'Left', resizeFactor }
        }
    },
    {
        key = 'l',
        mods = 'CMD|META',
        action = wezterm.action {
            AdjustPaneSize = { 'Right', resizeFactor }
        }
    },
    {
        key = 'k',
        mods = 'CMD|META',
        action = wezterm.action {
            AdjustPaneSize = { 'Up', resizeFactor }
        }
    },
    {
        key = 'j',
        mods = 'CMD|META',
        action = wezterm.action {
            AdjustPaneSize = { 'Down', resizeFactor }
        }
    },

    {
        key = 'h',
        mods = 'CMD|META|SHIFT',
        action = wezterm.action {
            AdjustPaneSize = { 'Left', bigResizeFactor }
        }
    },
    {
        key = 'l',
        mods = 'CMD|META|SHIFT',
        action = wezterm.action {
            AdjustPaneSize = { 'Right', bigResizeFactor }
        }
    },
    {
        key = 'k',
        mods = 'CMD|META|SHIFT',
        action = wezterm.action {
            AdjustPaneSize = { 'Up', bigResizeFactor }
        }
    },
    {
        key = 'j',
        mods = 'CMD|META|SHIFT',
        action = wezterm.action {
            AdjustPaneSize = { 'Down', bigResizeFactor }
        }
    },
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
}


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
