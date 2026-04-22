# 📖 Phase 5 — Advanced Topics

> **Goal:** Understand Docker internals, automate with cron and Ansible, tune performance, and understand the Linux boot process.

---

## 5.1 Advanced Bash Scripting

### Strict Mode — Always Use in Production

```bash
#!/bin/bash
set -euo pipefail
# -e  exit immediately on error
# -u  treat undefined variables as errors
# -o pipefail  catch errors inside pipes
```

### Regex with grep

```bash
# Basic regex
grep -E "^[0-9]{3}-[0-9]{4}$" file.txt         # phone numbers
grep -E "[a-z0-9.]+@[a-z0-9.]+\.[a-z]{2,}" f   # emails
grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" f  # IPs

# Regex characters
# .     any character
# *     zero or more
# +     one or more
# ?     zero or one
# ^     start of line
# $     end of line
# [abc] a, b, or c
# [0-9] any digit
# {3}   exactly 3
# {2,5} between 2 and 5

# Perl regex (-P) — most powerful
grep -oP "\d+\.\d+\.\d+\.\d+" access.log       # extract IPs
grep -P "(?<=user=)\w+" logfile.txt             # lookbehind
```

### Advanced Function Patterns

```bash
#!/bin/bash
set -euo pipefail

# Logging with levels
log() {
    local LEVEL="$1"
    local MSG="$2"
    local TS="$(date '+%Y-%m-%d %H:%M:%S')"
    echo "[$TS] [$LEVEL] $MSG"
}
log_info()  { log "INFO " "$1"; }
log_warn()  { log "WARN " "$1"; }
log_error() { log "ERROR" "$1" >&2; exit 1; }

# Retry with backoff
retry() {
    local MAX=$1
    local DELAY=$2
    shift 2
    for i in $(seq 1 $MAX); do
        "$@" && return 0
        log_warn "Attempt $i/$MAX failed. Retrying in ${DELAY}s..."
        sleep $DELAY
    done
    log_error "All $MAX attempts failed"
}

# Check if command exists
require_cmd() {
    command -v "$1" >/dev/null 2>&1 || log_error "$1 is required but not installed"
}

# Script locking
acquire_lock() {
    local LOCK="/tmp/$(basename $0).lock"
    if [ -f "$LOCK" ]; then
        log_error "Script already running (lock: $LOCK)"
    fi
    touch "$LOCK"
    trap "rm -f $LOCK" EXIT
}

# Usage
require_cmd curl
require_cmd jq
acquire_lock
retry 3 5 curl -sf https://api.example.com/health
```

### Heredoc and Herestring

```bash
# Heredoc — multiline input
cat << EOF > /etc/myapp/config.yml
app:
  name: myapp
  env: ${APP_ENV:-development}
  port: 8000
EOF

# Heredoc without variable expansion (use quotes on delimiter)
cat << 'EOF' > script.sh
echo "Literal $VARIABLE — not expanded"
EOF

# Herestring — single string as stdin
grep "error" <<< "this is an error message"
read VAR <<< "hello world"
echo $VAR       # hello world

# SSH heredoc
ssh user@server << 'EOF'
cd /var/www/myapp
git pull origin main
systemctl restart myapp
EOF
```

---

## 5.2 Kernel & Boot Process

```
BIOS/UEFI → detects hardware, finds bootable device
    ↓
GRUB       → bootloader, lets you choose OS or kernel
    ↓
Kernel     → decompresses, initializes hardware drivers
    ↓
initramfs  → temporary filesystem, mounts real root disk
    ↓
systemd    → PID 1 starts, launches all services
    ↓
Login      → display manager or terminal login
```

