# 📚 Linux Learning Path — Detailed Topics

<p align="center">
  <b>Author:</b> Aniket Waichal<br>
  <b>A complete structured Linux learning path — from absolute zero to advanced</b><br>
  Built for developers stepping into Linux for the first time — every command explained, no assumptions made.
</p>

---

<p align="center">
  <img src="https://img.shields.io/badge/Phases-6-blue" />
  <img src="https://img.shields.io/badge/Topics-40+-orange" />
  <img src="https://img.shields.io/badge/Projects-10+-green" />
  <img src="https://img.shields.io/badge/Format-Notes%20%26%20Scripts-purple" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
</p>

---

## 🗺️ Overview

| Phase | Topic | Duration | Status |
|-------|-------|----------|--------|
| 1 | Foundation — Getting Comfortable | 2 weeks | 🔄 In Progress |
| 2 | Shell Mastery — Working Faster | 3 weeks | ⏳ Upcoming |
| 3 | System Administration | 3 weeks | ⏳ Upcoming |
| 4 | Networking & Security | 3 weeks | ⏳ Upcoming |
| 5 | Advanced Topics | 4 weeks | ⏳ Upcoming |
| 6 | Projects & Practice | Ongoing | ⏳ Upcoming |

---

## ⚡ Phase 1 — Foundation: Getting Comfortable (Weeks 1–2)

> **Goal:** Open a terminal and feel comfortable navigating, creating, editing, and managing files without touching a mouse.

---

### 1.1 What is Linux?

Linux is an **operating system** — just like Windows, but open source and free.

- **Kernel** — the core of Linux. It talks directly to hardware (CPU, RAM, disk)
- **OS** — kernel + tools + package manager + desktop environment
- **Distribution (Distro)** — a packaged version of Linux. Examples:
  - `Ubuntu` — most popular, great for beginners
  - `Linux Mint` — lighter than Ubuntu, looks like Windows, great for old laptops
  - `Fedora` — cutting edge features
  - `Arch` — advanced, you build everything yourself
  - `Kali` — security and hacking focused

> 💡 For beginners on an old laptop — use **Linux Mint Cinnamon edition**. It is lighter than Ubuntu and feels familiar if you are coming from Windows.

#### How Linux is different from Windows

| Windows | Linux |
|---------|-------|
| Files stored in `C:\Users\Aniket` | Files stored in `/home/aniket` |
| Uses backslash `\` in paths | Uses forward slash `/` in paths |
| Case insensitive (`File.txt = file.txt`) | Case sensitive (`File.txt ≠ file.txt`) |
| Software installed via .exe | Software installed via package manager |
| Registry stores settings | Plain text config files in `/etc` |
| GUI focused | Terminal is the power tool |

---

### 1.2 The Terminal — Your Most Important Tool

The **terminal** (also called command line, shell, or console) is where you type commands to control Linux.

- On Linux Mint — press `Ctrl + Alt + T` to open terminal
- The terminal runs a program called **Bash** (Bourne Again Shell) by default
- Everything you can do with a mouse, you can do faster in the terminal

#### What you see when terminal opens

```
aniket@mylaptop:~$
```

| Part | Meaning |
|------|---------|
| `aniket` | your username |
| `mylaptop` | your computer name |
| `~` | current directory (~ means your home folder) |
| `$` | you are a normal user (# means root/admin) |

---

### 1.3 Filesystem Hierarchy — Where Everything Lives

Linux stores everything in one big tree starting from `/` (called **root**).

```
/
├── home/        → your personal files (/home/aniket)
├── etc/         → all configuration files
├── var/         → logs, databases, variable data
├── tmp/         → temporary files (deleted on reboot)
├── bin/         → basic commands (ls, cp, mv)
├── usr/         → installed programs and libraries
├── dev/         → device files (hard disk, USB)
├── proc/        → live kernel and process info (virtual)
├── sys/         → hardware info (virtual)
├── root/        → home folder for root user only
├── mnt/         → manually mounted drives
└── boot/        → boot loader and kernel files
```

> 💡 Think of `/` like `C:\` in Windows. Everything hangs from it.

#### Absolute vs Relative path

```bash
# Absolute path — starts from root, always correct from anywhere
/home/aniket/documents/notes.txt

# Relative path — relative to where you currently are
documents/notes.txt       # only works if you are already in /home/aniket
./notes.txt               # ./ means current directory
../notes.txt              # ../ means one level up
```

---

### 1.4 Basic Navigation Commands

> These are the first commands you must memorize. You will use them every single day.

#### `pwd` — Print Working Directory (where am I?)

```bash
pwd
# Output: /home/aniket
```

#### `ls` — List files and folders

```bash
ls                    # list files in current directory
ls /etc               # list files in /etc
ls -l                 # long format — shows permissions, size, date
ls -a                 # show hidden files (files starting with .)
ls -la                # long format + hidden files
ls -lh                # human readable file sizes (KB, MB, GB)
ls -lt                # sort by last modified time
```

#### `cd` — Change Directory

```bash
cd /home/aniket       # go to this exact path
cd ~                  # go to your home directory
cd ..                 # go one level up
cd ../..              # go two levels up
cd -                  # go back to previous directory
cd documents          # go into documents folder (relative)
```

#### `mkdir` — Make Directory

```bash
mkdir myfolder                        # create a folder
mkdir folder1 folder2 folder3         # create multiple folders
mkdir -p projects/linux/phase1        # create nested folders in one go
```

#### `touch` — Create an empty file

```bash
touch notes.txt                       # create one file
touch file1.txt file2.txt file3.txt   # create multiple files
```

#### `cp` — Copy files and folders

```bash
cp notes.txt backup.txt               # copy file in same location
cp notes.txt /tmp/notes.txt           # copy file to /tmp
cp -r myfolder/ /tmp/myfolder/        # copy entire folder (-r = recursive)
cp -p notes.txt backup.txt            # copy and preserve permissions + timestamps
```

#### `mv` — Move or Rename

```bash
mv notes.txt documents/               # move file into documents folder
mv oldname.txt newname.txt            # rename a file
mv myfolder/ /tmp/                    # move entire folder
```

#### `rm` — Remove (Delete)

```bash
rm file.txt                           # delete a file
rm file1.txt file2.txt                # delete multiple files
rm -r myfolder/                       # delete folder and everything inside
rm -rf myfolder/                      # force delete, no confirmation (be careful!)
rmdir emptyfolder                     # delete only if folder is empty
```

> ⚠️ **Warning:** Linux has no Recycle Bin. `rm` is permanent. Always double check before running `rm -rf`.

---

### 1.5 Viewing File Contents

```bash
cat notes.txt                         # print entire file to terminal
less notes.txt                        # scroll through file (press q to quit)
head notes.txt                        # show first 10 lines
head -n 20 notes.txt                  # show first 20 lines
tail notes.txt                        # show last 10 lines
tail -n 20 notes.txt                  # show last 20 lines
tail -f /var/log/syslog               # follow file live (great for logs)
```

---

### 1.6 Getting Help

```bash
man ls                                # full manual for ls command
man cp                                # full manual for cp command
ls --help                             # quick help summary
cp --help                             # quick help summary
whatis ls                             # one line description of command
```

> 💡 `man` pages open in `less` — use arrow keys to scroll, press `q` to quit, press `/word` to search.

---

### 1.7 Package Management — Installing Software

A **package manager** is like an app store for Linux. You install, update, and remove software using simple commands — no downloading .exe files.

#### On Linux Mint / Ubuntu — use `apt`

```bash
# Update the list of available packages (do this first, always)
sudo apt update

