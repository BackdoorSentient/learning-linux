# 📖 Phase 1 — Foundation: Getting Comfortable

> **Goal:** Open a terminal and feel comfortable navigating, creating, editing, and managing files without touching a mouse.

---

## 1.1 What is Linux?

Linux is an **operating system** — just like Windows, but open source and free.

- **Kernel** — the core of Linux. Talks directly to hardware (CPU, RAM, disk)
- **OS** — kernel + tools + package manager + desktop environment
- **Distribution (Distro)** — a packaged version of Linux

### Popular Distros

| Distro | Best For |
|--------|---------|
| Ubuntu | Most popular, great for beginners |
| Linux Mint | Lighter than Ubuntu, looks like Windows, great for old laptops |
| Fedora | Cutting edge features |
| Arch | Advanced — you build everything yourself |
| Kali | Security and hacking focused |
| Debian | Extremely stable, used on servers |

> 💡 For beginners on an old laptop — use **Linux Mint Cinnamon edition**

### How Linux differs from Windows

| Windows | Linux |
|---------|-------|
| `C:\Users\Aniket` | `/home/aniket` |
| Backslash `\` in paths | Forward slash `/` in paths |
| Case insensitive | Case sensitive (`File.txt ≠ file.txt`) |
| Software via .exe | Software via package manager |
| Registry for settings | Plain text config files in `/etc` |
| GUI focused | Terminal is the power tool |

---

## 1.2 The Terminal

The **terminal** is where you type commands to control Linux.

- Open on Linux Mint → `Ctrl + Alt + T`
- The terminal runs **Bash** (Bourne Again Shell) by default

### Reading the prompt

```
aniket@mylaptop:~$
```

| Part | Meaning |
|------|---------|
| `aniket` | your username |
| `mylaptop` | your computer name |
| `~` | current directory (`~` = your home folder) |
| `$` | normal user (`#` means root/admin) |

---

## 1.3 Filesystem Hierarchy

Linux stores everything in one big tree starting from `/` (root).

```
/
├── home/     → personal files (/home/aniket)
├── etc/      → all config files (nginx, ssh, cron)
├── var/      → logs, databases (/var/log, /var/lib)
├── tmp/      → temp files, deleted on reboot
├── bin/      → basic commands (ls, cp, mv)
├── sbin/     → system commands (fdisk, reboot)
├── usr/      → installed programs (/usr/bin, /usr/lib)
├── dev/      → device files (/dev/sda, /dev/null)
├── proc/     → live kernel and process info (virtual)
├── sys/      → hardware info (virtual)
├── root/     → home folder for root user only
├── mnt/      → manually mounted drives
├── media/    → removable media (USB, CD)
└── boot/     → boot loader and kernel files
```

> 💡 Think of `/` like `C:\` in Windows — everything hangs from it

### Absolute vs Relative Path

```bash
# Absolute — starts from root, always works from anywhere
/home/aniket/documents/notes.txt

