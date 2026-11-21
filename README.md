# .dotfiles

Modern, keyboard-driven Sway WM desktop with dynamic Pywal color palettes, Neovim motions, and custom Wayland tools on Arch Linux.

---

## Installation

```bash
git clone https://github.com/0xwvrn/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

---

## Key Features & Highlights

- **Dynamic Pywal Theming:** Wallpapers generate terminal colors, Waybar styling, Sway borders, Rofi menus, GTK themes, and lockscreens automatically.
- **Vim Navigation Everywhere:** Home-row motions (`h, j, k, l`) across Sway window tiling, Kitty scrolling, and Rofi application launcher menus (`Ctrl/Alt + h/j/k/l`).
- **Battery Health TUI:** Built-in curses-based hardware health monitor (`battery-health` / `bat-health`) tracking degradation, cycle count, real-time wattage discharge, and design vs actual capacity.
- **Waybar Integration:**
  - Real-time battery status with 5-second polling and click-to-open Battery Health TUI.
  - Proton VPN country indicator (`custom/vpn`) displaying active 2-letter country nodes (`NL`, `US`, `CH`) and connection status.
  - Pinned Wi-Fi module (`wlan0`) ensuring VPN tunnel interfaces never mask active SSID.
- **Swaylock Battery Pre-Render:** Lockscreen background dynamically pre-renders live battery health and charging metrics prior to locking.
- **MPV Auto-Organizer:** Custom Lua script (`move-watched.lua`) that automatically moves finished movies (>90% watched) into `~/Videos/Movies/watched`.
- **Audio & Media Scratchpad:** Floating CMUS / media player scratchpad toggled with `$mod + Shift + a`.

---

## Keybindings

> Note: Both **Alt** (`$mod`) and **Super** (Windows key) work interchangeably.

### Window Management & Motions
- `$mod + Return` — Terminal (Kitty)
- `$mod + Space` — App launcher (Rofi with Vim navigation)
- `$mod + q` — Close window (Vim `:q` style)
- `$mod + f` — Toggle fullscreen
- `$mod + b` / `$mod + v` — Horizontal / vertical split
- `$mod + h / j / k / l` — Focus left / down / up / right
- `$mod + Shift + h / j / k / l` — Move window left / down / up / right
- `$mod + 1-9` — Switch workspace
- `$mod + Shift + 1-9` — Move window to workspace
- `$mod + Shift + Space` — Toggle floating
- `$mod + Shift + r` — Reload Sway compositor config
- `$mod + Shift + b` — Toggle Waybar visibility

### TUI Tools & System Utilities
- `$mod + ,` or `$mod + Shift + s` — TUI settings (Wi-Fi, Bluetooth, volume, brightness, power)
- `$mod + \`` — Instant dropdown scratchpad terminal
- `$mod + n` — Quick floating scratchpad notes (`~/Documents/scratch.md`)
- `$mod + Shift + f` — Fuzzy file & code finder (FZF + Ripgrep)
- `$mod + Shift + m` — System monitor (`btm` / bottom)
- `$mod + Shift + a` — Toggle audio player scratchpad
- `$mod + c` — Searchable clipboard history (`cliphist`)
- `$mod + Shift + n` — Rofi Wi-Fi selector
- `$mod + Shift + w` — Interactive wallpaper picker
- `$mod + Ctrl + w` — Random wallpaper & color reload
- `$mod + m` — Power / exit session menu
- `$mod + /` or `F1` — Interactive keybindings HUD cheat sheet
- `battery-health` / `bat-health` — Interactive battery degradation & charge monitor

### Media & Volume Controls
- `XF86AudioPlay` / `Pause` or `$mod + p` — Play / pause
- `XF86AudioNext` or `$mod + ]` — Next track
- `XF86AudioPrev` or `$mod + [` — Previous track
- `XF86AudioRaiseVolume` / `LowerVolume` — Volume +/- 5%
- `XF86AudioMute` — Toggle audio mute
- `XF86MonBrightnessUp` / `Down` — Display brightness +/- 5%

### Screenshots
- `Print` — Fullscreen screenshot (saved to `~/Pictures/Screenshots` + copied to clipboard)
- `Shift + Print` or `$mod + Print` — Interactive crop screenshot (`slurp` + clipboard)

### Trackpad Gestures
- `3-finger swipe left / right` — Switch workspaces seamlessly
