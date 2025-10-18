#!/bin/sh

set -e

FEDORA_PKGS="stow git gh sbcl zsh emacs tmux curl wget libvterm-devel gcc make cmake tree ghostty nvim"
ARCH_PKGS="stow git github-cli sbcl zsh emacs tmux curl wget libvterm gcc make cmake tree ghostty nvim"
UBUNTU_PKGS="stow git gh sbcl zsh emacs tmux curl wget libvterm-dev gcc make cmake tree nvim"
MACOS_PKGS="stow gh sbcl tmux wget nvim"

detect_os() {
    if [ "$(uname)" = "Darwin" ]; then
       echo "MACOS"
    elif [ -f /etc/fedora-release ]; then
        echo "FEDORA"
    elif [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
        echo "UBUNTU"
    elif [ -f /etc/arch-release ]; then
        echo "ARCH"
    else
        echo "UNKNOWN"
    fi
}

install_packages_fedora() {
    sudo dnf copr enable scottames/ghostty -y
    sudo dnf update -y
    sudo dnf install -y $FEDORA_PKGS
}

install_packages_arch() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm $ARCH_PKGS
}

install_packages_ubuntu() {
    sudo apt update -y
    sudo apt install -y $UBUNTU_PKGS
    wget https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.2.2-0-ppa1/ghostty_1.2.2-0.ppa1_amd64_24.04.deb
    sudo apt install -y ghostty_1.2.2-0.ppa1_amd64_24.04.deb
}

install_packages_macos() {
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew update
    brew install $MACOS_PKGS
}

install_packages_curl() {
    curl -fsS https://dl.brave.com/install.sh | sh
}

install_packages() {
    echo "Installing system packages..."
    case "$(detect_os)" in
        FEDORA) install_packages_fedora ;;
        UBUNTU) install_packages_ubuntu ;;
        ARCH)   install_packages_arch   ;;
        MACOS)  install_packages_macos  ;;
        *)      echo "Unsupported OS."; exit 1 ;;
    esac
    install_packages_curl
}

extras_linux() {
    gsettings set \
        org.gnome.desktop.input-sources xkb-options \
	"['caps:ctrl_modifier', 'altwin:swap_alt_win']" \
	|| \
	echo "Could not configure keyboard, not using Gnome?"
}

extras_macos() {
    cp fonts/.fonts/* ~/Library/Fonts || cp -L ~/.fonts/* ~/Library/Fonts/
}

extras() {
    case "$(detect_os)" in
        MACOS)  extras_macos ;;
        *)      extras_linux ;;
    esac
}

echo "Detected OS: $(detect_os)"

install_packages
extras
