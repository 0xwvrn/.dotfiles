# 0xwvrn's Dotfiles

Minimal, sharp, 0px-rectangular blocky desktop environment for **Sway Wayland** powered by dynamic **Pywal** theming, custom TUI control utilities, and instantaneous hardware/keyboard media controls.

---

## ⚡ Features & Architecture

- **Window Manager**: [Sway](https://swaywm.org/) with borderless 0px sharp rectangular aesthetic and smart edge borders.
- **Status Bar**: [Waybar](https://github.com/Alexays/Waybar) with Pywal accent borders and an interactive center **MPRIS media widget** (shows active artist/track from Apple Music / Zen Browser with play/pause and skip on click/scroll).
- **Dynamic Theming**: Custom [`wal-extra`](bin/wal-extra) synchronization engine. Changing your wallpaper instantly recolors:
  - Sway borders & Waybar
  - Kitty terminal & FZF fuzzy finder
  - Tmux statusline (hot-reloads active sessions)
  - GTK 3 & GTK 4 applications (sharp 0px popup menus and flat modern dark theme)
  - Swaylock & Swaynag power exit menu
  - LazyGit, GDU disk analyzer, and Obsidian notes
- **TUI Control Center (`settings`)**: Fast, keyboard-driven settings menu (<kbd>$mod</kbd> + <kbd>,</kbd>) managing Wi-Fi, Bluetooth, Audio sinks, Screen brightness, Wallpapers, Power, and Disk usage without heavy desktop settings daemons.
- **Automated Login Layout**: On login, Sway automatically arranges:
  - **Workspace 1**: Empty & focused (clean desktop view with active wallpaper)
  - **Workspace 2**: Kitty terminal
  - **Workspace 3**: Zen Browser with Apple Music (`music.apple.com`)
  - **Workspace 4**: Zen Browser for general browsing
- **Developer TUIs**:
  - `lazygit` with `delta` side-by-side diffs and Pywal syntax highlighting
  - `glow` markdown reader
  - `gdu` SSD-optimized disk usage analyzer
  - `wifi` interactive NetworkManager TUI scanner with manual and auto-refresh

---

## 📦 Quick Installation

On a fresh installation (Arch Linux, Debian/Ubuntu, or Fedora):

```bash
git clone https://github.com/0xwvrn/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer will:
1. Detect your package manager and optionally install required dependencies.
2. Back up any existing configs to `~/.dotfiles_backup_<timestamp>`.
3. Symlink all configurations to `~/.config/`, `~/.local/bin/`, and `~`.
4. Ensure script execution permissions and initialize your Pywal theme from your wallpaper collection.

---

## ⌨️ Keybindings Cheat Sheet

### General & Navigation
| Shortcut | Action |
| :--- | :--- |
| <kbd>$mod</kbd> + <kbd>Return</kbd> | Open Kitty terminal |
| <kbd>$mod</kbd> + <kbd>Space</kbd> | Application launcher (Rofi) |
| <kbd>$mod</kbd> + <kbd>e</kbd> | Close focused window |
| <kbd>$mod</kbd> + <kbd>Ctrl</kbd> + <kbd>b</kbd> | Open Zen Browser |
| <kbd>$mod</kbd> + <kbd>f</kbd> | Fullscreen toggle |
| <kbd>$mod</kbd> + <kbd>b</kbd> / <kbd>v</kbd> | Horizontal / Vertical split |
| <kbd>$mod</kbd> + <kbd>1</kbd> - <kbd>0</kbd> | Switch to workspace 1–10 |
| <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd> - <kbd>0</kbd> | Move focused window to workspace |

### System & Control TUIs
| Shortcut | Action |
| :--- | :--- |
| **<kbd>$mod</kbd> + <kbd>,</kbd>** | **TUI Control Center** (`settings`) |
| <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>n</kbd> | Wi-Fi network selector (`rofi-wifi-menu`) |
| <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>w</kbd> | Wallpaper picker (interactive) |
| <kbd>$mod</kbd> + <kbd>Ctrl</kbd> + <kbd>w</kbd> | Random wallpaper from `~/wallpaper` |
| <kbd>$mod</kbd> + <kbd>m</kbd> | Power / Exit menu (Lock, Reboot, Poweroff) |
| <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>b</kbd> | Toggle Waybar visibility |
| <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>r</kbd> | Reload Sway configuration |

### Media & Playback Controls
| Shortcut | Action |
| :--- | :--- |
| <kbd>XF86AudioPlay</kbd> / <kbd>XF86AudioPause</kbd> | Play / Pause media |
| <kbd>XF86AudioNext</kbd> / <kbd>Prev</kbd> | Next / Previous track |
| **<kbd>$mod</kbd> + <kbd>p</kbd>** | Keyboard fallback Play / Pause |
| **<kbd>$mod</kbd> + <kbd>]</kbd>** | Next track |
| **<kbd>$mod</kbd> + <kbd>[</kbd>** | Previous track |
| <kbd>XF86AudioRaiseVolume</kbd> / <kbd>Lower</kbd> | Volume +/- 5% |
| <kbd>XF86AudioMute</kbd> | Mute audio sink toggle |

---

## 📂 Repository Structure

```text
~/.dotfiles/
├── bin/                 # Custom utilities (settings, wifi, change-wallpaper, wal-extra, etc.)
├── sway/                # Sway WM configuration
├── waybar/              # Waybar bar layout and Pywal CSS
├── kitty/               # Terminal configuration & themes
├── rofi/                # App launcher theme & applets
├── lazygit/             # LazyGit UI & delta box styling
├── glow/                # Glow terminal markdown config
├── mpv/                 # MPV config, modern uosc UI, & thumbfast
├── tmux/                # Tmux config & pywal theme hooks
├── nvim/                # Neovim configuration
├── swaylock/            # Screen locker config with dynamic battery badge
├── swaynag/             # Power exit overlay bar
├── gtk-3.0/ & gtk-4.0/  # Sharp 0px border GTK settings
├── wallpapers/          # Curated collection of minimal wallpapers
├── .gdu.yaml            # Themed fast disk usage analyzer config
├── .gitconfig           # Git configuration with Delta pager
├── .zshrc & .bashrc     # Shell aliases & Pywal environment hooks
├── install.sh           # One-step automated installer
└── README.md            # Documentation
```

---

## 🎨 Changing Wallpapers & Colors

To change the wallpaper and recalculate colors across your entire system:
```bash
change-wallpaper --select   # Interactive fuzzy picker
change-wallpaper --random   # Random pick from ~/wallpaper
```
Or press <kbd>$mod</kbd> + <kbd>Shift</kbd> + <kbd>w</kbd>.
