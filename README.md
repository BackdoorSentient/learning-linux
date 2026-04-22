# 🐧 Learning Linux

<p align="center">
  <b>Author:</b> Aniket Waichal<br>
  <b>A Structured, Hands-On Linux Learning Journey</b><br>
  Built for developers who want to go beyond basics — covering commands, system administration, networking, security, and real-world projects.
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Phase-6-blue" />
  <img src="https://img.shields.io/badge/Topics-45+-orange" />
  <img src="https://img.shields.io/badge/Projects-10+-green" />
  <img src="https://img.shields.io/badge/Scripts-5+-yellow" />
  <img src="https://img.shields.io/badge/Format-Notes%20%26%20Scripts-purple" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
</p>

---

## 📁 Repository Structure

```
learning-linux/
├── README.md
├── learning_path.md                      ← full topic reference
│
├── phase-1-foundation/
│   ├── notes.md                          ← Linux basics, navigation, permissions
│   └── exercises/
│       └── exercise-log.md              ← your daily practice log
│
├── phase-2-shell/
│   ├── notes.md                          ← shell, scripting, pipes, text tools, jq, curl
│   └── scripts/
│       ├── system-info.sh               ← prints system info report
│       └── backup.sh                    ← backup with date stamp + rotation
│
├── phase-3-sysadmin/
│   ├── notes.md                          ← processes, disk, systemd, SSH, networking
│   └── configs/
│       └── nginx-reverse-proxy.conf     ← nginx config for FastAPI
│
├── phase-4-networking/
│   ├── notes.md                          ← UFW, iptables, openssl, logs, hardening
│   └── firewall-rules/
│       └── ufw-setup.sh                 ← standard UFW setup script
│
├── phase-5-advanced/
│   ├── notes.md                          ← Docker, kernel, cron, Ansible, performance, AI/ML
│   └── projects/
│       └── server-setup.sh              ← full server provisioning script
│
├── scripts/
│   └── monitor.sh                       ← live server health dashboard
│
└── cheatsheets/
    ├── commands.md                       ← most-used commands quick reference
    ├── permissions.md                   ← chmod, chown, octal, ACLs
    └── vim.md                           ← vim survival guide
```

---

## 🗺️ Learning Path Overview

| Phase | Topic | Duration | Status |
|-------|-------|----------|--------|
| 1 | [Foundation — Getting Comfortable](./phase-1-foundation/notes.md) | 2 weeks | 🔄 In Progress |
| 2 | [Shell Mastery — Working Faster](./phase-2-shell/notes.md) | 3 weeks | ⏳ Upcoming |
| 3 | [System Administration](./phase-3-sysadmin/notes.md) | 3 weeks | ⏳ Upcoming |
| 4 | [Networking & Security](./phase-4-networking/notes.md) | 3 weeks | ⏳ Upcoming |
| 5 | [Advanced Topics](./phase-5-advanced/notes.md) | 4 weeks | ⏳ Upcoming |
| 6 | Projects & Practice | Ongoing | ⏳ Upcoming |

---

## 📖 What Each Phase Covers

### Phase 1 — Foundation
Linux overview, filesystem hierarchy, terminal navigation, package management, users & permissions, text editors, wildcards, symbolic links

### Phase 2 — Shell Mastery
What is a shell, shortcuts, I/O redirection, pipes, grep/sed/awk/jq, finding files, environment variables, aliases, bash scripting from zero, functions, error handling, retry logic, job control, tmux, curl advanced usage

### Phase 3 — System Administration
Process management, disk & storage, systemd services, writing service files, systemd-analyze, networking basics, netplan, SSH keys & config, port forwarding, file transfer, user & group admin

### Phase 4 — Networking & Security
UFW firewall, iptables direct rules, openssl certificates, GPG encryption, log files, logrotate, network troubleshooting, nmap, tcpdump, server hardening, fail2ban

### Phase 5 — Advanced Topics
Advanced bash patterns, heredoc, kernel & boot process, Docker internals (cgroups/namespaces), Docker Compose, cron jobs, systemd timers, Ansible playbooks, performance debugging (strace, iostat, iotop), LVM, NFS, Linux for AI/ML workloads

---

## 🛠️ Scripts Included

| Script | What it does |
|--------|-------------|
| [system-info.sh](./phase-2-shell/scripts/system-info.sh) | Prints hostname, OS, kernel, CPU, memory, disk |
| [backup.sh](./phase-2-shell/scripts/backup.sh) | Compresses folder with date stamp, keeps last 7 |
| [ufw-setup.sh](./phase-4-networking/firewall-rules/ufw-setup.sh) | Sets up standard UFW rules |
| [server-setup.sh](./phase-5-advanced/projects/server-setup.sh) | Full server provisioning from scratch |
| [monitor.sh](./scripts/monitor.sh) | Live health dashboard — CPU, memory, disk, ports |

---

## 📋 Cheatsheets

| Cheatsheet | Description |
|------------|-------------|
| [commands.md](./cheatsheets/commands.md) | Most-used Linux commands with examples |
| [permissions.md](./cheatsheets/permissions.md) | chmod, chown, octal, ACLs reference |
| [vim.md](./cheatsheets/vim.md) | Vim survival guide — modes, save, quit, search |

---

## ✅ Milestone Checklist

- [ ] Phase 1 — Can navigate filesystem and manage files entirely in terminal
- [ ] Phase 2 — Can write a working bash script and use pipes/grep confidently
- [ ] Phase 3 — Can manage services, users, disks, and SSH into a remote server
- [ ] Phase 4 — Can configure a firewall, read logs, and troubleshoot network issues
- [ ] Phase 5 — Can set up Docker, write cron jobs, and understand the boot process
- [ ] All phases — Can provision, secure, deploy, and monitor a Linux server from scratch

---

## 🔗 Resources

| Resource | What it covers |
|----------|----------------|
| [linuxjourney.com](https://linuxjourney.com) | Interactive beginner lessons |
| [overthewire.org/bandit](https://overthewire.org/wargames/bandit) | Terminal challenges as a game |
| [tldr.sh](https://tldr.sh) | Short practical command examples |
| [explainshell.com](https://explainshell.com) | Break down any command visually |
| [linuxupskillchallenge.org](https://linuxupskillchallenge.org) | 20-day guided sysadmin course |
| [The Linux Command Line — free PDF](http://linuxcommand.org/tlcl.php) | Best beginner book, free |
| [LFS101 on edX](https://www.edx.org/course/introduction-to-linux) | Linux Foundation free course |

---

## 👤 About

**Aniket Waichal** — Software Developer with 3.5+ years of experience specialising in GenAI, LLM-powered applications, and backend systems. This repo documents my Linux and systems fundamentals journey to complement my backend and AI engineering background.

- 💼 [LinkedIn](https://linkedin.com/in/your-profile)
- 🐙 [GitHub](https://github.com/your-username)
- 💻 [LeetCode](https://leetcode.com/your-profile)

---

<p align="center">
  <img src="https://img.shields.io/badge/Started-2026-blue" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
  <img src="https://img.shields.io/badge/Made%20with-curiosity%20%26%20caffeine-orange" />
</p>