# Upgrade all installed packages to latest version
sudo apt upgrade

# Install a package
sudo apt install htop

# Install multiple packages at once
sudo apt install git curl wget vim

# Remove a package
sudo apt remove htop

# Remove package and its config files
sudo apt purge htop

# Search for a package
apt search "text editor"

# Show info about a package
apt show htop

# List installed packages
apt list --installed

# Clean up unused packages
sudo apt autoremove
```

> 💡 `sudo` means "run as administrator". Linux asks for your password the first time.

---

### 1.8 Users, Groups & Permissions

#### Users and Groups

Every file in Linux has:
- An **owner** (a user)
- A **group** (a group of users)
- **Permissions** (who can read, write, execute)

```bash
whoami                                # show current username
id                                    # show user ID, group ID
groups                                # show groups you belong to
who                                   # show who is logged in

# Create a new user
sudo adduser john

# Delete a user
sudo deluser john

# Change your password
passwd

# Switch to another user
su - john

# Run a command as admin
sudo command
```

#### Understanding Permissions

When you run `ls -l` you see something like:

```
-rwxr-xr-- 1 aniket developers 4096 Jan 01 10:00 script.sh
```

| Part | Meaning |
|------|---------|
| `-` | file type (- = file, d = directory, l = symlink) |
| `rwx` | owner can read, write, execute |
| `r-x` | group can read and execute, not write |
| `r--` | others can only read |
| `aniket` | owner of the file |
| `developers` | group assigned to file |

#### Permission values

| Symbol | Number | Meaning |
|--------|--------|---------|
| `r` | 4 | Read |
| `w` | 2 | Write |
| `x` | 1 | Execute |
| `-` | 0 | No permission |

Common combinations:
```
7 = rwx = 4+2+1 = full access
6 = rw- = 4+2   = read and write
5 = r-x = 4+1   = read and execute
4 = r-- = 4     = read only
0 = --- = 0     = no access
```

#### `chmod` — Change permissions

```bash
chmod 755 script.sh         # owner=rwx, group=r-x, others=r-x
chmod 644 notes.txt         # owner=rw-, group=r--, others=r--
chmod 600 secret.txt        # owner=rw-, group=---, others=--- (private)
chmod +x script.sh          # add execute permission for everyone
chmod u+x script.sh         # add execute for owner only
chmod g-w notes.txt         # remove write from group
chmod -R 755 myfolder/      # apply recursively to all files in folder
```

#### `chown` — Change ownership

```bash
chown aniket notes.txt              # change owner to aniket
chown aniket:developers notes.txt   # change owner and group
chown -R aniket:aniket myfolder/    # change recursively
```

---

### 1.9 Text Editors

#### nano — Beginner friendly

```bash
nano notes.txt              # open or create file in nano
```

| Shortcut | Action |
|----------|--------|
| `Ctrl + O` | Save file |
| `Ctrl + X` | Exit |
| `Ctrl + K` | Cut line |
| `Ctrl + U` | Paste line |
| `Ctrl + W` | Search |
| `Ctrl + G` | Help |

#### vim — Powerful but has a learning curve

```bash
vim notes.txt               # open file in vim
```

| Key | Action |
|-----|--------|
| `i` | Enter insert mode (start typing) |
| `Esc` | Go back to normal mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `dd` | Delete current line |
| `yy` | Copy current line |
| `p` | Paste |
| `/word` | Search for word |

> 💡 Stuck in vim? Press `Esc` then type `:q!` and press Enter. That always gets you out.

---

### 1.10 Phase 1 Practice Tasks

- [ ] Open terminal and run `pwd`, `ls`, `cd` to explore your filesystem
- [ ] Create a folder structure: `projects/linux/phase1/` using one command
- [ ] Create 3 files inside `phase1/`, copy one, rename one, delete one
- [ ] Install `htop` using apt and run it (press `q` to quit)
- [ ] Create a file, set its permission to `600`, verify with `ls -l`
- [ ] Open a file in nano, write something, save it, exit, verify with `cat`

---

## ⚡ Phase 2 — Shell Mastery: Working Faster (Weeks 3–5)

> **Goal:** Write working bash scripts, use pipes, redirection, and text processing tools confidently.

---

### 2.1 What is a Shell?

The **shell** is the program that reads your commands and executes them. Think of it as the interpreter between you and the Linux kernel.

```
You type command → Shell reads it → Kernel executes it → Output comes back
```

- **Bash** (Bourne Again Shell) — default on most Linux distros
- **Zsh** — popular alternative with more features
- **sh** — older, basic shell

```bash
# Check which shell you are using
echo $SHELL
# Output: /bin/bash

# Check bash version
bash --version
```

---

### 2.2 Essential Shell Shortcuts

| Shortcut | What it does |
|----------|-------------|
| `Tab` | Auto-complete command or filename |
| `Tab Tab` | Show all possible completions |
| `↑ ↓` | Navigate command history |
| `Ctrl + R` | Search command history |
| `Ctrl + C` | Cancel running command |
| `Ctrl + Z` | Suspend running command |
| `Ctrl + L` | Clear terminal screen |
| `Ctrl + A` | Move cursor to start of line |
| `Ctrl + E` | Move cursor to end of line |
| `!!` | Repeat last command |
| `sudo !!` | Repeat last command with sudo |

```bash
# View command history
history

