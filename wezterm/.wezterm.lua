local wezterm = require("wezterm")
local config = {}

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

config.enable_kitty_graphics = true

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
-- config.color_scheme = "Catppuccin Mocha"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 50

config.adjust_window_size_when_changing_font_size = false

-- config.freetype_load_flags = 'NO_HINTING'
-- config.font_antialias = 'Subpixel'
-- config.font_antialias = 'Greyscale'

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", weight = "Medium" },
	"Fira Code",
	"Hack Nerd Mono",
})
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

config.leader = { key = "a", mods = "CMD" }

local resizeFactor = 15
local bigResizeFactor = 50

local function splitKeys()
	local keys = {
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "%",
			mods = "LEADER",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
	}
	return keys
end

local function paneNavigationKeys()
	local keyConfig = {
		-- { key = 'h',          direction = 'Left',  mod = 'LEADER' },
		-- { key = 'j',          direction = 'Down',  mod = 'LEADER' },
		-- { key = 'k',          direction = 'Up',    mod = 'LEADER' },
		-- { key = 'l',          direction = 'Right', mod = 'LEADER' },

		{ key = "h", direction = "Left", mod = "CMD" },
		{ key = "j", direction = "Down", mod = "CMD" },
		{ key = "k", direction = "Up", mod = "CMD" },
		{ key = "l", direction = "Right", mod = "CMD" },

		{ key = "LeftArrow", direction = "Left", mod = "LEADER" },
		{ key = "DownArrow", direction = "Down", mod = "LEADER" },
		{ key = "UpArrow", direction = "Up", mod = "LEADER" },
		{ key = "RightArrow", direction = "Right", mod = "LEADER" },

		{ key = "LeftArrow", direction = "Left", mod = "CMD" },
		{ key = "DownArrow", direction = "Down", mod = "CMD" },
		{ key = "UpArrow", direction = "Up", mod = "CMD" },
		{ key = "RightArrow", direction = "Right", mod = "CMD" },
	}

	local keys = {}

	for _, c in pairs(keyConfig) do
		table.insert(keys, {
			key = c.key,
			mods = c.mod,
			action = wezterm.action({
				ActivatePaneDirection = c.direction,
			}),
		})
	end

	return keys
end

local function tabNavigationKeys()
	return {
		{
			key = "[",
			mods = "CMD",
			action = wezterm.action({
				ActivateTabRelative = -1,
			}),
		},
		{
			key = "]",
			mods = "CMD",
			action = wezterm.action({
				ActivateTabRelative = 1,
			}),
		},
		{
			key = "[",
			mods = "CMD|META",
			action = wezterm.action({
				MoveTabRelative = -1,
			}),
		},
		{
			key = "]",
			mods = "CMD|META",
			action = wezterm.action({
				MoveTabRelative = 1,
			}),
		},
		-- {
		--     key = 't',
		--     mods = 'CMD',
		--     action = wezterm.action {
		--         SpawnTab = "DefaultDomain"
		--     }
		-- },
	}
end

local function windowNavigationKeys()
	return {
		{
			key = "[",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivateWindowRelative(1),
		},
		{
			key = "]",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivateWindowRelative(-1),
		},
	}
end

local function paneResizeKeys()
	local keyConfig = {
		{ key = "h", direction = "Left", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "j", direction = "Down", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "k", direction = "Up", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "l", direction = "Right", mod = "CMD|META", resizeFactor = resizeFactor },

		{ key = "h", direction = "Left", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "j", direction = "Down", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "k", direction = "Up", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "l", direction = "Right", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },

		{ key = "LeftArrow", direction = "Left", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "DownArrow", direction = "Down", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "UpArrow", direction = "Up", mod = "CMD|META", resizeFactor = resizeFactor },
		{ key = "RightArrow", direction = "Right", mod = "CMD|META", resizeFactor = resizeFactor },

		{ key = "LeftArrow", direction = "Left", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "DownArrow", direction = "Down", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "UpArrow", direction = "Up", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
		{ key = "RightArrow", direction = "Right", mod = "CMD|META|SHIFT", resizeFactor = bigResizeFactor },
	}

	local keys = {}

	for _, c in pairs(keyConfig) do
		table.insert(keys, {
			key = c.key,
			mods = c.mod,
			action = wezterm.action({
				AdjustPaneSize = { c.direction, c.resizeFactor },
			}),
		})
	end

	return keys
end

config.keys = {
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action({
			CloseCurrentPane = { confirm = false },
		}),
	},
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "K",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.RotatePanes("Clockwise"),
	},
	{
		key = "R",
		mods = "LEADER",
		action = wezterm.action.RotatePanes("CounterClockwise"),
	},
	{
		key = "!",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_tab()
			pane:activate()
		end),
	},
	{
		key = "@",
		mods = "LEADER",
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_window()
			pane:activate()
		end),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.PaneSelect({
			mode = "SwapWithActiveKeepFocus",
		}),
	},
	{
		key = "P",
		mods = "CTRL",
		action = wezterm.action.ActivateCommandPalette,
	},
	{ key = "u", mods = "CMD", action = wezterm.action.ScrollByPage(-0.5) },
	{ key = "d", mods = "CMD", action = wezterm.action.ScrollByPage(0.5) },
	{ key = "u", mods = "CMD|SHIFT", action = wezterm.action.ScrollByPage(-1) },
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.ScrollByPage(1) },
	{
		key = "E",
		mods = "CMD|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
}

local extraKeys = {
	splitKeys(),
	paneNavigationKeys(),
	tabNavigationKeys(),
	windowNavigationKeys(),
	paneResizeKeys(),
}

for _, keys in ipairs(extraKeys) do
	for _, k in ipairs(keys) do
		table.insert(config.keys, k)
	end
end

-- https://github.com/wez/wezterm/issues/909
local function active_tab_idx(mux_win)
	for _, item in ipairs(mux_win:tabs_with_info()) do
		-- wezterm.log_info('idx: ', idx, 'tab:', item)
		if item.is_active then
			return item.index
		end
	end
end
table.insert(config.keys, {
	key = "t",
	mods = "CMD",
	action = wezterm.action_callback(function(win, pane)
		local mux_win = win:mux_window()
		local idx = active_tab_idx(mux_win)
		-- wezterm.log_info('active_tab_idx: ', idx)
		local tab = mux_win:spawn_tab({})
		-- wezterm.log_info('movetab: ', idx)
		win:perform_action(wezterm.action.MoveTab(idx + 1), pane)
	end),
})

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return "nvim bootloader: " .. zoomed .. index .. tab.active_pane.title
end)

return config