```bash
# Kernel info
uname -r                            # kernel version
uname -a                            # all system info

# Boot messages
dmesg                               # kernel ring buffer
dmesg | grep -i error
dmesg | grep -i usb
dmesg | grep -i "failed\|error\|warn"
dmesg -T                            # with human-readable timestamps

# Kernel modules
lsmod                               # list loaded modules
modinfo nvidia                      # details about a module
sudo modprobe module_name           # load module
sudo rmmod module_name              # remove module
cat /proc/modules                   # all loaded modules

# GRUB config
cat /etc/default/grub
sudo update-grub                    # apply grub changes

# Boot time analysis
systemd-analyze                     # total boot time
systemd-analyze blame               # time per service
systemd-analyze critical-chain      # longest dependency chain

# /proc — live kernel information
cat /proc/cpuinfo
cat /proc/meminfo
cat /proc/uptime
cat /proc/loadavg
cat /proc/version
ls /proc/                           # each numbered dir = a PID
cat /proc/1234/cmdline              # command that started process 1234
cat /proc/1234/status               # process status and memory
ls /proc/1234/fd                    # open file descriptors

# /sys — hardware info
ls /sys/class/net/                  # network interfaces
cat /sys/class/net/eth0/operstate   # up or down
ls /sys/block/                      # block devices
```

---

## 5.3 Containers & Docker

### How Docker Works Under the Hood

Docker uses Linux kernel features:
- **Namespaces** — isolation (pid, net, mnt, uts, ipc, user)
- **cgroups** — resource limits (CPU, memory, I/O)
- **Union filesystem** — layered images (OverlayFS)

```bash
# Install Docker
sudo apt update
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER       # use docker without sudo (relogin after)

# Basic commands
docker pull ubuntu
docker images
docker ps                           # running containers
docker ps -a                        # all containers

# Run containers
docker run ubuntu echo "hello"
docker run -it ubuntu bash          # interactive terminal
docker run -d nginx                 # detached (background)
docker run -d -p 8080:80 nginx      # map ports
docker run --name myapp -d nginx

# Manage
docker stop myapp
docker start myapp
docker restart myapp
docker rm myapp
docker rm -f myapp                  # force remove running

# Logs
docker logs myapp
docker logs myapp -f
docker logs myapp --tail 50

# Execute inside container
docker exec -it myapp bash
docker exec myapp ls /app

# Resource monitoring
docker stats
docker stats myapp --no-stream      # one snapshot
docker top myapp                    # processes inside container

# Inspect
docker inspect myapp
docker inspect myapp | grep -i IPAddress
```

### cgroup Limits

```bash
# Limit CPU and memory
docker run -d --cpus="0.5" --memory="256m" --name limited nginx

# Verify limits
cat /sys/fs/cgroup/memory/docker/$(docker inspect --format '{{.Id}}' limited)/memory.limit_in_bytes
```

### Docker Networking

```bash
docker network ls
docker network inspect bridge

# Create custom network (recommended)
docker network create myapp-network
docker run -d --network myapp-network --name db postgres
docker run -d --network myapp-network --name api myapp:latest

# Containers on same network reach each other by name
docker exec api curl http://db:5432

# Host network — shares host network stack
docker run --network host nginx
```

### Volumes

```bash
# Named volume
docker volume create mydata
docker run -v mydata:/var/lib/postgresql/data postgres
docker volume ls
docker volume inspect mydata

# Bind mount
docker run -v $(pwd):/app myapp:latest
docker run -v $(pwd)/config:/app/config:ro myapp:latest     # read-only
```

### Writing a Production Dockerfile

```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Copy requirements first (layer caching — only re-runs if requirements change)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app after dependencies
COPY . .

# Never run as root
RUN useradd -m appuser
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```bash
docker build -t myapp:latest .
docker build -t myapp:v1.0 .
docker run -d -p 8000:8000 myapp:latest
```

### Docker Compose

```yaml
# docker-compose.yml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb
    depends_on:
      db:
        condition: service_healthy
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      retries: 5
    restart: unless-stopped

volumes:
  pgdata:
