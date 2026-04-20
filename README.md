# 🐧 Learning Linux

<p align="center">
  <b>Author:</b> Aniket Waichal<br>
  <b>A Structured, Hands-On Linux Learning Journey</b><br>
  Built for developers who want to go beyond basics — covering commands, system administration, networking, security, and real-world projects.
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Phase-6-blue" />
  <img src="https://img.shields.io/badge/Topics-40+-orange" />
  <img src="https://img.shields.io/badge/Projects-10+-green" />
  <img src="https://img.shields.io/badge/Format-Notes%20%26%20Scripts-purple" />
  <img src="https://img.shields.io/badge/License-MIT-lightgrey" />
</p>

---

## 📁 Repository Structure
learning-linux/
├── README.md
├── phase-1-foundation/
│   ├── notes.md
│   └── exercises/
├── phase-2-shell/
│   ├── notes.md
│   └── scripts/
├── phase-3-sysadmin/
│   ├── notes.md
│   └── configs/
├── phase-4-networking/
│   ├── notes.md
│   └── firewall-rules/
├── phase-5-advanced/
│   ├── notes.md
│   └── projects/
└── cheatsheets/
├── commands.md
├── permissions.md
└── vim.md

---

## 🗺️ Learning Path Overview

| Phase | Topic | Duration | Status |
|-------|-------|----------|--------|
| 1 | Foundation — Getting Comfortable | 2 weeks | 🔄 In Progress |
| 2 | Shell Mastery — Working Faster | 3 weeks | ⏳ Upcoming |
| 3 | System Administration | 3 weeks | ⏳ Upcoming |
| 4 | Networking & Security | 3 weeks | ⏳ Upcoming |
| 5 | Advanced Topics | 4 weeks | ⏳ Upcoming |
| 6 | Projects & Practice | Ongoing | ⏳ Upcoming |

---

## 📖 Phase 1 — Foundation: Getting Comfortable

> Goal: Navigate the filesystem, manage files, and understand Linux basics entirely from the terminal.

- Linux overview & distributions (Ubuntu, Fedora, Arch)
- Filesystem hierarchy — /, /home, /etc, /var, /bin, /usr
- Terminal navigation — pwd, ls, cd, mkdir, rm, cp, mv, cat, less
- Package management — apt, dnf, pacman
- Users, groups & permissions — chmod, chown, sudo
- Text editors — nano basics, vim survival skills

---

## 📖 Phase 2 — Shell Mastery: Working Faster

> Goal: Write working bash scripts and use pipes, redirection, and text tools confidently.

- Bash scripting — variables, conditionals, loops, functions
- I/O redirection & pipes — stdin, stdout, stderr, |, >, >>
- Text processing — grep, sed, awk, cut, sort, uniq, wc
- File search — find, locate, which, whereis
- Environment & shell config — $PATH, .bashrc, alias, export
- Job control & multiplexing — tmux, bg, fg, jobs, kill

---

## 📖 Phase 3 — System Administration

> Goal: Manage services, users, disks, and SSH into a remote server independently.

- Process management — ps, top, htop, kill, nice, renice
- Disk & storage — df, du, lsblk, fdisk, mount, fstab
- Systemd & services — systemctl, journalctl, writing .service files
- Networking basics — ip, ping, curl, ss, netstat
- SSH & remote access — key generation, ssh-copy-id, rsync, scp
- User & group administration — /etc/passwd, /etc/shadow, visudo

---

## 📖 Phase 4 — Networking & Security

> Goal: Configure a firewall, read system logs, and troubleshoot network issues.

- Firewall management — ufw, iptables, nftables
- File security & encryption — gpg, openssl, SUID/SGID, ACLs
- Logs & monitoring — /var/log, journalctl, logrotate
- Network troubleshooting — tcpdump, nmap, wireshark, iperf3
- Hardening basics — fail2ban, SSH hardening, CIS benchmarks

---

## 📖 Phase 5 — Advanced Topics

> Goal: Set up Docker, write cron jobs, and understand the Linux boot process.

- Advanced bash scripting — regex, error handling, getopts, heredoc
- Kernel & boot process — GRUB, kernel modules, /proc, /sys, dmesg
- Containers & virtualization — Docker, Dockerfile, Docker Compose, KVM
- Automation — cron, at, Ansible basics, systemd timers
- Performance tuning — vmstat, iostat, strace, perf, iotop
- Storage advanced — LVM, RAID with mdadm, NFS, Samba, ZFS

---

## 🛠️ Practice Projects

### Beginner
- [ ] System info script — hostname, IP, uptime, disk, RAM
- [ ] Backup script — tar + gzip with date stamping
- [ ] Automate user creation from a CSV file

### Intermediate
- [ ] Set up a LAMP/LEMP stack from scratch
- [ ] Log parser using awk, grep, and sed
- [ ] Cron-based disk usage monitor with alert
- [ ] SSH hardening on a VPS (DigitalOcean / Linode)

### Advanced
- [ ] Dockerize a web app with docker-compose.yml
- [ ] Ansible playbook to provision a fresh Ubuntu server
- [ ] Prometheus + Grafana monitoring setup
- [ ] LVM snapshot and restore workflow
- [ ] Custom firewall ruleset with ufw / iptables

---

## 📋 Cheatsheets

| Cheatsheet | Description |
|------------|-------------|
| [commands.md](./cheatsheets/commands.md) | Most-used Linux commands with examples |
| [permissions.md](./cheatsheets/permissions.md) | chmod, chown, octal notation reference |
| [vim.md](./cheatsheets/vim.md) | Vim survival guide — modes, save, quit, search |

---

## 🔗 Resources

| Resource | What it covers |
|----------|----------------|
| [linuxjourney.com](https://linuxjourney.com) | Interactive beginner lessons |
| [overthewire.org/bandit](https://overthewire.org/wargames/bandit) | Terminal challenges (game format) |
| [tldr.sh](https://tldr.sh) | Short practical command examples |
| [explainshell.com](https://explainshell.com) | Break down any command visually |
| [linuxupskillchallenge.org](https://linuxupskillchallenge.org) | 20-day guided sysadmin course |
| [The Linux Command Line (free PDF)](http://linuxcommand.org/tlcl.php) | Best beginner book, completely free |
| [LFS101 on edX](https://www.edx.org/course/introduction-to-linux) | Linux Foundation free course |

---

## ✅ Milestone Checklist

- [ ] Phase 1 — Can navigate filesystem and manage files entirely in terminal
- [ ] Phase 2 — Can write a working bash script and use pipes/grep confidently
- [ ] Phase 3 — Can manage services, users, disks, and SSH into a remote server
- [ ] Phase 4 — Can configure a firewall, read logs, and troubleshoot network issues
- [ ] Phase 5 — Can set up Docker, write cron jobs, and understand the boot process
- [ ] All phases — Can provision, secure, and maintain a Linux server from scratch

---

## 👤 About

**Aniket Waichal** — Software Developer with 3.5+ years of experience specializing in GenAI, LLM-powered applications, and backend systems. This repo documents my journey into Linux and systems fundamentals to complement my backend and AI engineering background.

- 💼 [LinkedIn](https://linkedin.com/in/your-profile)
- 🐙 [GitHub](https://github.com/your-username)
- 💻 [LeetCode](https://leetcode.com/your-profile)

---

<p align="center">
  <img src="https://img.shields.io/badge/Started-2026-blue" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
  <img src="https://img.shields.io/badge/Made%20with-curiosity%20%26%20caffeine-orange" />
</p>