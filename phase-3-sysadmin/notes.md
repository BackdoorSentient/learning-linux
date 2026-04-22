# 📖 Phase 3 — System Administration

> **Goal:** Manage services, users, disks, and SSH into a remote server independently.

---

## 3.1 Process Management

A **process** is any running program. Every process has a unique **PID** (Process ID).

```bash
# View all processes
ps aux
# Columns: USER  PID  %CPU  %MEM  VSZ  RSS  TTY  STAT  START  TIME  COMMAND

ps aux --sort=-%cpu | head -10      # top 10 by CPU
ps aux --sort=-%mem | head -10      # top 10 by memory
ps -ef                              # full format listing
pstree                              # visual process tree
pgrep nginx                         # find PID by name
pgrep -l python3                    # show name too

# Live monitors
top                                 # built-in (press q to quit)
htop                                # better (sudo apt install htop)

# Kill processes
kill 1234                           # graceful shutdown (SIGTERM)
kill -9 1234                        # force kill (SIGKILL, no cleanup)
killall nginx                       # kill all by name
pkill -f "python app.py"            # kill by matching command

# Process priority (nice: -20=highest, 19=lowest)
nice -n 10 ./script.sh              # start with lower priority
renice 10 -p 1234                   # change priority of running process
```

### Process States