```

```bash
docker compose up -d
docker compose down
docker compose logs -f api
docker compose ps
docker compose restart api
docker compose exec api bash
```

---

## 5.4 Automation — Cron & Ansible

### Cron

```bash
crontab -e          # edit cron jobs for current user
crontab -l          # list cron jobs
crontab -r          # remove all cron jobs
sudo crontab -e     # root cron jobs
```

### Cron Syntax

```
* * * * * command_to_run
│ │ │ │ └── day of week  (0-7, 0 and 7 = Sunday)
│ │ │ └──── month        (1-12)
│ │ └────── day of month (1-31)
│ └──────── hour         (0-23)
└────────── minute       (0-59)
```

### Cron Examples

```bash
* * * * *       /script.sh              # every minute
0 2 * * *       /backup.sh              # every day at 2am
0 9 * * 1       /weekly.sh              # every Monday at 9am
0 * * * *       /hourly.sh              # every hour
*/5 * * * *     /check.sh              # every 5 minutes
0 0 1 * *       /monthly.sh            # 1st of every month at midnight

# Always redirect output to log
0 2 * * * /home/aniket/scripts/backup.sh >> /var/log/backup.log 2>&1
```

### systemd Timers — Modern Cron

```bash
sudo nano /etc/systemd/system/backup.service
```

```ini
[Unit]
Description=Daily Backup

[Service]
Type=oneshot
User=aniket
ExecStart=/home/aniket/scripts/backup.sh
```

```bash
sudo nano /etc/systemd/system/backup.timer
```

```ini
[Unit]
Description=Run backup daily at 2am

[Timer]
OnCalendar=*-*-* 02:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

```bash
sudo systemctl enable --now backup.timer
systemctl list-timers
```

### Ansible Basics

```bash
sudo apt install ansible

# Inventory file
nano ~/inventory.ini
```

```ini
[webservers]
192.168.1.100
192.168.1.101

[databases]
192.168.1.200
```

```bash
# Test connection
ansible all -i inventory.ini -m ping

# Run a command on all servers
ansible all -i inventory.ini -m command -a "uptime"
ansible webservers -i inventory.ini -m command -a "df -h"
```

```yaml
# playbook.yml
---
- name: Setup web server
  hosts: webservers
  become: true

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable nginx
      systemd:
        name: nginx
        state: started
        enabled: yes

    - name: Create app directory
      file:
        path: /var/www/myapp
        state: directory
        owner: aniket
        mode: '0755'
```

```bash
ansible-playbook -i inventory.ini playbook.yml
ansible-playbook -i inventory.ini playbook.yml --check      # dry run
ansible-playbook -i inventory.ini playbook.yml -v           # verbose
```

---

## 5.5 Performance Monitoring & Debugging

### CPU

```bash
nproc                               # number of cores
lscpu                               # detailed CPU info
uptime                              # load average (should be < core count)
cat /proc/loadavg

top                                 # live, press P to sort by CPU
htop                                # better

# Per-core stats
mpstat -P ALL 1

# Top processes by CPU
ps aux --sort=-%cpu | head -10

# Trace system calls
strace -p 1234                      # attach to process
strace ls                           # trace a command
strace -c ls                        # summary of calls and time
strace -e openat ls                 # only trace file open calls
```

### Memory

```bash
free -h
cat /proc/meminfo

# Top processes by memory
ps aux --sort=-%mem | head -10

# OOM killer — did it fire?
journalctl -k | grep -i "oom\|killed process"
dmesg | grep -i oom

# Swap
swapon --show
cat /proc/swaps

# Swappiness (0=prefer RAM, 100=prefer swap)
cat /proc/sys/vm/swappiness
sudo sysctl vm.swappiness=10                        # set temporarily
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.conf  # permanent
```

### Disk I/O

```bash
iostat -x 1                         # extended stats every second
# %util near 100% = disk bottleneck
# await = average wait time in ms

sudo iotop                          # per-process I/O
sudo iotop -o                       # only processes doing I/O

# Find large files
find / -type f -size +100M 2>/dev/null
find /var/log -name "*.log" -size +50M

# Open files
lsof -p 1234                        # files opened by process
lsof /var/log/myapp.log             # who has this file open
lsof -i :8000                       # what's using port 8000
```

### Network

