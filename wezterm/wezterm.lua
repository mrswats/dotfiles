-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.automatically_reload_config = true
config.enable_tab_bar = false

config.color_scheme = "nord"

config.font = wezterm.font("Hack")
config.font_size = 12

return config