| State | Meaning |
|-------|---------|
| `R` | Running |
| `S` | Sleeping (waiting for something) |
| `D` | Uninterruptible sleep (usually I/O) |
| `Z` | Zombie (finished but parent hasn't acknowledged) |
| `T` | Stopped |

---

## 3.2 Disk & Storage

```bash
# Disk space
df -h                               # all filesystems
df -h /                             # root partition only
df -i                               # inode usage

# Directory sizes
du -sh /var/log                     # total size of folder
du -sh /var/log/*                   # size of each item inside
du -sh /* 2>/dev/null | sort -rh | head -10    # top 10 largest

# Block devices
lsblk                               # list disks and partitions
lsblk -f                            # show filesystem type
sudo fdisk -l                       # detailed disk info
blkid                               # UUIDs of all partitions

# Mount/Unmount
sudo mount /dev/sdb1 /mnt/usb       # mount USB
sudo umount /mnt/usb                # unmount
mount | column -t                   # view mounted filesystems
cat /etc/fstab                      # auto-mount config

# Filesystem check and repair
sudo fsck /dev/sdb1                 # check filesystem (unmounted only)

# Links
ln -s /var/log/nginx/access.log ~/nginx.log     # symbolic link
ln original.txt hardlink.txt                    # hard link
```

### /etc/fstab — Auto Mount

```bash
# Format: device  mountpoint  fstype  options  dump  pass
UUID=abc123  /mnt/data  ext4  defaults  0  2

# Get UUID of a partition
sudo blkid /dev/sdb1
```

---

## 3.3 Systemd & Services

**Systemd** is PID 1 — the first process Linux starts. It manages all other services.

```bash
# Service control
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx             # reload config, no full restart

# Boot behaviour
sudo systemctl enable nginx             # start on boot
sudo systemctl disable nginx            # don't start on boot
sudo systemctl enable --now nginx       # enable AND start now

# Status
systemctl status nginx
systemctl is-active nginx               # active / inactive
systemctl is-enabled nginx              # enabled / disabled
systemctl is-failed nginx

# List services
systemctl list-units --type=service
systemctl list-units --type=service --state=failed
systemctl list-unit-files --type=service

# Reload systemd after editing service files
sudo systemctl daemon-reload
```

### journalctl — Reading Logs

```bash
journalctl                              # all logs
journalctl -u nginx                     # logs for nginx only
journalctl -u nginx -f                  # follow live
journalctl -u nginx -n 50              # last 50 lines
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx -p err             # errors only
journalctl -b                           # since last boot
journalctl -b -1                        # previous boot
journalctl --since "2024-01-01" --until "2024-01-02"
journalctl -o json-pretty               # JSON format
```

### Writing a Service File

```bash
sudo nano /etc/systemd/system/myapp.service
```

```ini
[Unit]
Description=My FastAPI Application
After=network.target postgresql.service
Requires=postgresql.service

[Service]
Type=simple
User=aniket
Group=aniket
WorkingDirectory=/home/aniket/myapp
EnvironmentFile=/home/aniket/myapp/.env
ExecStart=/home/aniket/myapp/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now myapp
sudo systemctl status myapp
journalctl -u myapp -f
```

### systemd-analyze — Boot Time

```bash
systemd-analyze                         # total boot time
systemd-analyze blame                   # time each service took
systemd-analyze critical-chain          # longest chain of dependencies
systemd-analyze plot > boot.svg         # visual boot chart
```

---

## 3.4 Networking Basics

```bash
# View interfaces and IPs
ip addr
ip addr show eth0

# Routing table
ip route
ip route show default                   # default gateway

# Interface stats
ip -s link

# Bring interface up/down
sudo ip link set eth0 up
sudo ip link set eth0 down

# DNS
cat /etc/resolv.conf                    # DNS servers
cat /etc/hosts                          # local hostname overrides
nslookup google.com
dig google.com
dig google.com +short                   # IP only
dig MX gmail.com                        # mail records
host google.com

# Test connectivity
ping google.com
ping -c 4 google.com
traceroute google.com
mtr google.com                          # live traceroute (sudo apt install mtr)

# Check listening ports
ss -tulnp
ss -tulnp | grep :8000
netstat -tulnp                          # older alternative

# /etc/hosts — local DNS override
sudo nano /etc/hosts
# Add: 127.0.0.1  myapp.local
```

### netplan — Modern Network Config (Ubuntu/Mint)

```bash
# Config location
ls /etc/netplan/

# Example static IP config
sudo nano /etc/netplan/01-netcfg.yaml
```

```yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```

```bash
sudo netplan apply                      # apply changes
sudo netplan try                        # test with auto-revert
```

---

## 3.5 SSH & Remote Access

```bash
# Connect
ssh username@server_ip
ssh -p 2222 aniket@192.168.1.100        # custom port

# Generate key pair (do once)
ssh-keygen -t ed25519 -C "aniket@work"
# Creates: ~/.ssh/id_ed25519 (private) and ~/.ssh/id_ed25519.pub (public)

# Copy public key to server
ssh-copy-id aniket@192.168.1.100
ssh-copy-id -i ~/.ssh/id_ed25519.pub aniket@192.168.1.100

# Fix permissions (SSH requires these exactly)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 600 ~/.ssh/authorized_keys
```

### SSH Config File

```bash
nano ~/.ssh/config
```

```
Host myserver
    HostName 192.168.1.100
    User aniket
    IdentityFile ~/.ssh/id_ed25519
    Port 22
    ServerAliveInterval 60

Host work-vps
    HostName 203.0.113.10
    User ubuntu
    IdentityFile ~/.ssh/id_ed25519
    Port 2222
```

```bash
ssh myserver        # connect using alias
ssh work-vps
```

### SSH Agent

```bash
eval "$(ssh-agent -s)"          # start agent
ssh-add ~/.ssh/id_ed25519       # add key (no passphrase prompts after this)
ssh-add -l                      # list loaded keys
```

### File Transfer

```bash
# scp
scp file.txt aniket@server:/home/aniket/
scp -r folder/ aniket@server:/home/aniket/
scp aniket@server:/remote/file.txt ./

# rsync (smarter — only transfers changes)
rsync -avz ./myapp/ aniket@server:/var/www/myapp/
rsync -avz --delete ./myapp/ aniket@server:/var/www/myapp/     # mirror
rsync -avz --exclude='.git' --exclude='__pycache__' ./ aniket@server:/var/www/
```

### Port Forwarding

```bash
# Local: access remote PostgreSQL on local port 5433
ssh -L 5433:localhost:5432 aniket@server

# Remote: expose local port 3000 on remote port 8080
ssh -R 8080:localhost:3000 aniket@server

# Dynamic: SOCKS proxy
ssh -D 1080 aniket@server
```

---

## 3.6 User & Group Administration

```bash
# User info files
cat /etc/passwd                         # all users (username:x:UID:GID:info:home:shell)
sudo cat /etc/shadow                    # hashed passwords
cat /etc/group                          # all groups

# User management
sudo adduser john                       # create user interactively
sudo useradd -m -s /bin/bash john       # create user (manual)
sudo usermod -aG sudo john              # add john to sudo group
sudo usermod -aG docker john            # add john to docker group
sudo userdel john                       # delete user
sudo userdel -r john                    # delete user + home folder

# Group management
sudo groupadd developers
sudo groupdel developers
sudo gpasswd -d john developers         # remove john from group

# sudo config
sudo visudo                             # safely edit /etc/sudoers
```

### sudoers Examples

```
# In /etc/sudoers (edit with visudo only)
john ALL=(ALL:ALL) ALL                  # give john full sudo
john ALL=(ALL) NOPASSWD: /bin/systemctl # john can run systemctl without password
```

```bash
# Login history
last                                    # login history
lastlog                                 # last login per user
who                                     # currently logged in
w                                       # logged in + what they're doing
```

---

## ✅ Phase 3 Practice Tasks

- [ ] Find top 5 CPU-consuming processes using `ps aux`
- [ ] Find the largest directory under `/var`
- [ ] Install nginx, start it, enable on boot, verify
- [ ] Write a systemd service for a bash script
- [ ] Set up SSH key authentication between two machines
- [ ] Use `rsync` to sync a folder from one location to another
- [ ] Use `systemd-analyze blame` to see what slows down boot
- [ ] Configure a static IP using netplan