```bash
ip -s link                          # interface stats (bytes in/out)
cat /proc/net/dev

sudo apt install nload
nload eth0                          # live bandwidth per interface

sudo tcpdump -i eth0 -c 100         # capture 100 packets
```

### Debugging Workflow

```bash
# When something is wrong — check in this order:

# 1. What happened recently?
journalctl -b -p err                # errors since boot

# 2. CPU problem?
uptime                              # load vs core count
top -bn1 | head -20

# 3. Memory problem?
free -h                             # is swap being used heavily?
journalctl -k | grep oom

# 4. Disk problem?
df -h                               # is any partition full?
iostat -x 1 3

# 5. Network problem?
ss -tulnp                           # are services listening?
ping gateway_ip
curl -v https://api.example.com

# 6. What is the process doing?
strace -p PID
lsof -p PID
```

---

## 5.6 Storage — Advanced

### LVM — Logical Volume Manager

LVM lets you resize, snapshot, and manage disk space flexibly.

```bash
# Physical Volume (PV)
sudo pvcreate /dev/sdb
sudo pvdisplay
sudo pvs

# Volume Group (VG) — pool of storage
sudo vgcreate myvg /dev/sdb
sudo vgdisplay
sudo vgs

# Logical Volume (LV) — like a partition
sudo lvcreate -L 10G -n mylv myvg
sudo lvdisplay
sudo lvs

# Format and mount
sudo mkfs.ext4 /dev/myvg/mylv
sudo mkdir /mnt/data
sudo mount /dev/myvg/mylv /mnt/data

# Extend (resize) a logical volume
sudo lvextend -L +5G /dev/myvg/mylv
sudo resize2fs /dev/myvg/mylv               # resize filesystem after

# Snapshot (before risky operation)
sudo lvcreate -L 5G -s -n mysnap /dev/myvg/mylv

# Restore from snapshot
sudo lvconvert --merge /dev/myvg/mysnap
```

### NFS — Network File Share

```bash
# Server setup
sudo apt install nfs-kernel-server
sudo nano /etc/exports
# Add: /home/aniket/shared 192.168.1.0/24(rw,sync,no_subtree_check)

sudo exportfs -a
sudo systemctl restart nfs-kernel-server

# Client — mount NFS share
sudo mount 192.168.1.100:/home/aniket/shared /mnt/nfs

# Auto-mount in /etc/fstab
# 192.168.1.100:/home/aniket/shared  /mnt/nfs  nfs  defaults  0  0
```

---

## 5.7 Linux for AI/ML Workloads

> Relevant to your GenAI background — setting up Linux for running AI models

```bash
# Python environment management
sudo apt install python3-venv python3-pip

# Create isolated environment
python3 -m venv myenv
source myenv/bin/activate
pip install fastapi uvicorn langchain openai

# Check GPU
lspci | grep -i nvidia
lspci | grep -i amd

# Nvidia GPU info (if CUDA installed)
nvidia-smi
nvidia-smi -l 1                             # refresh every second
watch -n 1 nvidia-smi                       # watch mode

# CPU governor (performance mode for inference)
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Monitor memory during model inference
watch -n 1 free -h

# Check if model process is using GPU memory
sudo fuser /dev/nvidia*
nvidia-smi | grep python

# huggingface cache location
ls ~/.cache/huggingface/

# Set custom cache dir (useful for large models)
export HF_HOME=/mnt/data/huggingface
export TRANSFORMERS_CACHE=/mnt/data/huggingface
```

---

## ✅ Phase 5 Practice Tasks

- [ ] Write a bash script with retry logic that pings a server 3 times before giving up
- [ ] Use `strace` to trace what happens when you run `cat /etc/hosts`
- [ ] Set up a cron job that runs disk check at 8am daily and logs to file
- [ ] Dockerize a FastAPI app and run with docker-compose
- [ ] Write Ansible playbook to install and configure nginx
- [ ] Create an LVM volume, format it, mount it, extend it by 2GB
- [ ] Use `systemd-analyze blame` to find what slows your boot
- [ ] Set up a Python venv, install packages, run a script