# Run command number 42 from history
!42

# Clear history
history -c
```

---

### 2.3 I/O Redirection & Pipes

#### Standard streams

Every command in Linux has 3 streams:

| Stream | Number | Meaning |
|--------|--------|---------|
| `stdin` | 0 | Input (from keyboard by default) |
| `stdout` | 1 | Normal output (to terminal by default) |
| `stderr` | 2 | Error output (to terminal by default) |

#### Redirecting output

```bash
# Send output to a file (overwrite)
ls -la > filelist.txt

# Send output to a file (append, do not overwrite)
echo "new line" >> notes.txt

# Send errors to a file
ls /fakefolder 2> errors.txt

# Send both output and errors to same file
ls -la /etc 2>&1 > output.txt

# Discard output (send to void)
command > /dev/null

# Discard errors
command 2> /dev/null

# Discard everything
command > /dev/null 2>&1
```

#### Pipes — chain commands together

The `|` (pipe) takes output of one command and feeds it as input to next command.

```bash
# List files and search through them
ls -la | grep ".txt"

# Show running processes and search for python
ps aux | grep python

# Count how many lines a file has
cat file.txt | wc -l

# Show last 5 lines of sorted output
cat file.txt | sort | tail -5

# Show disk usage, sorted by size
du -sh /* 2>/dev/null | sort -rh | head -10
```

---

### 2.4 Text Processing Tools

These are extremely powerful tools for working with text files and command output.

#### `grep` — Search for patterns

```bash
grep "error" logfile.txt              # find lines containing "error"
grep -i "error" logfile.txt           # case insensitive search
grep -n "error" logfile.txt           # show line numbers
grep -r "error" /var/log/             # search recursively in folder
grep -v "error" logfile.txt           # show lines NOT containing error
grep -c "error" logfile.txt           # count matching lines
grep -l "error" /var/log/*.log        # show only filenames that match
grep "^error" logfile.txt             # lines starting with error
grep "error$" logfile.txt             # lines ending with error
grep -E "error|warning" logfile.txt   # match error OR warning
```

#### `sed` — Stream Editor (find and replace)

```bash
# Replace first occurrence per line
sed 's/old/new/' file.txt

# Replace all occurrences
sed 's/old/new/g' file.txt

# Replace and save back to file
sed -i 's/old/new/g' file.txt

# Delete lines containing a pattern
sed '/error/d' file.txt

# Print only lines 5 to 10
sed -n '5,10p' file.txt

# Add a line after line 3
sed '3a\This is a new line' file.txt
```

#### `awk` — Column-based text processing

```bash
# Print first column of every line
awk '{print $1}' file.txt

# Print second and third column
awk '{print $2, $3}' file.txt

# Use custom delimiter (CSV)
awk -F',' '{print $1}' data.csv

# Print lines where column 3 is greater than 100
awk '$3 > 100' data.txt

# Print line count
awk 'END {print NR}' file.txt

# Print column with label
awk '{print "Name:", $1, "Age:", $2}' file.txt
```

#### Other useful text tools

```bash
sort file.txt                         # sort lines alphabetically
sort -r file.txt                      # sort in reverse
sort -n numbers.txt                   # sort numerically
sort -u file.txt                      # sort and remove duplicates

uniq file.txt                         # remove consecutive duplicate lines
uniq -c file.txt                      # count occurrences
uniq -d file.txt                      # show only duplicate lines

cut -d',' -f1 data.csv                # cut first field using , delimiter
cut -c1-10 file.txt                   # cut first 10 characters of each line

tr 'a-z' 'A-Z' < file.txt            # convert lowercase to uppercase
tr -d '\n' < file.txt                 # remove all newlines

diff file1.txt file2.txt              # show differences between two files

wc file.txt                           # count lines, words, bytes
wc -l file.txt                        # count lines only
```

---

### 2.5 Finding Files

```bash
# find — most powerful
find /home -name "notes.txt"                    # find by name
find /home -name "*.txt"                        # find all .txt files
find /var/log -name "*.log" -type f             # only files, not folders
find / -name "*.conf" -type f 2>/dev/null       # suppress permission errors
find /home -size +10M                           # files larger than 10MB
find /tmp -mtime +7                             # files older than 7 days
find /home -user aniket                         # files owned by aniket
find . -name "*.py" -exec grep "import" {} \;  # find and run command on each

# locate — faster but uses a database (needs update first)
sudo updatedb
locate notes.txt

# which — find where a command lives
which python3
which bash

# whereis — find binary, source, and man page
whereis nginx
```

---

### 2.6 Environment Variables & Shell Config

#### What are environment variables?

They are named values that store configuration the shell and programs use.

```bash
# View all environment variables
env
printenv

# View a specific variable
echo $HOME
echo $PATH
echo $USER
echo $SHELL

# Set a variable for current session only
MY_NAME="Aniket"
echo $MY_NAME

# Export variable so child processes can see it
export APP_ENV="production"

# Remove a variable
unset MY_NAME
```

#### Important built-in variables

| Variable | What it contains |
|----------|-----------------|
| `$HOME` | Your home directory path |
| `$USER` | Your username |
| `$SHELL` | Path to your shell |
| `$PATH` | List of directories where commands are searched |
| `$PWD` | Current directory |
| `$EDITOR` | Default text editor |
| `$?` | Exit code of last command (0 = success) |
| `$$` | PID of current shell |

#### `$PATH` explained

When you type `ls`, the shell searches through all directories in `$PATH` to find the `ls` binary.

```bash
echo $PATH
# Output: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add a new directory to PATH
export PATH="$PATH:/home/aniket/scripts"
```

#### Shell config files

```bash
~/.bashrc          # runs every time you open a new terminal
~/.bash_profile    # runs once at login
~/.profile         # runs at login (fallback)
/etc/profile       # system-wide config for all users
/etc/bash.bashrc   # system-wide bashrc
```

#### Aliases — create shortcuts

```bash
# Add to ~/.bashrc
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias update='sudo apt update && sudo apt upgrade'

# Apply changes without restarting terminal
source ~/.bashrc

# View all aliases
alias
```

---

### 2.7 Bash Scripting — From Zero

A **shell script** is just a text file containing a list of commands that get executed in order. It is the most powerful automation tool in Linux.

#### Your first script

```bash
# Step 1: Create the file
nano hello.sh

# Step 2: Write this inside:
#!/bin/bash
echo "Hello, Aniket!"
echo "Today is: $(date)"
echo "You are in: $(pwd)"

# Step 3: Save (Ctrl+O, Enter, Ctrl+X)

# Step 4: Make it executable
chmod +x hello.sh

# Step 5: Run it
./hello.sh
```

> 💡 `#!/bin/bash` is called the **shebang**. It tells Linux which interpreter to use to run the script. Always put this as the very first line.

#### Variables in scripts

```bash
#!/bin/bash

# Declare a variable (no spaces around =)
NAME="Aniket"
AGE=25
CITY="Pune"

# Use variables with $
echo "My name is $NAME"
echo "I am $AGE years old"
echo "I live in ${CITY}"        # curly braces are safer, use always

# Store command output in variable
CURRENT_DATE=$(date +%Y-%m-%d)
HOSTNAME=$(hostname)
echo "Today: $CURRENT_DATE on $HOSTNAME"

# Read-only variable
readonly MAX=100

# Unset variable
unset CITY
```

#### Taking user input

```bash
#!/bin/bash

# Basic input
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME!"

# Silent input (for passwords)
read -sp "Enter password: " PASSWORD
echo ""    # newline after silent input
echo "Password received"

# Input with timeout (5 seconds)
read -t 5 -p "Quick! Enter something: " ANSWER
```

#### Conditionals — if, elif, else

```bash
#!/bin/bash

AGE=20

# Basic if
if [ $AGE -ge 18 ]; then
    echo "You are an adult"
fi

# if-else
if [ $AGE -ge 18 ]; then
    echo "Adult"
else
    echo "Minor"
fi

# if-elif-else
if [ $AGE -lt 13 ]; then
    echo "Child"
elif [ $AGE -lt 18 ]; then
    echo "Teenager"
elif [ $AGE -lt 60 ]; then
    echo "Adult"
else
    echo "Senior"
fi
```

#### Comparison operators

```bash
# Numbers
-eq    # equal to
-ne    # not equal to
-gt    # greater than
-lt    # less than
-ge    # greater than or equal to
-le    # less than or equal to

# Strings
==     # equal
!=     # not equal
-z     # is empty (zero length)
-n     # is not empty

# Files
-f     # is a regular file
-d     # is a directory
-e     # exists (file or directory)
-r     # is readable
-w     # is writable
-x     # is executable
```

#### File and string checks — examples

```bash
#!/bin/bash

FILE="/etc/nginx/nginx.conf"

# Check if file exists
if [ -f "$FILE" ]; then
    echo "Nginx config exists"
else
    echo "Nginx config NOT found"
fi

# Check if directory exists
if [ -d "/var/log/myapp" ]; then
    echo "Log directory exists"
fi

# Check if variable is empty
NAME=""
if [ -z "$NAME" ]; then
    echo "Name is empty"
fi

# Check if variable is not empty
if [ -n "$NAME" ]; then
    echo "Name is: $NAME"
fi

# String comparison
ENV="production"
if [ "$ENV" == "production" ]; then
    echo "Running in production!"
fi
```

#### Loops

```bash
#!/bin/bash

# For loop — list of items
for FRUIT in apple banana mango orange; do
    echo "Fruit: $FRUIT"
done

# For loop — range of numbers
for i in {1..5}; do
    echo "Number: $i"
done

# For loop — with step
for i in {0..20..5}; do
    echo "$i"
done

# For loop — over files
for FILE in /var/log/*.log; do
    echo "Processing: $FILE"
done

# While loop
COUNTER=1
while [ $COUNTER -le 5 ]; do
    echo "Count: $COUNTER"
    ((COUNTER++))
done

# Until loop (opposite of while — runs until condition is TRUE)
NUM=1
until [ $NUM -gt 5 ]; do
    echo "Num: $NUM"
    ((NUM++))
done

# Loop control
for i in {1..10}; do
    if [ $i -eq 5 ]; then
        continue    # skip number 5
    fi
    if [ $i -eq 8 ]; then
        break       # stop at 8
    fi
    echo $i
done
```

#### Functions

```bash
#!/bin/bash

# Define a function
say_hello() {
    echo "Hello, $1!"       # $1 is first argument passed to function
}

# Function with multiple arguments
greet() {
    local NAME=$1           # local = only exists inside this function
    local AGE=$2
    echo "Hi $NAME, you are $AGE years old"
}

# Function with return value
add() {
    local RESULT=$(( $1 + $2 ))
    echo $RESULT            # use echo to "return" a value
}

# Call functions
say_hello "Aniket"
greet "Aniket" 25
TOTAL=$(add 10 20)
echo "Total: $TOTAL"
```

#### Script arguments

```bash
#!/bin/bash

# When you run: ./script.sh hello world 123
echo "Script name: $0"     # ./script.sh
echo "First arg:   $1"     # hello
echo "Second arg:  $2"     # world
echo "Third arg:   $3"     # 123
echo "All args:    $@"     # hello world 123
echo "Arg count:   $#"     # 3

# Check if argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
```

#### Exit codes

```bash
#!/bin/bash

# Every command returns an exit code
# 0 = success, anything else = failure

ls /etc > /dev/null
echo "Exit code: $?"          # prints 0 (success)

ls /fakefolder > /dev/null 2>&1
echo "Exit code: $?"          # prints non-zero (failure)

# Exit script with a code
exit 0     # success
exit 1     # general error
```

#### Error handling

```bash
#!/bin/bash

# Exit script immediately if any command fails
set -e

# Exit if undefined variable is used
set -u

# Catch errors in pipes
set -o pipefail

# All three together (best practice)
set -euo pipefail

# Run cleanup when script exits for any reason
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/lockfile
}
trap cleanup EXIT

# Handle errors with || 
cp file.txt /backup/ || { echo "Copy failed!"; exit 1; }
```

#### Practical script example — System Info

```bash
#!/bin/bash
# Script: system-info.sh
# Shows basic system information

set -euo pipefail

echo "========================================"
echo "       SYSTEM INFORMATION REPORT"
echo "========================================"
echo ""
echo "Hostname     : $(hostname)"
echo "OS           : $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
echo "Kernel       : $(uname -r)"
echo "Uptime       : $(uptime -p)"
echo "Current User : $(whoami)"
echo "Date & Time  : $(date)"
echo ""
echo "--- CPU ---"
echo "Model        : $(cat /proc/cpuinfo | grep 'model name' | head -1 | cut -d: -f2 | xargs)"
echo "Cores        : $(nproc)"
echo ""
echo "--- MEMORY ---"
free -h
echo ""
echo "--- DISK USAGE ---"
df -h | grep -v tmpfs
echo ""
echo "========================================"
```

---

### 2.8 Job Control

```bash
# Run command in background
./script.sh &

# View background jobs
jobs

# Bring job to foreground
fg %1

# Send job to background
bg %1

# Ctrl+Z — suspend (pause) a running job
# Then run bg to resume it in background

# Kill a job
kill %1

# Kill by PID
kill 1234
kill -9 1234              # force kill (SIGKILL)
```

---

### 2.9 tmux — Terminal Multiplexer

**tmux** lets you split one terminal into multiple panes, run things in background, and keep sessions alive even after you disconnect.

```bash
# Install
sudo apt install tmux

# Start new session
tmux

# Start named session
tmux new -s mysession

# Detach from session (keeps running in background)
Ctrl+B then D

# List sessions
tmux ls

# Attach to session
tmux attach -t mysession

# Kill session
tmux kill-session -t mysession
```

#### tmux key bindings (all start with `Ctrl+B`)

| Shortcut | Action |
|----------|--------|
| `Ctrl+B "` | Split pane horizontally |
| `Ctrl+B %` | Split pane vertically |
| `Ctrl+B arrow` | Move between panes |
| `Ctrl+B c` | New window |
| `Ctrl+B n` | Next window |
| `Ctrl+B p` | Previous window |
| `Ctrl+B d` | Detach session |
| `Ctrl+B [` | Scroll mode (use arrow keys, q to quit) |

---

### 2.10 Phase 2 Practice Tasks

- [ ] Write a script that takes a filename as argument and prints how many lines it has
- [ ] Write a script that checks if nginx is installed and prints installed or not
- [ ] Use grep and awk together to extract all IP addresses from `/var/log/auth.log`
- [ ] Write a backup script that creates a `.tar.gz` of a folder with today's date in filename
- [ ] Create a useful alias in `~/.bashrc` and apply it without restarting terminal
- [ ] Open tmux, split into 3 panes, run different commands in each

---

## ⚡ Phase 3 — System Administration (Weeks 6–8)

> **Goal:** Manage services, users, disks, and connect to remote servers via SSH independently.

---

### 3.1 Process Management

A **process** is any running program. Every process has a unique **PID** (Process ID).

```bash
# View all running processes
ps aux

# ps output columns:
# USER  PID  %CPU  %MEM  VSZ  RSS  TTY  STAT  START  TIME  COMMAND

# View process tree
pstree

# Find process by name
pgrep nginx
pgrep -l python3              # show name too

# Live process monitor
top                           # built-in (press q to quit)
htop                          # better version (sudo apt install htop)

# Inside htop:
# F6 = sort by column
# F9 = kill process
# F2 = settings
# q  = quit

# Kill a process
kill 1234                     # send SIGTERM (graceful shutdown)
kill -9 1234                  # send SIGKILL (force kill, no cleanup)
killall nginx                 # kill all processes named nginx
pkill -f "python app.py"      # kill by matching command string

# Process priority (nice value: -20 = highest, 19 = lowest)
nice -n 10 ./script.sh        # start script with lower priority
renice 10 -p 1234             # change priority of running process
```

---

### 3.2 Disk & Storage

```bash
# Disk space usage
df -h                         # all mounted filesystems
df -h /                       # only root partition

# Directory size
du -sh /var/log               # size of /var/log folder
du -sh /var/log/*             # size of each item inside
du -sh /* 2>/dev/null | sort -rh | head -10   # top 10 largest directories

# List block devices (disks and partitions)
lsblk
lsblk -f                      # show filesystem type

# Detailed disk info
sudo fdisk -l

# Mount a USB drive
sudo mount /dev/sdb1 /mnt/usb
ls /mnt/usb

# Unmount
sudo umount /mnt/usb

# View mounted filesystems
mount | column -t
cat /etc/fstab                # filesystems that mount automatically at boot

# Symbolic links
ln -s /var/log/myapp/app.log ~/app.log    # create symlink in home
ls -la ~/app.log                          # shows -> pointing to real file
```

---

### 3.3 Systemd & Services

**Systemd** is the init system — it is PID 1, the first process that starts when Linux boots, and it manages all other services.

```bash
# Control a service
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx         # reload config without full restart

# Enable/disable on boot
sudo systemctl enable nginx         # start automatically on boot
sudo systemctl disable nginx        # do not start on boot
sudo systemctl enable --now nginx   # enable AND start right now

# Check status
systemctl status nginx
systemctl is-active nginx           # prints: active or inactive
systemctl is-enabled nginx          # prints: enabled or disabled

# List services
systemctl list-units --type=service
systemctl list-units --type=service --state=failed

# View logs for a service
journalctl -u nginx                 # all logs
journalctl -u nginx -f              # follow live
journalctl -u nginx -n 50           # last 50 lines
journalctl -u nginx --since "1 hour ago"
journalctl -u nginx -p err          # errors only
journalctl -b                       # all logs since last boot
```

#### Writing your own service file

```bash
sudo nano /etc/systemd/system/myapp.service
```

```ini
[Unit]
Description=My FastAPI Application
After=network.target

[Service]
Type=simple
User=aniket
WorkingDirectory=/home/aniket/myapp
ExecStart=/home/aniket/myapp/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

```bash
# After creating or editing a service file always run:
sudo systemctl daemon-reload
sudo systemctl enable --now myapp
sudo systemctl status myapp
```

---

### 3.4 Networking Basics

```bash
# View network interfaces and IPs
ip addr
ip addr show eth0

# View routing table
ip route

# Test connectivity
ping google.com
ping -c 4 google.com           # only 4 packets then stop

# Trace network path
traceroute google.com
mtr google.com                 # live traceroute (install: sudo apt install mtr)

# DNS lookup
nslookup google.com
dig google.com
dig google.com +short          # only IP address

# Check what is listening on ports
ss -tulnp
ss -tulnp | grep :8000         # is port 8000 in use?

# Download files
wget https://example.com/file.zip
curl -O https://example.com/file.zip
curl https://api.example.com/health

# /etc/hosts — local DNS override
sudo nano /etc/hosts
# Add: 127.0.0.1   myapp.local
```

---

### 3.5 SSH & Remote Access

**SSH** (Secure Shell) lets you connect to and control another Linux machine over the network securely.

```bash
# Connect to remote server
ssh username@server_ip
ssh aniket@192.168.1.100

# Connect on a custom port
ssh -p 2222 aniket@192.168.1.100

# Generate SSH key pair (do this once)
ssh-keygen -t ed25519 -C "aniket@work"
# Creates two files:
# ~/.ssh/id_ed25519       (private key — NEVER share this)
# ~/.ssh/id_ed25519.pub   (public key — share this with servers)

# Copy your public key to a server (so you don't need password)
ssh-copy-id aniket@192.168.1.100

# Fix permissions (SSH requires this)
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519

# SSH config file — create shortcuts
nano ~/.ssh/config
```

```
Host myserver
    HostName 192.168.1.100
    User aniket
    IdentityFile ~/.ssh/id_ed25519
    Port 22
```

```bash
# Now connect with just:
ssh myserver

# Copy files to/from server
scp file.txt aniket@192.168.1.100:/home/aniket/
scp aniket@192.168.1.100:/home/aniket/file.txt ./

# rsync — smarter copy (only transfers changes)
rsync -avz ./myapp/ aniket@192.168.1.100:/var/www/myapp/
```

---

### 3.6 Phase 3 Practice Tasks

- [ ] Find the top 5 CPU-consuming processes using `ps aux` and sort
- [ ] Check disk usage, find the largest directory under `/var`
- [ ] Install nginx, start it, enable it on boot, verify it is running
- [ ] Write a systemd service for a simple bash script and run it
- [ ] Set up SSH key authentication to your Linux Mint laptop from another machine
- [ ] Use `rsync` to sync a folder from one location to another

---

## ⚡ Phase 4 — Networking & Security (Weeks 9–11)

> **Goal:** Configure a firewall, read logs, and troubleshoot network issues like a sysadmin.

---

### 4.1 Firewall with UFW

**UFW** (Uncomplicated Firewall) is the beginner-friendly way to manage firewall rules on Ubuntu/Mint.

```bash
# Install
sudo apt install ufw

# Set default policies (deny all incoming, allow all outgoing)
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow specific ports
sudo ufw allow 22              # SSH
sudo ufw allow 80              # HTTP
sudo ufw allow 443             # HTTPS
sudo ufw allow 8000            # custom app port

# Allow specific port and protocol
sudo ufw allow 5432/tcp        # PostgreSQL

# Allow from specific IP only
sudo ufw allow from 192.168.1.10 to any port 22

# Allow entire subnet
sudo ufw allow from 192.168.1.0/24

# Deny specific IP
sudo ufw deny from 203.0.113.100

# Enable firewall
sudo ufw enable

# Check status
sudo ufw status
sudo ufw status verbose
sudo ufw status numbered       # shows rule numbers

# Delete a rule by number
sudo ufw delete 3

# Disable firewall
sudo ufw disable

# Reset all rules
sudo ufw reset
```

---

### 4.2 File Security & Encryption

```bash
# Check SUID files (files that run as their owner)
find / -perm -4000 2>/dev/null

# Sticky bit on directory (only owner can delete their own files)
chmod +t /shared/folder
ls -la /tmp                   # you will see t at end: drwxrwxrwt

# GPG encryption
sudo apt install gnupg

# Generate key pair
gpg --gen-key

# Encrypt a file
gpg -e -r "Aniket" secret.txt
# Creates secret.txt.gpg

# Decrypt a file
gpg -d secret.txt.gpg > secret.txt

# Create a password-based encrypted file (no key needed)
gpg -c secret.txt

# Hash a file (verify integrity)
sha256sum file.txt
md5sum file.txt

# Compare hashes of two files
sha256sum file1.txt file2.txt
```

---

### 4.3 Logs & Monitoring

```bash
# Important log locations
/var/log/syslog          # general system messages
/var/log/auth.log        # SSH logins, sudo, authentication
/var/log/kern.log        # kernel messages
/var/log/dmesg           # boot and hardware messages
/var/log/apt/history.log # software install/remove history

# View logs
cat /var/log/auth.log
tail -f /var/log/syslog                       # follow live
grep "Failed password" /var/log/auth.log      # failed SSH logins

# Find top IPs brute-forcing SSH
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -rn | head -10

# journalctl
journalctl                             # all logs
journalctl -b                          # since last boot
journalctl -f                          # follow live
journalctl -p err                      # errors only
journalctl --since "2 hours ago"
journalctl --since "2024-01-01" --until "2024-01-02"
journalctl -u nginx -f                 # follow specific service
```

#### logrotate — prevent logs from filling disk

```bash
# Config location
cat /etc/logrotate.conf
ls /etc/logrotate.d/

# Example custom config
sudo nano /etc/logrotate.d/myapp
```

```
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    create 0640 aniket aniket
}
```

---

### 4.4 Network Troubleshooting

```bash
# Check open ports on your machine
ss -tulnp

# Check open ports on a remote machine
nmap -sV 192.168.1.100
nmap -p 22,80,443 192.168.1.100

# Test if a specific port is open
nc -zv google.com 443
nc -zv localhost 8000

# Capture live network traffic
sudo tcpdump -i eth0
sudo tcpdump -i eth0 port 8000
sudo tcpdump -i eth0 host 192.168.1.1
sudo tcpdump -i eth0 -w capture.pcap         # save to file

# Which process is using a port
sudo lsof -i :8000
sudo fuser 8000/tcp
```

---

### 4.5 Server Hardening Basics

```bash
# 1. Edit SSH config
sudo nano /etc/ssh/sshd_config

# Change or add these lines:
PermitRootLogin no
PasswordAuthentication no
MaxAuthTries 3
Port 2222

# Restart SSH after changes
sudo systemctl restart sshd

# 2. Install fail2ban (auto-bans IPs after failed logins)
sudo apt install fail2ban
sudo systemctl enable --now fail2ban
sudo fail2ban-client status
sudo fail2ban-client status sshd

# 3. Auto security updates
sudo apt install unattended-upgrades
sudo dpkg-reconfigure unattended-upgrades

# 4. Check for users with empty passwords
sudo awk -F: '($2 == "") {print $1}' /etc/shadow
```

---

### 4.6 Phase 4 Practice Tasks

- [ ] Set up UFW — allow only SSH, HTTP, HTTPS. Deny everything else
- [ ] Find all failed SSH login attempts in `auth.log` from last 24 hours
- [ ] Install fail2ban and verify it is protecting SSH
- [ ] Use `tcpdump` to capture traffic on port 8000 while making a curl request
- [ ] Harden SSH — disable password auth, disable root login, restart and verify

---

## ⚡ Phase 5 — Advanced Topics (Weeks 12–16)

> **Goal:** Understand Docker internals, automate with cron and Ansible, tune performance, and understand the Linux boot process.

---

### 5.1 Advanced Bash Scripting

#### Regular expressions

```bash
# Basic regex with grep
grep -E "^[0-9]{3}-[0-9]{4}$" phones.txt     # match phone numbers
grep -E "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" file.txt  # email

# Regex special characters:
.       # any single character
*       # zero or more of previous
+       # one or more of previous
?       # zero or one of previous
^       # start of line
$       # end of line
[abc]   # character class (a or b or c)
[0-9]   # any digit
[a-z]   # any lowercase letter
{3}     # exactly 3 of previous
{2,5}   # between 2 and 5 of previous
\d      # digit (in -P mode)
\w      # word character
```

#### Advanced script patterns

```bash
#!/bin/bash
set -euo pipefail

# Logging function with levels
log() {
    local LEVEL=$1
    local MESSAGE=$2
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$LEVEL] $MESSAGE"
}

# Retry function
retry() {
    local MAX=$1
    local DELAY=$2
    shift 2
    local CMD="$@"

    for i in $(seq 1 $MAX); do
        $CMD && return 0
        log "WARN" "Attempt $i/$MAX failed. Retrying in ${DELAY}s..."
        sleep $DELAY
    done
    log "ERROR" "All $MAX attempts failed"
    return 1
}

# Usage
retry 3 5 curl -s https://api.example.com/health

# Script lock (prevent multiple instances)
LOCKFILE="/tmp/$(basename $0).lock"
if [ -f "$LOCKFILE" ]; then
    log "ERROR" "Script already running (lockfile: $LOCKFILE)"
    exit 1
fi
touch "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT
```

---

### 5.2 Kernel & Boot Process

```
BIOS/UEFI
    ↓
GRUB (bootloader) — lets you choose OS
    ↓
Kernel loads — decompresses, initializes hardware
    ↓
initramfs — temporary filesystem, mounts real root
    ↓
systemd (PID 1) starts
    ↓
Targets run — mounts filesystems, starts services
    ↓
Login prompt
```

```bash
# View kernel version
uname -r
uname -a                      # all info

# View boot messages
dmesg
dmesg | grep -i error
dmesg | grep -i usb           # USB device events

# Kernel modules
lsmod                         # list loaded modules
modinfo nvidia                # info about a module
sudo modprobe module_name     # load a module
sudo rmmod module_name        # remove a module

# GRUB config
cat /etc/default/grub
sudo update-grub              # apply changes to grub

# /proc — live kernel info
cat /proc/cpuinfo             # CPU details
cat /proc/meminfo             # memory details
cat /proc/uptime              # system uptime in seconds
cat /proc/loadavg             # load average
ls /proc/1234/                # everything about process 1234
```

---

### 5.3 Containers & Docker

```bash
# Install Docker on Ubuntu/Mint
sudo apt update
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER    # use docker without sudo (relogin after)

# Basic Docker commands
docker pull ubuntu               # download image
docker images                    # list local images
docker ps                        # running containers
docker ps -a                     # all containers including stopped

# Run a container
docker run ubuntu echo "hello"
docker run -it ubuntu bash       # interactive terminal
docker run -d nginx              # detached (background)
docker run -d -p 8080:80 nginx   # map host port 8080 to container port 80
docker run --name mycontainer -d nginx

# Manage containers
docker stop mycontainer
docker start mycontainer
docker restart mycontainer
docker rm mycontainer
docker rm -f mycontainer         # force remove running container

# Logs
docker logs mycontainer
docker logs mycontainer -f       # follow
docker logs mycontainer --tail 50

# Execute command inside running container
docker exec -it mycontainer bash
docker exec mycontainer ls /app

# Copy files
docker cp file.txt mycontainer:/app/
docker cp mycontainer:/app/file.txt ./
```

#### Dockerfile

```dockerfile
# Dockerfile — instructions to build a custom image
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd -m appuser
USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

```bash
# Build image from Dockerfile
docker build -t myapp:latest .
docker build -t myapp:v1.0 .

# Run your custom image
docker run -d -p 8000:8000 myapp:latest
```

#### Docker Compose

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
      - db
    restart: unless-stopped

  db:
    image: postgres:15
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - pgdata:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  pgdata:
```

```bash
docker compose up -d             # start all services
docker compose down              # stop all services
docker compose logs -f api       # follow logs for api service
docker compose ps                # status of all services
docker compose restart api       # restart one service
```

---

### 5.4 Automation — Cron & Ansible

#### Cron — schedule tasks

```bash
# Edit cron jobs for current user
crontab -e

# List cron jobs
crontab -l

# Remove all cron jobs
crontab -r
```

#### Cron syntax

```
* * * * * command
│ │ │ │ └── day of week (0-7, 0 and 7 = Sunday)
│ │ │ └──── month (1-12)
│ │ └────── day of month (1-31)
│ └──────── hour (0-23)
└────────── minute (0-59)
```

#### Cron examples

```bash
# Every minute
* * * * * /home/aniket/scripts/check.sh

# Every day at 2am
0 2 * * * /home/aniket/scripts/backup.sh

# Every Monday at 9am
0 9 * * 1 /home/aniket/scripts/weekly-report.sh

# Every hour
0 * * * * /home/aniket/scripts/monitor.sh

# Every 5 minutes
*/5 * * * * /home/aniket/scripts/ping-check.sh

