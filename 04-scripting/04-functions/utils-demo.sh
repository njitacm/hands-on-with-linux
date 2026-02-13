#!/bin/bash
# Demonstrates reusable functions — a mini library.

# --- Utility Functions ---

log_info() {
    echo "[INFO] $(date +%H:%M:%S) $1"
}

log_warn() {
    echo "[WARN] $(date +%H:%M:%S) $1"
}

log_error() {
    echo "[ERROR] $(date +%H:%M:%S) $1" >&2
}

file_exists() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

confirm() {
    read -p "$1 [y/N] " response
    case "$response" in
        [yY]|[yY][eE][sS]) return 0 ;;
        *) return 1 ;;
    esac
}

# --- Main Script ---

log_info "Script started."
log_info "Checking for important files..."

if file_exists "/etc/hostname"; then
    log_info "/etc/hostname exists."
else
    log_warn "/etc/hostname not found."
fi

if file_exists "/nonexistent/file"; then
    log_info "Found it."
else
    log_warn "/nonexistent/file not found (expected)."
fi

if confirm "Do you want to see your environment?"; then
    log_info "Showing environment..."
    echo "User: $USER"
    echo "Shell: $SHELL"
    echo "Home: $HOME"
else
    log_info "Skipped environment display."
fi

log_info "Script finished."
