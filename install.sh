#!/bin/bash

# ============================================
# Death Note Rice - Script de Instalação
# github.com/Sarvire/dotfiles
# ============================================

echo "╔══════════════════════════════════════╗"
echo "║   Death Note Rice - Instalação       ║"
echo "╚══════════════════════════════════════╝"

# Cores
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${RED}[*]${NC} $1"; }

# ============================================
# PACMAN
# ============================================
log "Instalando pacotes principais..."
sudo pacman -S --needed \
    hyprland hyprlock hypridle \
    waybar wofi dunst \
    kitty tmux \
    zsh starship \
    lsd bat git curl wget \
    mpd ncmpcpp mpc cava \
    btop fastfetch \
    cmatrix cbonsai \
    thunar thunar-archive-plugin thunar-volman \
    tumbler gvfs \
    yazi imv \
    firefox discord \
    pipewire wireplumber pipewire-pulse pavucontrol \
    networkmanager blueman \
    polkit-gnome \
    grim slurp wl-clipboard \
    sddm plymouth \
    papirus-icon-theme \
    nwg-look adw-gtk-theme \
    brightnessctl \
    neovim \
    unzip p7zip tar \
    ttf-jetbrains-mono-nerd \
    swaybg \
    easyeffects

# ============================================
# AUR (yay)
# ============================================
log "Instalando pacotes AUR..."

# Instala yay se não tiver
if ! command -v yay &> /dev/null; then
    log "Instalando yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd ~
fi

yay -S --needed \
    swaybg \
    hyprpaper \
    wlogout \
    grimblast-git \
    pipes.sh \
    asciiquarium \
    papirus-folders-git \
    sddm-theme-sugar-candy \
    lazygit \
    vencord-installer-bin \
    grub2-theme-preview \
    spicetify-cli

# ============================================
# OH MY ZSH
# ============================================
log "Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Plugins ZSH
log "Instalando plugins ZSH..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ============================================
# FONTES
# ============================================
log "Instalando fontes..."
sudo mkdir -p /usr/share/fonts/unifraktur
wget -O /tmp/UnifrakturMaguntia.ttf "https://raw.githubusercontent.com/google/fonts/main/ofl/unifrakturmaguntia/UnifrakturMaguntia-Book.ttf"
sudo cp /tmp/UnifrakturMaguntia.ttf /usr/share/fonts/unifraktur/
sudo fc-cache -fv

# ============================================
# CONFIGS
# ============================================
log "Copiando configs..."
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config

# Copia todos os configs
for dir in hypr waybar wofi kitty dunst fastfetch cava btop tmux nvim lazygit yazi mpd ncmpcpp bat; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        cp -r "$DOTFILES_DIR/$dir" ~/.config/
        echo "  ✓ $dir"
    fi
done

# Arquivos soltos
[ -f "$DOTFILES_DIR/.zshrc" ] && cp "$DOTFILES_DIR/.zshrc" ~/
[ -f "$DOTFILES_DIR/.tmux.conf" ] && cp "$DOTFILES_DIR/.tmux.conf" ~/
[ -f "$DOTFILES_DIR/starship.toml" ] && cp "$DOTFILES_DIR/starship.toml" ~/.config/

# ============================================
# SDDM
# ============================================
log "Configurando SDDM..."
sudo cp -r "$DOTFILES_DIR/sddm-sugar-candy" /usr/share/sddm/themes/Sugar-Candy 2>/dev/null
echo "[Theme]" | sudo tee /etc/sddm.conf
echo "Current=Sugar-Candy" | sudo tee -a /etc/sddm.conf
sudo systemctl enable sddm

# ============================================
# PLYMOUTH
# ============================================
log "Configurando Plymouth..."
sudo plymouth-set-default-theme -R MikuPlymouth 2>/dev/null

# ============================================
# ÍCONES
# ============================================
log "Configurando ícones..."
papirus-folders -C red --theme Papirus-Dark 2>/dev/null

# ============================================
# SHELL
# ============================================
log "Trocando shell para ZSH..."
chsh -s /bin/zsh

# ============================================
# LAZY.NVIM
# ============================================
log "Instalando lazy.nvim..."
git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim

# ============================================
# SERVIÇOS
# ============================================
log "Ativando serviços..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber

echo ""
echo "╔══════════════════════════════════════╗"
echo "║   Instalação concluída!              ║"
echo "║   Reinicie o sistema.                ║"
echo "╚══════════════════════════════════════╝"
