# 📖 Phase 4 — Networking & Security

> **Goal:** Configure a firewall, read system logs, and troubleshoot network issues like a sysadmin.

---

## 4.1 Firewall with UFW

**UFW** (Uncomplicated Firewall) is the beginner-friendly firewall tool on Ubuntu/Mint.

```bash
sudo apt install ufw

# Default policies (set these first)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow by port
sudo ufw allow 22               # SSH
sudo ufw allow 80               # HTTP
sudo ufw allow 443              # HTTPS
sudo ufw allow 8000             # custom app port
sudo ufw allow 5432/tcp         # PostgreSQL TCP only

# Allow by service name
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https

# Restrict by IP
sudo ufw allow from 192.168.1.10 to any port 22
sudo ufw allow from 192.168.1.0/24
sudo ufw deny from 203.0.113.100
sudo ufw allow from 10.0.0.5 to any port 5432

# Enable and check
sudo ufw enable
sudo ufw status verbose
sudo ufw status numbered

# Delete rules
sudo ufw delete 3               # by rule number
sudo ufw delete allow 8000      # by spec

# Logging
sudo ufw logging on
sudo tail -f /var/log/ufw.log

# Disable / Reset
sudo ufw disable
sudo ufw reset
```

---

## 4.2 iptables — Direct Firewall Rules

UFW is a frontend for **iptables**. Understanding iptables gives you full control.

```bash
# View current rules
sudo iptables -L                            # list all rules
sudo iptables -L -v -n                      # verbose, numeric (no DNS lookup)
sudo iptables -L INPUT -v -n --line-numbers # show INPUT chain with line numbers

# Chains
# INPUT   — traffic coming into your machine
# OUTPUT  — traffic leaving your machine
# FORWARD — traffic passing through (for routers)

# Basic rules
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT      # allow SSH
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT      # allow HTTP
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT  # allow established
sudo iptables -A INPUT -i lo -j ACCEPT                  # allow loopback

# Block everything else
sudo iptables -A INPUT -j DROP

# Allow from specific IP
sudo iptables -A INPUT -s 192.168.1.100 -j ACCEPT

# Delete a rule
sudo iptables -D INPUT 3                    # by line number

# Save rules (persist after reboot)
sudo apt install iptables-persistent
sudo netfilter-persistent save
```

---

## 4.3 OpenSSL — Certificates and Encryption

```bash
# Generate private key
openssl genrsa -out private.key 2048

# Generate self-signed certificate
openssl req -new -x509 -key private.key -out cert.pem -days 365

# View certificate details
openssl x509 -in cert.pem -text -noout

# Check expiry date
openssl x509 -in cert.pem -noout -dates

# Check remote certificate
openssl s_client -connect google.com:443 -showcerts

# Check certificate expiry of a website
echo | openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates

# Generate a CSR (Certificate Signing Request)
openssl req -new -key private.key -out request.csr

# Hash a file
openssl dgst -sha256 file.txt

# Encrypt a file
openssl enc -aes-256-cbc -salt -in file.txt -out file.enc -k mypassword

# Decrypt
openssl enc -d -aes-256-cbc -in file.enc -out file.txt -k mypassword
```

---

## 4.4 GPG — File Encryption

```bash
sudo apt install gnupg

gpg --gen-key                           # generate key pair
gpg --list-keys                         # list your keys

# Encrypt for a recipient
gpg -e -r "Aniket" secret.txt           # creates secret.txt.gpg

# Decrypt
gpg -d secret.txt.gpg > secret.txt

# Symmetric encryption (password only, no key needed)
gpg -c secret.txt

# Verify file integrity with hash
sha256sum file.txt
sha256sum file.txt > file.sha256
sha256sum -c file.sha256                # verify
md5sum file.txt
```

---

## 4.5 Logs & Monitoring

### Important Log Files

