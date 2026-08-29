------------------
---- Hyprland ----
------------------
local DOTFILES = "~/.config/dotfiles"
local TERM = "wezterm"
local BROWSER = "firefox"
local ALT_BROSER = "chromium-browser"
local MENU = DOTFILES .. "/bin/rofi.sh"
local POWER_MENU = DOTFILES .. "/bin/wpowermenu.sh"
local MAIN_MOD = "SUPER"
local MAIN_MONITOR = "DP-2"
local SECONDARY_MONITOR = "DP-3"

------------------
---- MONITORS ----
------------------
hl.monitor({
    output = MAIN_MONITOR,
    mode = "highres",
    position = "auto",
    scale = 1,
})
hl.monitor({
    output = SECONDARY_MONITOR,
    mode = "highres",
    position = "auto-right",
    scale = 1,
    transform = 3,
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprsunset -t 4500")
    hl.exec_cmd("dunst -config ~/.config/dunst/dunstrc")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

hl.workspace_rule({ workspace = "1", monitor = SECONDARY_MONITOR })
hl.workspace_rule({ workspace = "2", monitor = SECONDARY_MONITOR })
hl.workspace_rule({ workspace = "3", monitor = SECONDARY_MONITOR })
hl.workspace_rule({ workspace = "4", monitor = SECONDARY_MONITOR })
hl.workspace_rule({ workspace = "5", monitor = SECONDARY_MONITOR })
hl.workspace_rule({ workspace = "6", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "7", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "8", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "9", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "10", monitor = MAIN_MONITOR })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        focus_on_activate = false,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        -- kb_variant   = "dvorak",
        kb_model = "",
        kb_options = "grp:alt_space_toggle",
        kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------
local exec = hl.dsp.exec_cmd
local window = hl.dsp.window
local focus = hl.dsp.focus
local function bind(key, prog, opts)
    hl.bind(MAIN_MOD .. " + " .. key, prog, opts or {})
end

bind("return", exec(TERM))
bind("backspace", exec(BROWSER))
bind("SHIFT + backspace", exec(ALT_BROSER))
bind("CONTROL + W", window.close())
bind("CONTROL + Q", exec("hyprlock"))
bind("CONTROL + SHIFT + Q", exec(POWER_MENU))
bind("CONTROL + D", exec(MENU))
bind("CONTROL + E", window.fullscreen())
bind("V", window.float({ action = "toggle" }))

bind("H", focus({ direction = "left" }))
bind("L", focus({ direction = "right" }))
bind("K", focus({ direction = "up" }))
bind("J", focus({ direction = "down" }))

bind("A", focus({ workspace = 1 }))
bind("S", focus({ workspace = 2 }))
bind("D", focus({ workspace = 3 }))
bind("F", focus({ workspace = 4 }))
bind("G", focus({ workspace = 5 }))
bind("Y", focus({ workspace = 6 }))
bind("U", focus({ workspace = 7 }))
bind("I", focus({ workspace = 8 }))
bind("O", focus({ workspace = 9 }))
bind("P", focus({ workspace = 10 }))

bind("TAB", focus({ last = true }))

bind("CONTROL + H", window.move({ direction = "left" }))
bind("CONTROL + L", window.move({ direction = "right" }))
bind("CONTROL + K", window.move({ direction = "up" }))
bind("CONTROL + J", window.move({ direction = "down" }))

bind("SHIFT + A", window.move({ workspace = 1, monitor = SECONDARY_MONITOR }))
bind("SHIFT + S", window.move({ workspace = 2, monitor = SECONDARY_MONITOR }))
bind("SHIFT + D", window.move({ workspace = 3, monitor = SECONDARY_MONITOR }))
bind("SHIFT + F", window.move({ workspace = 4, monitor = SECONDARY_MONITOR }))
bind("SHIFT + G", window.move({ workspace = 5, monitor = SECONDARY_MONITOR }))
bind("SHIFT + Y", window.move({ workspace = 6, monitor = MAIN_MONITOR }))
bind("SHIFT + U", window.move({ workspace = 7, monitor = MAIN_MONITOR }))
bind("SHIFT + I", window.move({ workspace = 8, monitor = MAIN_MONITOR }))
bind("SHIFT + O", window.move({ workspace = 9, monitor = MAIN_MONITOR }))
bind("SHIFT + P", window.move({ workspace = 10, monitor = MAIN_MONITOR }))

bind("mouse:272", window.drag(), { mouse = true })
bind("mouse:273", window.resize(), { mouse = true })

hl.bind(
    "XF86AudioRaiseVolume",
    exec(DOTFILES .. "/bin/volume_brightness.sh volume_up"),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86AudioLowerVolume",
    exec(DOTFILES .. "/bin/volume_brightness.sh volume_down"),
    { locked = true, repeating = true }
)
hl.bind("XF86AudioMute", exec(DOTFILES .. "/bin/volume_brightness.sh volume_mute"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", exec("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })
