#!/usr/bin/env bash
# ==============================================================================
#  0xwvrn's Dotfiles Installer
#  Sway Wayland + Pywal Dynamic Theming + Minimal Sharp Blocky Aesthetic
# ==============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors
C_RESET="\033[0m"
C_BOLD="\033[1m"
C_RED="\033[31m"
C_GREEN="\033[32m"
C_YELLOW="\033[33m"
C_BLUE="\033[34m"
C_CYAN="\033[36m"

info()    { echo -e "${C_CYAN}${C_BOLD}[INFO]${C_RESET} $*"; }
success() { echo -e "${C_GREEN}${C_BOLD}[OK]${C_RESET} $*"; }
warn()    { echo -e "${C_YELLOW}${C_BOLD}[WARN]${C_RESET} $*"; }
error()   { echo -e "${C_RED}${C_BOLD}[ERROR]${C_RESET} $*"; }

banner() {
    clear
    echo -e "${C_CYAN}${C_BOLD}"
    cat << "EOF"
  ██████╗ ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
EOF
    echo -e "${C_RESET}"
    echo -e "${C_BOLD}Automated Dotfiles Setup — Minimal Sway & Dynamic Pywal${C_RESET}\n"
}

# 1. Package Installation (Optional / Interactive)
install_packages() {
    echo -e "\n${C_BOLD}=== Step 1: Package Dependencies ===${C_RESET}"

    if command -v pacman >/dev/null 2>&1; then
        echo -e "Detected ${C_GREEN}Arch Linux${C_RESET} (pacman)."
        read -r -p "Do you want to install required packages now? [y/N] " yn
        if [[ "$yn" =~ ^[Yy]$ ]]; then
            local pkgs=(
                sway swaylock swayidle swaybg waybar rofi-wayland
                kitty zsh tmux fzf brightnessctl playerctl
                networkmanager bluez bluez-utils pipewire wireplumber
                grim slurp wl-clipboard imagemagick python-pywal
                htop mpv
            )
            info "Installing system packages via sudo pacman -S --needed..."
            sudo pacman -S --needed "${pkgs[@]}" || warn "Some packages could not be installed directly."

            # Optional AUR packages
            if command -v yay >/dev/null 2>&1; then
                info "Installing AUR packages (lazygit, glow, gdu, git-delta)..."
                yay -S --needed lazygit glow gdu git-delta || true
            elif command -v paru >/dev/null 2>&1; then
                info "Installing AUR packages (lazygit, glow, gdu, git-delta)..."
                paru -S --needed lazygit glow gdu git-delta || true
            else
                warn "No AUR helper found. Install 'lazygit', 'glow', 'gdu', and 'git-delta' manually if needed."
            fi
        fi
    elif command -v apt-get >/dev/null 2>&1; then
        echo -e "Detected ${C_GREEN}Debian/Ubuntu${C_RESET} (apt)."
        read -r -p "Do you want to install packages via apt? [y/N] " yn
        if [[ "$yn" =~ ^[Yy]$ ]]; then
            sudo apt-get update
            sudo apt-get install -y sway swaylock waybar kitty zsh tmux fzf \
                brightnessctl playerctl network-manager bluez grim slurp wl-clipboard \
                imagemagick python3-pip htop mpv
            pip3 install --user pywal || true
        fi
    elif command -v dnf >/dev/null 2>&1; then
        echo -e "Detected ${C_GREEN}Fedora${C_RESET} (dnf)."
        read -r -p "Do you want to install packages via dnf? [y/N] " yn
        if [[ "$yn" =~ ^[Yy]$ ]]; then
            sudo dnf install -y sway swaylock waybar kitty zsh tmux fzf \
                brightnessctl playerctl NetworkManager bluez grim slurp wl-clipboard \
                ImageMagick python3-pip htop mpv
            pip3 install --user pywal || true
        fi
    else
        warn "Unknown package manager. Skipping automated package installation."
    fi
}

