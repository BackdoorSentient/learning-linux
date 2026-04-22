#!/bin/bash
# ============================================================
# ufw-setup.sh
# Sets up standard UFW firewall rules for a web server
# Usage: sudo ./ufw-setup.sh
# ============================================================

set -euo pipefail

log_info()  { echo "[INFO]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_error() { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') — $1" >&2; exit 1; }

if [ "$EUID" -ne 0 ]; then
    log_error "Please run as root: sudo $0"
fi

log_info "Setting up UFW firewall rules"

ufw --force reset
ufw default deny incoming
ufw default allow outgoing

ufw allow 22/tcp        # SSH
ufw allow 80/tcp        # HTTP
ufw allow 443/tcp       # HTTPS

ufw logging on
ufw --force enable

log_info "Firewall rules applied:"
ufw status verbose