# First day of every month at midnight
0 0 1 * * /home/aniket/scripts/monthly-cleanup.sh

# Redirect cron output to log
0 2 * * * /home/aniket/scripts/backup.sh >> /var/log/backup.log 2>&1
```

#### Ansible basics

```bash
# Install Ansible
sudo apt install ansible

# Inventory file — list of servers to manage
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
# Test connectivity
ansible all -i inventory.ini -m ping

# Run a command on all servers
ansible all -i inventory.ini -m command -a "uptime"

# Simple playbook
nano setup.yml
```

```yaml
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

    - name: Start nginx
      systemd:
        name: nginx
        state: started
        enabled: yes
```

```bash
# Run playbook
ansible-playbook -i inventory.ini setup.yml
```

---

### 5.5 Performance Tuning

```bash
# CPU info
nproc                         # number of CPU cores
lscpu                         # detailed CPU info
uptime                        # load average (should be < number of cores)

# Memory
free -h                       # RAM and swap usage
cat /proc/meminfo
vmstat 1 5                    # virtual memory stats every 1s, 5 times

# Disk I/O
iostat -x 1                   # extended I/O stats every second
sudo iotop                    # per-process I/O (like htop for disk)

# Network
ip -s link                    # network interface stats
ss -s                         # socket summary