# 2. Deploy Config Files (with Backups)
deploy_dotfiles() {
    echo -e "\n${C_BOLD}=== Step 2: Deploying Configurations ===${C_RESET}"
    
    mkdir -p "${HOME}/.config" "${HOME}/.local/bin" "${HOME}/wallpaper"

    local mode="symlink"
    read -r -p "Deploy method: [S]ymlink (recommended) or [C]opy? [S/c] " choice
    if [[ "$choice" =~ ^[Cc]$ ]]; then
        mode="copy"
    fi

    # Helper function to link or copy
    deploy_item() {
        local src="$1"
        local dest="$2"

        if [ -e "$dest" ] || [ -L "$dest" ]; then
            mkdir -p "$BACKUP_DIR"
            mv "$dest" "$BACKUP_DIR/"
        fi

        mkdir -p "$(dirname "$dest")"
        if [ "$mode" = "symlink" ]; then
            ln -sf "$src" "$dest"
            success "Linked: $dest -> $src"
        else
            cp -rf "$src" "$dest"
            success "Copied: $dest"
        fi
    }

    # Deploy .config folders
    for cfg in sway waybar kitty rofi swaylock swaynag gtk-3.0 gtk-4.0 lazygit glow mpv tmux nvim btop; do
        if [ -d "${DOTFILES_DIR}/${cfg}" ]; then
            deploy_item "${DOTFILES_DIR}/${cfg}" "${HOME}/.config/${cfg}"
        fi
    done

    # Deploy scripts to ~/.local/bin
    if [ -d "${DOTFILES_DIR}/bin" ]; then
        for script in "${DOTFILES_DIR}/bin"/*; do
            local sname
            sname="$(basename "$script")"
            deploy_item "$script" "${HOME}/.local/bin/${sname}"
            chmod +x "${HOME}/.local/bin/${sname}"
        done
        success "Installed scripts in ~/.local/bin/"
    fi

    # Deploy helper libraries to ~/.local/lib
    if [ -d "${DOTFILES_DIR}/lib" ]; then
        mkdir -p "${HOME}/.local/lib"
        for libfile in "${DOTFILES_DIR}/lib"/*; do
            local lname
            lname="$(basename "$libfile")"
            deploy_item "$libfile" "${HOME}/.local/lib/${lname}"
        done
        success "Installed helper libraries in ~/.local/lib/"
    fi

    # Deploy wallpapers
    if [ -d "${DOTFILES_DIR}/wallpapers" ] && [ -n "$(ls -A "${DOTFILES_DIR}/wallpapers" 2>/dev/null)" ]; then
        cp -rn "${DOTFILES_DIR}/wallpapers"/* "${HOME}/wallpaper/" 2>/dev/null || true
        success "Wallpapers installed to ~/wallpaper"
    fi

    # Deploy root dotfiles
    [ -f "${DOTFILES_DIR}/.gdu.yaml" ] && deploy_item "${DOTFILES_DIR}/.gdu.yaml" "${HOME}/.gdu.yaml"
    [ -f "${DOTFILES_DIR}/.gitconfig" ] && deploy_item "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
    [ -f "${DOTFILES_DIR}/.zshrc" ] && deploy_item "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
    [ -f "${DOTFILES_DIR}/.bashrc" ] && deploy_item "${DOTFILES_DIR}/.bashrc" "${HOME}/.bashrc"

    if [ -d "$BACKUP_DIR" ]; then
        info "Existing files backed up to: $BACKUP_DIR"
    fi
}

# 3. Environment & PATH Check
setup_environment() {
    echo -e "\n${C_BOLD}=== Step 3: Shell & Environment Check ===${C_RESET}"

    # Ensure ~/.local/bin is in PATH in profile/rc files
    local path_line='export PATH="$HOME/.local/bin:$PATH"'
    for rc in "${HOME}/.bashrc" "${HOME}/.zshrc"; do
        if [ -f "$rc" ] && ! grep -q '\.local/bin' "$rc"; then
            echo -e "\n# Add user bin to PATH\n$path_line" >> "$rc"
            success "Added ~/.local/bin to PATH in $rc"
        fi
    done

    # Initialize Pywal theme if wallpaper is available
    if command -v wal >/dev/null 2>&1 && [ -x "${HOME}/.local/bin/change-wallpaper" ]; then
        info "Initializing initial Pywal dynamic theme from wallpaper..."
        "${HOME}/.local/bin/change-wallpaper" --random || true
        success "Pywal dynamic colorscheme generated!"
    fi
}

# Main Execution Flow
banner
install_packages
deploy_dotfiles
setup_environment

echo -e "\n${C_GREEN}${C_BOLD}======================================================${C_RESET}"
echo -e "${C_GREEN}${C_BOLD}  Dotfiles Installation Complete! Enjoy your setup.  ${C_RESET}"
echo -e "${C_GREEN}${C_BOLD}======================================================${C_RESET}"
echo -e "To launch Sway: ${C_CYAN}sway${C_RESET}"
echo -e "Open Settings:  ${C_CYAN}\$mod + ,${C_RESET}"
echo -e "Change Theme:   ${C_CYAN}\$mod + Shift + w${C_RESET}\n"
