# 󰌌 System Keybindings Cheat Sheet (Keyboard-First Architecture)

> Modern, keyboard-driven Sway desktop with Neovim motions (`h, j, k, l`), scratchpads, and rapid HUD navigation.
> Both **Super** (Windows key) and **Alt** (`$mod`) work interchangeably.

---

## 1. Window Management & Vim Navigation

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + h` | **Focus Left** | Move focus to left window |
| `Super / Alt + j` | **Focus Down** | Move focus to bottom window |
| `Super / Alt + k` | **Focus Up** | Move focus to top window |
| `Super / Alt + l` | **Focus Right** | Move focus to right window |
| `Super / Alt + Shift + h` | **Move Window Left** | Shift focused container left |
| `Super / Alt + Shift + j` | **Move Window Down** | Shift focused container down |
| `Super / Alt + Shift + k` | **Move Window Up** | Shift focused container up |
| `Super / Alt + Shift + l` | **Move Window Right** | Shift focused container right |
| `Super / Alt + q` | **Close Window** | Close focused container (Vim `:q`) |
| `Super / Alt + f` | **Fullscreen** | Toggle fullscreen mode |
| `Super / Alt + Shift + Space` | **Floating Toggle** | Toggle between tiling and floating |
| `Super / Alt + Ctrl + Space` | **Focus Mode Toggle** | Swap focus between tiling and floating windows |
| `Super / Alt + a` | **Focus Parent** | Focus parent container in tree |

---

## 2. Splits & Layouts (Neovim Style)

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + v` | **Vertical Split** | Split current window side-by-side (`:vsplit`) |
| `Super / Alt + b` | **Horizontal Split** | Split current window top/bottom (`:split`) |
| `Super / Alt + s` | **Stacking Layout** | Stack windows on top of each other |
| `Super / Alt + Shift + t` | **Tabbed Layout** | Tabbed window presentation |
| `Super / Alt + t` | **Toggle Split Style** | Toggle between split layouts |
| `Super / Alt + r` | **Resize Mode** | Enter resize mode (`h/j/k/l` to resize, `Esc`/`q` to exit) |

---

## 3. Workspaces & Navigation

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + 1 .. 9` | **Switch Workspace** | Switch to workspace 1 through 9 |
| `Super / Alt + 0` | **Switch Workspace 10** | Switch to workspace 10 |
| `Super / Alt + Shift + 1 .. 9` | **Move to Workspace** | Move window to workspace 1 through 9 |
| `Super / Alt + Tab` | **Next Workspace** | Cycle to the next active workspace (`gt`) |
| `Super / Alt + Shift + Tab` | **Prev Workspace** | Cycle to previous active workspace (`gT`) |
| `3-Finger Swipe Left / Right` | **Gesture Workspace** | Switch workspace via trackpad gestures |

---

## 4. Application Launchers & Floating TUI Tools

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + Return` | **Terminal (Kitty)** | Launch terminal emulator |
| `Super / Alt + Space` | **App Launcher (Rofi)** | Search and run applications |
| `Super / Alt + w` | **Zen Web Browser** | Open primary web browser |
| `Super / Alt + e` | **File Manager (Ranger)** | Fast floating terminal file manager (`h/j/k/l`) |
| `Super / Alt + Shift + d` | **Dolphin** | GUI file manager |
| `Super / Alt + Shift + f` | **Fuzzy File Finder** | Floating `fzf` code & file finder |
| `Super / Alt + Shift + m` | **System Monitor** | Floating `bottom` (`btm`) resource monitor |
| `Super / Alt + n` | **Scratchpad Notes** | Instant floating quick sticky notes |
| `Super / Alt + \`` (grave) | **Dropdown Terminal** | Fast drop-down terminal scratchpad |
| `Super / Alt + Shift + -` | **Send to Scratchpad** | Hide current window to background scratchpad |
| `Super / Alt + -` | **Cycle Scratchpad** | Show/cycle background scratchpad windows |

---

## 5. Menus, Settings & System Controls

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + /` or `F1` | **Keybindings HUD** | Interactive searchable keybinds cheat sheet |
| `Super / Alt + Shift + ?` | **Full Help Manual** | Open this formatted guide in floating Glow |
| `Super / Alt + c` | **Clipboard History** | Fuzzy searchable clipboard manager (`cliphist`) |
| `Super / Alt + ,` (comma) | **Settings & Control** | TUI settings manager (wallpaper, power, disks) |
| `Super / Alt + Shift + n` | **Wi-Fi Menu** | Interactive Rofi Wi-Fi selector |
| `Super / Alt + Shift + w` | **Select Wallpaper** | Rofi visual wallpaper picker |
| `Super / Alt + Ctrl + w` | **Random Wallpaper** | Instant wallpaper & theme shuffle |
| `Super / Alt + Shift + r` | **Reload Sway** | Refresh and re-read Sway configuration |
| `Super / Alt + Shift + b` | **Toggle Waybar** | Hide or unhide Waybar on demand |
| `Super / Alt + m` | **Power & Exit Menu** | Lock, Logout, Reboot, Suspend, Shutdown |
| `Lid Close / swaylock` | **Instant Lockscreen** | High-speed lockscreen with battery badge |

---

## 6. Media & Audio Controls

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `Super / Alt + p` | **Play / Pause** | Toggle active media playback |
| `Super / Alt + ]` | **Next Track** | Skip to next track in player |
| `Super / Alt + [` | **Prev Track** | Skip to previous track in player |
| `XF86AudioMute` | **Mute / Unmute** | Toggle hardware master audio mute |
| `XF86AudioLowerVolume` | **Volume -5%** | Decrease master audio volume |
| `XF86AudioRaiseVolume` | **Volume +5%** | Increase master audio volume |
| `XF86MonBrightnessDown` | **Brightness -5%** | Dim display backlight |
| `XF86MonBrightnessUp` | **Brightness +5%** | Increase display backlight |
| `Print` | **Screenshot Full** | Capture entire desktop |
| `Super / Alt + Print` | **Screenshot Area** | Interactive area/region screenshot crop |

---

## 7. Neovim & TUI Integrated Navigation

### Kitty Terminal:
- `Ctrl + Shift + h` : Open current terminal scrollback buffer directly inside **Neovim** (full regex search `/`, visual select `v`, yank `y`).
- `Ctrl + Shift + u` : Scroll page up (like Vim `<C-u>`).
- `Ctrl + Shift + d` : Scroll page down (like Vim `<C-d>`).
- `Ctrl + Shift + k` : Scroll line up.
- `Ctrl + Shift + j` : Scroll line down.

### Rofi Menus:
- `Ctrl + j` : Move down (Vim motion).
- `Ctrl + k` : Move up (Vim motion).
- `Enter` : Select / Execute.
- `Escape` or `Ctrl + c` : Cancel.

### Tmux:
- `Ctrl + b` followed by `h, j, k, l` : Navigate panes left, down, up, right.
- `Ctrl + b` followed by `v` : Vertical split.
- `Ctrl + b` followed by `s` : Horizontal split.
- `Ctrl + b` followed by `[` : Enter Vi copy mode (`v` to select, `y` to yank to system clipboard).

### MPV Video Player:
- `z` : Advance subtitles backward (-100ms).
- `Z` (`Shift + z`) : Delay subtitles forward (+100ms).
- `Ctrl + z` : Reset subtitle delay to 0.