# System calls — what is a process actually doing?
strace -p 1234                # attach to running process
strace ls                     # trace ls command
strace -c ls                  # summary of syscall counts

# Find what files a process has open
lsof -p 1234
lsof -i :8000                 # what is using port 8000
```

---

### 5.6 Storage — Advanced

```bash
# LVM — Logical Volume Manager (flexible disk management)

# Physical Volume
sudo pvcreate /dev/sdb
sudo pvdisplay

# Volume Group
sudo vgcreate myvg /dev/sdb
sudo vgdisplay

# Logical Volume
sudo lvcreate -L 10G -n mylv myvg
sudo lvdisplay

# Format and mount
sudo mkfs.ext4 /dev/myvg/mylv
sudo mount /dev/myvg/mylv /mnt/data

# Extend a logical volume
sudo lvextend -L +5G /dev/myvg/mylv
sudo resize2fs /dev/myvg/mylv   # resize filesystem after extending

# NFS — share folders over network
sudo apt install nfs-kernel-server

# Export a folder
sudo nano /etc/exports
# Add: /home/aniket/shared 192.168.1.0/24(rw,sync,no_subtree_check)

sudo exportfs -a
sudo systemctl restart nfs-kernel-server

# Mount NFS from another machine
sudo mount 192.168.1.100:/home/aniket/shared /mnt/nfs
```

---

### 5.7 Phase 5 Practice Tasks

- [ ] Write a bash script with retry logic that pings a server 3 times before giving up
- [ ] Set up a cron job that runs a disk usage check every day at 8am and logs to a file
- [ ] Dockerize a simple Python/FastAPI app and run it with docker-compose
- [ ] Write an Ansible playbook to install and start nginx on a target machine
- [ ] Use `strace` to trace what files are opened when you run `cat /etc/hosts`

---

## ⚡ Phase 6 — Projects & Practice (Ongoing)

> **Goal:** Apply everything learned by building real, useful projects.

---

### Beginner Projects

- [ ] **System info script** — prints hostname, IP, uptime, RAM, disk usage in a clean format
- [ ] **Backup script** — compresses a folder to `.tar.gz` with date in filename, keeps last 7 only
- [ ] **User creation script** — takes username as argument, creates user, sets password, adds to group

### Intermediate Projects

- [ ] **LAMP stack setup** — Apache/Nginx + MySQL + PHP installed and configured from scratch
- [ ] **Log parser** — reads nginx access log, counts requests per IP, outputs top 10
- [ ] **Disk monitor with alert** — cron job that emails/logs alert when any partition exceeds 80%
- [ ] **SSH hardening script** — automates all SSH hardening steps on a fresh server

### Advanced Projects

- [ ] **Full server provisioning script** — one script that takes a fresh Ubuntu install to production-ready (user, SSH, UFW, fail2ban, updates)
- [ ] **Docker + Nginx reverse proxy** — FastAPI app behind Nginx inside Docker Compose
- [ ] **Ansible playbook** — provision, harden, and deploy an app on a remote server
- [ ] **Prometheus + Grafana** — set up monitoring stack to observe a Linux server
- [ ] **LVM snapshot workflow** — take snapshot before deployment, restore if it fails

---

## 📋 Cheatsheets

### Most Used Commands

```bash
# Navigation
pwd && ls -la && cd /path && cd ~ && cd .. && cd -