```bash
/var/log/syslog             # general system messages
/var/log/auth.log           # SSH, sudo, authentication events
/var/log/kern.log           # kernel messages
/var/log/dmesg              # boot and hardware messages
/var/log/apt/history.log    # package install/remove history
/var/log/nginx/access.log   # nginx access log
/var/log/nginx/error.log    # nginx errors
/var/log/ufw.log            # firewall events
```

### Reading Logs

```bash
tail -f /var/log/syslog                                     # follow live
grep "Failed password" /var/log/auth.log                    # failed SSH logins
grep "Failed password" /var/log/auth.log | wc -l            # count

# Top IPs attacking SSH
grep "Failed password" /var/log/auth.log \
    | awk '{print $11}' \
    | sort \
    | uniq -c \
    | sort -rn \
    | head -10

# journalctl
journalctl -f                           # follow all logs live
journalctl -b                           # since last boot
journalctl -p err                       # errors only
journalctl --since "2 hours ago"
journalctl -u nginx -f
journalctl -k | grep -i "error\|fail"   # kernel errors
```

### logrotate

```bash
cat /etc/logrotate.conf
ls /etc/logrotate.d/

# Custom logrotate config for your app
sudo nano /etc/logrotate.d/myapp
```

```
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 aniket aniket
    postrotate
        systemctl reload myapp 2>/dev/null || true
    endscript
}
```

```bash
sudo logrotate -d /etc/logrotate.d/myapp    # dry run
sudo logrotate -f /etc/logrotate.d/myapp    # force run now
```

---

## 4.6 Network Troubleshooting

```bash
# Check your own open ports
ss -tulnp

# Scan remote host
nmap 192.168.1.100                          # basic scan
nmap -sV 192.168.1.100                      # detect service versions
nmap -p 22,80,443,5432 192.168.1.100        # specific ports
nmap -sn 192.168.1.0/24                     # ping scan, find live hosts

# Test if port is open
nc -zv google.com 443
nc -zv localhost 8000

# Capture packets
sudo tcpdump -i eth0
sudo tcpdump -i eth0 port 8000
sudo tcpdump -i eth0 host 192.168.1.1
sudo tcpdump -i eth0 -w capture.pcap        # save to file
sudo tcpdump -r capture.pcap                # read from file

# Which process owns a port
sudo lsof -i :8000
sudo fuser 8000/tcp

# Bandwidth testing
sudo apt install iperf3
iperf3 -s                                   # run as server
iperf3 -c server_ip                         # run as client
```

---

## 4.7 Server Hardening

```bash
# 1. SSH hardening
sudo nano /etc/ssh/sshd_config
```

```
Port 2222
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers aniket
```

```bash
sudo systemctl restart sshd
# IMPORTANT: Test new connection before closing current session!
ssh -p 2222 aniket@server

# 2. fail2ban — auto-ban brute force IPs
sudo apt install fail2ban
sudo systemctl enable --now fail2ban
sudo fail2ban-client status
sudo fail2ban-client status sshd

# View banned IPs
sudo fail2ban-client status sshd | grep "Banned IP"

# 3. Unattended security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades

# 4. Security checks
# Find users with empty passwords
sudo awk -F: '($2 == "") {print $1}' /etc/shadow

# Find world-writable files (security risk)
find / -perm -0002 -type f 2>/dev/null

# Find SUID files
find / -perm -4000 2>/dev/null

# Check listening services
ss -tulnp

# Check login history
last | head -20
```

---

## ✅ Phase 4 Practice Tasks

- [ ] Set up UFW — allow only SSH, HTTP, HTTPS. Verify with `ufw status`
- [ ] Write 3 iptables rules manually and save them
- [ ] Generate a self-signed SSL certificate with openssl
- [ ] Find all failed SSH login attempts in `auth.log` from last 24 hours
- [ ] Install fail2ban, verify it's protecting SSH
- [ ] Use `tcpdump` to capture traffic while making a curl request
- [ ] Harden SSH — disable password auth, disable root login, change port
- [ ] Check certificate expiry of any 3 websites using openssl
