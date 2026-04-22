#!/bin/bash
# ============================================================
# backup.sh
# Creates a compressed backup of a folder with date stamping
# Usage: ./backup.sh <source_folder> <backup_destination>
# Example: ./backup.sh /home/aniket/projects /backup
# ============================================================

set -euo pipefail

# --- Config ---
MAX_BACKUPS=7           # keep only last 7 backups

# --- Logging ---
log_info()  { echo "[INFO]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_error() { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') — $1" >&2; exit 1; }

# --- Validate arguments ---
if [ $# -ne 2 ]; then
    echo "Usage: $0 <source_folder> <backup_destination>"
    echo "Example: $0 /home/aniket/projects /backup"
    exit 1
fi

SOURCE="$1"
DEST="$2"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_$(basename $SOURCE)_${DATE}.tar.gz"

# --- Validate source ---
if [ ! -d "$SOURCE" ]; then
    log_error "Source folder does not exist: $SOURCE"
fi

# --- Create destination if it doesn't exist ---
mkdir -p "$DEST"

# --- Create backup ---
log_info "Starting backup of $SOURCE"
tar -czf "${DEST}/${BACKUP_NAME}" -C "$(dirname $SOURCE)" "$(basename $SOURCE)"
log_info "Backup created: ${DEST}/${BACKUP_NAME}"

# --- Show size ---
SIZE=$(du -sh "${DEST}/${BACKUP_NAME}" | cut -f1)
log_info "Backup size: $SIZE"

# --- Remove old backups, keep only last MAX_BACKUPS ---
BACKUP_COUNT=$(ls "$DEST"/backup_$(basename $SOURCE)_*.tar.gz 2>/dev/null | wc -l)
if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then
    log_info "Removing old backups (keeping last $MAX_BACKUPS)"
    ls -t "$DEST"/backup_$(basename $SOURCE)_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f
fi

log_info "Backup complete"
