#!/bin/bash
# ============================================================
# system-info.sh
# Prints a clean system information report
# Usage: ./system-info.sh
# ============================================================

set -euo pipefail

DIVIDER="========================================"

echo "$DIVIDER"
echo "         SYSTEM INFORMATION REPORT"
echo "$DIVIDER"
echo ""
echo "Hostname     : $(hostname)"
echo "OS           : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
echo "Kernel       : $(uname -r)"
echo "Architecture : $(uname -m)"
echo "Uptime       : $(uptime -p)"
echo "Current User : $(whoami)"
echo "Date & Time  : $(date)"
echo ""

echo "--- CPU ---"
echo "Model  : $(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
echo "Cores  : $(nproc)"
echo "Load   : $(cat /proc/loadavg | awk '{print $1, $2, $3}')"
echo ""

echo "--- MEMORY ---"
free -h
echo ""

echo "--- DISK USAGE ---"
df -h | grep -v tmpfs | grep -v udev
echo ""

echo "--- TOP 5 PROCESSES (CPU) ---"
ps aux --sort=-%cpu | head -6 | awk '{printf "%-10s %-6s %-6s %s\n", $1, $2, $3, $11}'
echo ""

echo "$DIVIDER"
