local wezterm = require 'wezterm'
local config = {}

config.color_scheme = "Catppuccin Macchiato"

-- function scheme_for_appearance(appearance)
--     if appearance:find "Dark" then
--         return "Catppuccino Frappe"
--     else
--         return "Catppuccino Latte"
--     end
-- end
--
-- config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font_with_fallback {
    'JetBrains Mono',
    'Fira Code',
    'Hack Nerd Font Mono',
}
-- config.front_end = "WebGpu"
-- config.freetype_load_target = "HorizontalLcd"
config.font_size = 13.0
config.initial_cols = 100
config.initial_rows = 25

config.window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
}


config.leader = { key = 'a', mods = 'CMD' }

config.keys = {
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action {
            SplitHorizontal = { domain = "CurrentPaneDomain" }
        }
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action {
            SplitVertical = { domain = "CurrentPaneDomain" }
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
