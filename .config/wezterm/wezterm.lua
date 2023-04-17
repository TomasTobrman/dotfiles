local status, wezterm = pcall(require, 'wezterm')
if not status then return false end

local act = wezterm.action

local config = {}

config.launch_menu = {}

-- Shell
config.default_prog = { '/usr/local/bin/fish', '-l' }

-- Font
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 11.0

-- Window
config.initial_cols = 110
config.initial_rows = 38
config.window_decorations = 'TITLE | RESIZE'
--window_decorations = 'RESIZE'
config.native_macos_fullscreen_mode = true

-- Tab Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.use_fancy_tab_bar = false

-- Key Binds
config.disable_default_key_bindings = true
config.keys = {
	{ key='c', mods='SUPER', action=act.CopyTo('Clipboard') },
	{ key='v', mods='SUPER', action=act.PasteFrom('Clipboard') },
	{ key='-', mods='SUPER', action=act.DecreaseFontSize },
	{ key='=', mods='SUPER', action=act.IncreaseFontSize },
	{ key='0', mods='SUPER', action=act.ResetFontSize },
	{ key='w', mods='SUPER', action=act.CloseCurrentTab({confirm=true}) },
	{ key='r', mods='SUPER', action=act.ReloadConfiguration },
	{ key='n', mods='SUPER', action=act.SpawnWindow },
}

-- Mouse Bindings
config.disable_default_mouse_bindings = false
config.mouse_bindings = {}

-- Colors
local theme = require "colors.tireatheme"
config.colors = theme

-- Other
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true
config.use_dead_keys = false


local function get_cell_size()
	-- TODO: some kind of automatic way to calculate cell size
	return {
		width = 13,
		height = 30
	}
end

local function recompute_padding(window)
	local window_dims = window:get_dimensions()
	local overrides = window:get_config_overrides() or {}

	local cell = get_cell_size()

	local new_padding = {
		left = math.floor((window_dims.pixel_width % cell.width) / 2),
		right = 0,
		top = math.floor((window_dims.pixel_height % cell.height) / 2),
		bottom = 0
	}

	overrides.window_padding = new_padding
	window:set_config_overrides(overrides)
end

wezterm.on('gui-startup', function()
	local _, _, window = wezterm.mux.spawn_window {}
	window:gui_window():toggle_fullscreen()
	recompute_padding(window)
end)

wezterm.on('window-resized', function(window, _) recompute_padding(window) end)
wezterm.on('window-config-reloaded', function(window) recompute_padding(window) end)

return config
