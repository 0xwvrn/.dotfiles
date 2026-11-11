# .dotfiles

sway wm + pywal on arch linux.

## install

```bash
git clone https://github.com/0xwvrn/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## keybinds

### general
- `$mod + Return` — terminal (kitty)
- `$mod + Space` — app launcher (rofi)
- `$mod + Ctrl + b` — zen browser
- `$mod + e` — close window
- `$mod + f` — fullscreen
- `$mod + b` / `$mod + v` — horizontal / vertical split
- `$mod + 1-9` — switch workspace
- `$mod + Shift + 1-9` — move window to workspace
- `$mod + Shift + space` — toggle floating
- `$mod + Shift + r` — reload sway
- `$mod + Shift + b` — toggle waybar

### utilities
- `$mod + ,` — tui settings (wifi, bt, volume, brightness, power)
- `$mod + \`` — dropdown terminal (scratchpad)
- `$mod + n` — quick notes (`~/Documents/scratch.md`)
- `$mod + Shift + f` — fuzzy file & code finder (fzf + ripgrep)
- `$mod + Shift + m` — htop
- `$mod + c` — clipboard history (cliphist)
- `$mod + Shift + n` — rofi wifi menu
- `$mod + Shift + w` — wallpaper picker
- `$mod + Ctrl + w` — random wallpaper
- `$mod + m` — power exit menu

### media
- `XF86AudioPlay` / `Pause` or `$mod + p` — play / pause
- `XF86AudioNext` or `$mod + ]` — next track
- `XF86AudioPrev` or `$mod + [` — previous track
- `XF86AudioRaiseVolume` / `LowerVolume` — volume +/- 5%
- `XF86AudioMute` — mute toggle

### screenshots
- `Print` — fullscreen screenshot (saves to `~/Pictures/Screenshots` + clipboard)
- `Shift + Print` or `$mod + Print` — crop area screenshot (slurp + clipboard)

### trackpad gestures
- `3-finger swipe left / right` — switch workspace