# Relative — relative to where you currently are
documents/notes.txt     # works only if you are in /home/aniket
./notes.txt             # ./ means current directory
../notes.txt            # ../ means one level up
```

---

## 1.4 Basic Navigation Commands

### `pwd` — Where am I?

```bash
pwd
# Output: /home/aniket
```

### `ls` — List files

```bash
ls                  # list current directory
ls /etc             # list specific directory
ls -l               # long format (permissions, size, date)
ls -a               # show hidden files (files starting with .)
ls -la              # long format + hidden files
ls -lh              # human readable sizes (KB, MB, GB)
ls -lt              # sort by modified time
ls -lS              # sort by size
```

### `cd` — Change Directory

```bash
cd /home/aniket     # go to exact path
cd ~                # go to home directory
cd ..               # go one level up
cd ../..            # go two levels up
cd -                # go back to previous directory
cd documents        # go into documents (relative)
```

### `mkdir` — Make Directory

```bash
mkdir myfolder
mkdir folder1 folder2 folder3
mkdir -p projects/linux/phase1    # create nested folders in one go
```

### `touch` — Create Empty File

```bash
touch notes.txt
touch file1.txt file2.txt file3.txt
```

### `cp` — Copy

```bash
cp notes.txt backup.txt
cp notes.txt /tmp/
cp -r myfolder/ /tmp/myfolder/    # copy folder recursively
cp -p notes.txt backup.txt        # preserve permissions + timestamps
```

### `mv` — Move or Rename

```bash
mv notes.txt documents/           # move file
mv oldname.txt newname.txt        # rename file
mv myfolder/ /tmp/                # move folder
```

### `rm` — Delete

```bash
rm file.txt
rm file1.txt file2.txt
rm -r myfolder/                   # delete folder and contents
rm -rf myfolder/                  # force delete, no confirmation
rmdir emptyfolder                 # only works on empty folder
```

> ⚠️ Linux has no Recycle Bin. `rm` is permanent. Always double-check before `rm -rf`

---

## 1.5 Viewing File Contents

```bash
cat notes.txt               # print entire file
less notes.txt              # scroll through (q to quit, / to search)
head notes.txt              # first 10 lines
head -n 20 notes.txt        # first 20 lines
tail notes.txt              # last 10 lines
tail -n 20 notes.txt        # last 20 lines
tail -f /var/log/syslog     # follow file live (great for logs)
```

---

## 1.6 Getting Help

```bash
man ls                      # full manual page for ls
man cp                      # full manual for cp
ls --help                   # quick summary
whatis ls                   # one-line description
apropos "copy file"         # search manuals by keyword
```

> 💡 Inside `man` — arrow keys scroll, `q` quits, `/word` searches

---

## 1.7 Package Management

A **package manager** is like an app store for Linux. No downloading .exe files.

### apt — Ubuntu / Linux Mint / Debian

```bash
sudo apt update                     # refresh package list (always do this first)
sudo apt upgrade                    # upgrade all installed packages
sudo apt install htop               # install a package
sudo apt install git curl wget vim  # install multiple packages
sudo apt remove htop                # remove package
sudo apt purge htop                 # remove + delete config files
apt search "text editor"            # search for packages
apt show htop                       # show package details
apt list --installed                # list all installed packages
sudo apt autoremove                 # clean up unused packages
```

> 💡 `sudo` = run as administrator. Linux asks for your password the first time.

---

## 1.8 Users, Groups & Permissions

### User Commands

```bash
whoami                          # show current username
id                              # show user ID and group ID
groups                          # show your groups
who                             # show who is logged in
sudo adduser john               # create new user
sudo deluser john               # delete user
passwd                          # change your password
su - john                       # switch to another user
sudo command                    # run command as admin
```

### Understanding Permissions

```bash
ls -la
# Output: -rwxr-xr-- 1 aniket developers 4096 Jan 01 notes.txt
```

| Part | Meaning |
|------|---------|
| `-` | file type (`-`=file, `d`=directory, `l`=symlink) |
| `rwx` | owner: read, write, execute |
| `r-x` | group: read and execute |
| `r--` | others: read only |
| `aniket` | owner |
| `developers` | group |

### Permission Values

| Symbol | Number | Meaning |
|--------|--------|---------|
| `r` | 4 | Read |
| `w` | 2 | Write |
| `x` | 1 | Execute |
| `-` | 0 | No permission |

### Common Permission Combinations

| Octal | Symbolic | Use case |
|-------|----------|---------|
| `777` | rwxrwxrwx | Everyone full access (avoid in production) |
| `755` | rwxr-xr-x | Scripts, directories |
| `644` | rw-r--r-- | Regular files |
| `600` | rw------- | Private files (SSH keys, secrets) |
| `700` | rwx------ | Private directories |

### `chmod` — Change Permissions

```bash
chmod 755 script.sh             # octal notation
chmod 644 notes.txt
chmod 600 secret.txt
chmod +x script.sh              # add execute for everyone
chmod u+x script.sh             # add execute for owner only
chmod g-w notes.txt             # remove write from group
chmod o-r secret.txt            # remove read from others
chmod -R 755 myfolder/          # apply recursively
```

### `chown` — Change Ownership

```bash
chown aniket notes.txt
chown aniket:developers notes.txt
chown -R aniket:aniket myfolder/
```

### Special Permissions

```bash
# SUID — file runs as its owner (not the executor)
chmod u+s /usr/bin/somefile

# SGID — files in directory inherit the group
chmod g+s /var/www/shared

# Sticky bit — only owner can delete their own files in shared dir
chmod +t /shared/folder

# Find all SUID files on system (security check)
find / -perm -4000 2>/dev/null

# ACLs — fine-grained per-user permissions
sudo apt install acl
setfacl -m u:john:rw file.txt   # give john read+write on this file
getfacl file.txt                # view ACL
setfacl -x u:john file.txt      # remove john's ACL
```

---

## 1.9 Text Editors

### nano — Beginner Friendly

```bash
nano notes.txt
```

| Shortcut | Action |
|----------|--------|
| `Ctrl+O` | Save |
| `Ctrl+X` | Exit |
| `Ctrl+K` | Cut line |
| `Ctrl+U` | Paste line |
| `Ctrl+W` | Search |
| `Ctrl+G` | Help |

### vim — Powerful (steep learning curve)

```bash
vim notes.txt
```

| Key | Action |
|-----|--------|
| `i` | Enter insert mode (start typing) |
| `Esc` | Back to normal mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `dd` | Delete current line |
| `yy` | Copy current line |
| `p` | Paste |
| `/word` | Search |
| `n` | Next search result |
| `u` | Undo |
| `gg` | Go to first line |
| `G` | Go to last line |
| `:%s/old/new/g` | Find and replace all |

> 💡 Stuck in vim? Press `Esc` then type `:q!` then Enter — that always gets you out.

---

## 1.10 Wildcards & Globbing

```bash
*           # matches anything
?           # matches any single character
[abc]       # matches a, b, or c
[0-9]       # matches any digit
[a-z]       # matches any lowercase letter

# Examples
ls *.txt                    # all .txt files
ls file?.txt                # file1.txt, file2.txt etc
rm *.log                    # delete all log files
cp /var/log/*.log /backup/  # copy all log files
```

---

## 1.11 Links — Symbolic and Hard

```bash
# Symbolic link (like a shortcut)
ln -s /var/log/nginx/access.log ~/nginx-access.log
ls -la ~/nginx-access.log   # shows -> pointing to real file

# Hard link (another name for same file on disk)
ln original.txt hardlink.txt

# Remove a link
rm ~/nginx-access.log       # removes link, not original file
```

---

## ✅ Phase 1 Practice Tasks

- [ ] Open terminal, run `pwd`, explore filesystem using `ls` and `cd`
- [ ] Create folder structure `projects/linux/phase1/` using one command
- [ ] Create 3 files inside `phase1/`, copy one, rename one, delete one
- [ ] Install `htop` using apt, run it, explore it (press `q` to quit)
- [ ] Create a file, set permissions to `600`, verify with `ls -l`
- [ ] Open file in nano, write something, save, exit, verify with `cat`
- [ ] Find all files larger than 1MB in `/var/log`
- [ ] Create a symbolic link to `/var/log/syslog` in your home directory
