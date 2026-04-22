#!/bin/bash
# ============================================================
# server-setup.sh
# Takes a fresh Ubuntu/Mint install to production-ready
# Run as: sudo ./server-setup.sh <new_username>
# ============================================================

set -euo pipefail

log_info()  { echo "[INFO]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_warn()  { echo "[WARN]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_error() { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') — $1" >&2; exit 1; }

if [ "$EUID" -ne 0 ]; then
    log_error "Please run as root: sudo $0"
fi

if [ $# -ne 1 ]; then
    echo "Usage: sudo $0 <username>"
    exit 1
fi

NEW_USER="$1"

log_info "Starting server provisioning for user: $NEW_USER"

# 1. Update system
log_info "Updating system packages"
apt update && apt upgrade -y

# 2. Install essentials
log_info "Installing essential packages"
apt install -y \
    curl wget git vim htop tmux \
    ufw fail2ban unattended-upgrades \
    net-tools nmap tcpdump mtr \
    jq tree

# 3. Create user
log_info "Creating user: $NEW_USER"
if id "$NEW_USER" &>/dev/null; then
    log_warn "User $NEW_USER already exists"
else
    adduser --gecos "" "$NEW_USER"
    usermod -aG sudo "$NEW_USER"
    log_info "User $NEW_USER created and added to sudo"
fi

# 4. SSH hardening
log_info "Hardening SSH"
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cat > /etc/ssh/sshd_config << 'EOF'
Port 22
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
X11Forwarding no
EOF
systemctl restart sshd

# 5. Firewall
log_info "Configuring UFW firewall"
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw logging on
ufw --force enable

# 6. fail2ban
log_info "Configuring fail2ban"
systemctl enable --now fail2ban

# 7. Unattended upgrades
log_info "Enabling automatic security updates"
echo 'Unattended-Upgrade::Automatic-Reboot "false";' >> /etc/apt/apt.conf.d/50unattended-upgrades
dpkg-reconfigure -f noninteractive unattended-upgrades

# 8. Summary
echo ""
echo "================================================"
echo "  SERVER SETUP COMPLETE"
echo "================================================"
echo "  User created : $NEW_USER (with sudo)"
echo "  SSH          : Root login disabled, password auth disabled"
echo "  Firewall     : UFW enabled (22, 80, 443)"
echo "  fail2ban     : Active"
echo "  Auto-updates : Enabled"
echo ""
echo "  IMPORTANT: Add your SSH public key before logging out!"
echo "  Run: ssh-copy-id ${NEW_USER}@$(hostname -I | awk '{print $1}')"
echo "================================================"
