#!/bin/bash
# ============================================================================
#  install-exegol.sh — one-shot Exegol installer for Kali
#
#  Brought to you by 7 Minute Security  •  https://7MinSec.com
#  Built with lots of help from Claude (Anthropic).
#  More scripts & wiki: https://7MinSec.wiki
# ============================================================================
#
# Follows https://7minsec.wiki/software/exegol/ and https://docs.exegol.com/first-install
#
# Run as a regular user (NOT root). The user must have sudo rights.
# Re-running is safe; each step checks for prior install before acting.

set -u

# --- Configuration ---
DOCKER_INSTALL_URL="https://get.docker.com/"
EXEGOL_BIN="$HOME/.local/bin/exegol"
APT_PKGS=(git python3 pipx)

# --- Helpers ---

die()  { echo "[!] $1"; exit 1; }
info() { echo "[+] $1"; }
warn() { echo "[-] $1"; }

require_not_root() {
    [[ $EUID -eq 0 ]] && die "Run this as your normal Kali user (not root). pipx installs into \$HOME."
}

require_sudo() {
    command -v sudo &>/dev/null || die "'sudo' is required but not installed."
    info "Caching sudo credentials (you may be prompted)..."
    sudo -v || die "sudo authentication failed."
}

# Pick the user's interactive shell rc file (zsh on Kali by default, fall back to bash)
detect_shell_rc() {
    case "$(basename "${SHELL:-}")" in
        zsh)  echo "$HOME/.zshrc" ;;
        bash) echo "$HOME/.bashrc" ;;
        *)    echo "$HOME/.bashrc" ;;
    esac
}

# --- Install steps ---

install_apt_pkgs() {
    info "Installing apt packages: ${APT_PKGS[*]}"
    sudo apt-get update -qq || die "apt-get update failed."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y "${APT_PKGS[@]}" \
        || die "apt-get install failed."
}

configure_pipx_path() {
    info "Configuring pipx PATH..."
    pipx ensurepath >/dev/null || warn "pipx ensurepath returned non-zero."
    # Make ~/.local/bin available for the rest of THIS script too
    export PATH="$HOME/.local/bin:$PATH"
}

install_docker() {
    if command -v docker &>/dev/null; then
        info "Docker already installed: $(docker --version)"
        return 0
    fi
    info "Installing Docker via official convenience script..."
    curl -fsSL "$DOCKER_INSTALL_URL" | sh \
        || die "Docker install script failed."
    info "Docker installed: $(docker --version 2>/dev/null || echo 'version unknown')"
    warn "Exegol requires standard (rootful) Docker — do NOT enable rootless mode."
}

install_exegol() {
    if pipx list 2>/dev/null | grep -q '^\s*package exegol '; then
        info "Exegol already installed via pipx — upgrading..."
        pipx upgrade exegol || warn "pipx upgrade exegol returned non-zero."
        return 0
    fi
    info "Installing Exegol via pipx..."
    pipx install exegol || die "pipx install exegol failed."
}

install_argcomplete() {
    if pipx list 2>/dev/null | grep -q '^\s*package argcomplete '; then
        info "argcomplete already installed."
    else
        info "Installing argcomplete (shell completion for exegol)..."
        pipx install argcomplete || warn "pipx install argcomplete returned non-zero."
    fi

    local rc="$1"
    local line='eval "$(register-python-argcomplete --no-defaults exegol)"'
    if grep -Fqs "register-python-argcomplete --no-defaults exegol" "$rc"; then
        info "argcomplete eval already present in $rc"
    else
        echo "$line" >> "$rc"
        info "Added argcomplete eval to $rc"
    fi
}

add_exegol_alias() {
    local rc="$1"
    local alias_line="alias exegol='sudo -E $EXEGOL_BIN'"

    if grep -Fqs "alias exegol=" "$rc"; then
        info "exegol alias already present in $rc"
        return 0
    fi
    echo "$alias_line" >> "$rc"
    info "Added exegol alias to $rc"
}

print_next_steps() {
    local rc="$1"
    echo ""
    echo "============================================================"
    info "Exegol install complete."
    echo "============================================================"
    echo ""
    echo "Next steps:"
    echo "  1) Open a NEW terminal (or: source $rc) so the alias + PATH take effect."
    echo "  2) Pull the free image and accept the EULA (auto-answers Y to follow-up prompts):"
    echo "       sudo -v && yes | exegol install free --accept-eula"
    echo "  3) Start a container:"
    echo "       exegol start                        # interactive default"
    echo "       exegol start default free --disable-X11   # headless"
    echo "       exegol start ad -l                  # AD profile, with logging"
    echo "  4) Update later with:"
    echo "       pipx upgrade exegol"
    echo ""
    echo "Reference: https://7minsec.wiki/software/exegol/"
    echo ""
}

# --- Main ---

main() {
    require_not_root
    require_sudo

    local rc
    rc=$(detect_shell_rc)
    info "Using shell rc: $rc"

    install_apt_pkgs
    configure_pipx_path
    install_docker
    install_exegol
    add_exegol_alias "$rc"
    install_argcomplete "$rc"
    print_next_steps "$rc"
}

main "$@"
