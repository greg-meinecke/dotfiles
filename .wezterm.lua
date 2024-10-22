-- Pull in the ewzterm API
local wezterm = require("wezterm")

-- This will hold the configuraiton.
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 11

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

--config.color_scheme = "Monokai (terminal.sexy)"
--config.color_scheme = "Dawn (terminal.sexy)"

--config.color_scheme = "Macintosh (base16)"
--config.color_scheme = "Gruvbox dark, pale (base16)"
--config.color_scheme = "Gruvbox Material (Gogh)"
--config.color_scheme = "Dracula (Official)"
--config.color_scheme = "Gotham (terminal.sexy)"
--config.color_scheme = "Grass"
--config.color_scheme = "zenburned"
config.color_scheme = "Pretty and Pastel (terminal.sexy)"
--config.color_scheme = "Obsidian"
--config.color_scheme = "Overnight Slumber"
--config.color_scheme = "Invisibone (terminal.sexy)"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 10
config.audible_bell = "Disabled"

return config
