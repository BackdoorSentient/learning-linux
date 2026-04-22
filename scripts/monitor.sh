#!/bin/bash
# ============================================================
# monitor.sh
# Live server health dashboard
# Usage: ./monitor.sh
# ============================================================

set -euo pipefail

clear
DIVIDER="─────────────────────────────────────────────────"

echo "╔═════════════════════════════════════════════════╗"
echo "║           SERVER HEALTH DASHBOARD               ║"
echo "║         $(date '+%Y-%m-%d %H:%M:%S')              ║"
echo "╚═════════════════════════════════════════════════╝"
echo ""

echo "📌 SYSTEM"
echo "$DIVIDER"
echo "Hostname  : $(hostname)"
echo "OS        : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel    : $(uname -r)"
echo "Uptime    : $(uptime -p)"
echo ""

echo "🔥 CPU"
echo "$DIVIDER"
echo "Cores     : $(nproc)"
LOAD=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
echo "Load avg  : $LOAD (1m 5m 15m)"
echo "Top 3 CPU processes:"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=4 {printf "  %-20s %s%%\n", $11, $3}'
echo ""

echo "💾 MEMORY"
echo "$DIVIDER"
free -h | awk 'NR==1{print "  "$0} NR==2{print "  "$0} NR==3{print "  "$0}'
echo ""

echo "💿 DISK"
echo "$DIVIDER"
df -h | grep -v tmpfs | grep -v udev | awk 'NR>1 {
    usage=$5+0
    status="OK"
    if (usage > 80) status="⚠️  WARNING"
    if (usage > 90) status="🔴 CRITICAL"
    printf "  %-20s %5s used  [%s]\n", $6, $5, status
}'
echo ""

echo "🌐 NETWORK"
echo "$DIVIDER"
echo "Listening ports:"
ss -tulnp 2>/dev/null | awk 'NR>1 {printf "  %-6s %-25s %s\n", $1, $5, $7}' | head -10
echo ""

echo "🔐 SECURITY"
echo "$DIVIDER"
FAILED_SSH=$(grep "Failed password" /var/log/auth.log 2>/dev/null | grep "$(date '+%b %e')" | wc -l || echo "0")
echo "Failed SSH logins today: $FAILED_SSH"
BANNED=$(sudo fail2ban-client status sshd 2>/dev/null | grep "Banned IP" | awk -F: '{print $2}' | xargs || echo "fail2ban not running")
echo "Banned IPs (fail2ban)  : $BANNED"
echo ""

echo "⚙️  SERVICES"
echo "$DIVIDER"
SERVICES=("nginx" "ssh" "fail2ban" "postgresql" "docker")
for SVC in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$SVC" 2>/dev/null; then
        echo "  ✅ $SVC"
    else
        echo "  ❌ $SVC (not running)"
    fi
done
echo ""

echo "$DIVIDER"
echo "Run 'watch -n 5 ./monitor.sh' for auto-refresh every 5 seconds"