# Files
touch f.txt && cat f.txt && less f.txt && head -n5 f.txt && tail -f f.txt

# Copy/Move/Delete
cp -r src/ dst/ && mv old new && rm -rf folder/

# Search
grep -r "word" /path && find / -name "*.log" && locate file

# Permissions
chmod 755 file && chown user:group file && ls -la

# Processes
ps aux && htop && kill -9 PID && pkill name

# Disk
df -h && du -sh /* && lsblk

# Network
ip addr && ss -tulnp && ping host && curl -I url

# Services
sudo systemctl start/stop/restart/status/enable/disable service

# Logs
journalctl -u service -f && tail -f /var/log/syslog

# Package
sudo apt update && sudo apt install pkg && sudo apt remove pkg
```

### Permission Quick Reference

| Octal | Symbolic | Meaning |
|-------|----------|---------|
| 777 | rwxrwxrwx | Everyone full access |
| 755 | rwxr-xr-x | Owner full, others read+execute |
| 644 | rw-r--r-- | Owner read+write, others read only |
| 600 | rw------- | Owner read+write only (private files) |
| 700 | rwx------ | Owner full access only (private dirs) |

---

## ✅ Milestone Checklist

- [ ] Phase 1 — Can navigate filesystem and manage files entirely from terminal
- [ ] Phase 2 — Can write a working bash script and use pipes and grep confidently
- [ ] Phase 3 — Can manage services, users, disks, and SSH into a remote server
- [ ] Phase 4 — Can configure a firewall, read logs, and troubleshoot network issues
- [ ] Phase 5 — Can set up Docker, write cron jobs, and understand the boot process
- [ ] Phase 6 — Can provision, secure, deploy, and monitor a Linux server from scratch

---

## 🔗 Resources

| Resource | What it covers |
|----------|---------------|
| [linuxjourney.com](https://linuxjourney.com) | Interactive beginner lessons |
| [overthewire.org/bandit](https://overthewire.org/wargames/bandit) | Terminal challenges as a game |
| [tldr.sh](https://tldr.sh) | Short practical command examples |
| [explainshell.com](https://explainshell.com) | Break down any command visually |
| [linuxupskillchallenge.org](https://linuxupskillchallenge.org) | 20-day guided sysadmin course |
| [The Linux Command Line — free PDF](http://linuxcommand.org/tlcl.php) | Best beginner book, completely free |
| [LFS101 on edX](https://www.edx.org/course/introduction-to-linux) | Linux Foundation free course |

---

<p align="center">
  <img src="https://img.shields.io/badge/Started-2026-blue" />
  <img src="https://img.shields.io/badge/Status-Active-brightgreen" />
  <img src="https://img.shields.io/badge/Made%20with-curiosity%20%26%20caffeine-orange" />
</p>