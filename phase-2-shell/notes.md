# 📖 Phase 2 — Shell Mastery: Working Faster

> **Goal:** Write working bash scripts and use pipes, redirection, and text processing tools confidently.

---

## 2.1 What is a Shell?

The **shell** is the program that reads your commands and runs them.

```
You type → Shell reads → Kernel executes → Output returns
```

| Shell | Notes |
|-------|-------|
| `bash` | Default on most Linux distros |
| `zsh` | Popular alternative, more features |
| `sh` | Older, basic, available everywhere |

```bash
echo $SHELL         # which shell are you using?
bash --version      # bash version
```

---

## 2.2 Essential Shell Shortcuts

| Shortcut | Action |
|----------|--------|
| `Tab` | Auto-complete command or filename |
| `Tab Tab` | Show all possible completions |
| `↑ ↓` | Navigate command history |
| `Ctrl+R` | Search command history |
| `Ctrl+C` | Cancel running command |
| `Ctrl+Z` | Suspend running command |
| `Ctrl+L` | Clear screen |
| `Ctrl+A` | Move to start of line |
| `Ctrl+E` | Move to end of line |
| `!!` | Repeat last command |
| `sudo !!` | Repeat last command with sudo |

```bash
history             # view command history
!42                 # run command number 42 from history
!ls                 # run last command starting with ls
history -c          # clear history
```

---

## 2.3 I/O Redirection & Pipes

### Standard Streams

| Stream | Number | Default |
|--------|--------|---------|
| `stdin` | 0 | Keyboard input |
| `stdout` | 1 | Terminal output |
| `stderr` | 2 | Terminal error output |

### Redirecting Output

```bash
ls -la > filelist.txt           # save output to file (overwrite)
echo "new line" >> notes.txt    # append to file (don't overwrite)
ls /fakefolder 2> errors.txt    # redirect errors to file
ls -la 2>&1 > output.txt        # redirect both stdout and stderr
command > /dev/null             # discard output
command 2> /dev/null            # discard errors
command > /dev/null 2>&1        # discard everything
```

### Pipes

The `|` (pipe) sends output of one command as input to the next.

```bash
ls -la | grep ".txt"                        # list files, filter .txt
ps aux | grep python                        # find python processes
cat file.txt | wc -l                        # count lines in file
cat file.txt | sort | uniq | head -10       # sort, dedupe, show top 10
du -sh /* 2>/dev/null | sort -rh | head -10 # top 10 largest directories
```

---

## 2.4 Text Processing Tools

### `grep` — Search for Patterns

```bash
grep "error" logfile.txt                    # find lines with "error"
grep -i "error" logfile.txt                 # case insensitive
grep -n "error" logfile.txt                 # show line numbers
grep -r "error" /var/log/                   # search recursively
grep -v "error" logfile.txt                 # lines NOT matching
grep -c "error" logfile.txt                 # count matching lines
grep -l "error" /var/log/*.log              # only show filenames
grep "^error" logfile.txt                   # lines starting with error
grep "error$" logfile.txt                   # lines ending with error
grep -E "error|warning|critical" logfile.txt # match multiple patterns

# Grep with colour (add to ~/.bashrc)
alias grep='grep --color=auto'
```

### `grep -P` — Perl Regex (Powerful)

```bash
grep -P "\d{3}-\d{4}" contacts.txt         # match phone numbers
grep -P "^\d+\.\d+\.\d+\.\d+" access.log   # match IP addresses
grep -P "(?<=user=)\w+" logfile.txt         # lookbehind — get username after user=
grep -oP "\d+\.\d+\.\d+\.\d+" access.log   # extract IPs only (-o = only match)
```

### `sed` — Find and Replace

```bash
sed 's/old/new/' file.txt                   # replace first per line
sed 's/old/new/g' file.txt                  # replace all
sed -i 's/old/new/g' file.txt               # replace in-place (modifies file)
sed '/error/d' file.txt                     # delete lines with "error"
sed -n '5,10p' file.txt                     # print only lines 5 to 10
sed '3a\This is new line' file.txt          # add line after line 3
sed '1d' file.txt                           # delete first line
sed 's/^/PREFIX: /' file.txt               # add prefix to every line
sed 's/$/ SUFFIX/' file.txt                # add suffix to every line
```

### `awk` — Column Processing

```bash
awk '{print $1}' file.txt                   # print first column
awk '{print $2, $3}' file.txt               # print 2nd and 3rd column
awk -F',' '{print $1}' data.csv             # use comma as delimiter
awk '$3 > 100' data.txt                     # print rows where col 3 > 100
awk 'NR==1' file.txt                        # print first line only
awk 'END {print NR}' file.txt               # print total line count
awk '{sum += $1} END {print sum}' nums.txt  # sum a column
awk '{print NR": "$0}' file.txt             # add line numbers
awk -F':' '{print $1}' /etc/passwd          # extract usernames
```

### Other Text Tools

```bash
sort file.txt                   # sort alphabetically
sort -r file.txt                # reverse sort
sort -n numbers.txt             # numeric sort
sort -u file.txt                # sort + remove duplicates
sort -k2 file.txt               # sort by 2nd column

uniq file.txt                   # remove consecutive duplicates
uniq -c file.txt                # count occurrences
uniq -d file.txt                # show only duplicates

cut -d',' -f1 data.csv          # first field, comma delimiter
cut -c1-10 file.txt             # first 10 characters per line

tr 'a-z' 'A-Z' < file.txt      # lowercase to uppercase
tr -d '\n' < file.txt           # remove newlines
tr -s ' ' < file.txt            # squeeze multiple spaces to one

diff file1.txt file2.txt        # show differences
diff -u file1.txt file2.txt     # unified diff format (like git diff)

wc file.txt                     # lines, words, bytes
wc -l file.txt                  # lines only
wc -w file.txt                  # words only
```

### `jq` — JSON Processing from Terminal

```bash
sudo apt install jq

# Parse JSON output
curl -s https://api.github.com/users/aniket | jq '.'            # pretty print
curl -s https://api.github.com/users/aniket | jq '.name'        # get field
curl -s https://api.example.com/data | jq '.items[0]'           # first item
curl -s https://api.example.com/data | jq '.items[] | .name'    # all names
curl -s https://api.example.com/data | jq 'length'              # array length

# Filter and transform
echo '{"name":"aniket","age":25}' | jq '{username: .name}'
cat data.json | jq '.[] | select(.status == "active")'
cat data.json | jq '[.[] | {name: .name, id: .id}]'
```

> 💡 `jq` is essential for anyone working with APIs and AI services — you will use it constantly

---

## 2.5 Finding Files

```bash
# find — most powerful
find /home -name "notes.txt"                    # by name
find /home -name "*.txt"                        # all .txt files
find /var/log -name "*.log" -type f             # files only, not dirs
find / -name "*.conf" 2>/dev/null               # suppress permission errors
find /home -size +10M                           # larger than 10MB
find /tmp -mtime +7                             # older than 7 days
find /home -user aniket                         # owned by aniket
find . -name "*.py" -exec grep "import os" {} \;  # find and search inside

# locate — faster (uses database)
sudo updatedb                                   # update database first
locate notes.txt

# which, whereis — find commands
which python3
whereis nginx
type ls                                         # shows if alias or binary
```

---

## 2.6 Environment Variables & Shell Config

```bash
env                             # view all environment variables
printenv HOME                   # view specific variable
echo $PATH                      # print PATH

# Set variable (current session only)
MY_NAME="Aniket"
echo $MY_NAME

# Export so child processes can access it
export APP_ENV="production"

# Remove variable
unset MY_NAME
```

### Important Built-in Variables

| Variable | What it holds |
|----------|--------------|
| `$HOME` | Your home directory |
| `$USER` | Your username |
| `$SHELL` | Path to your shell |
| `$PATH` | Directories searched for commands |
| `$PWD` | Current directory |
| `$?` | Exit code of last command (0=success) |
| `$$` | PID of current shell |
| `$EDITOR` | Default text editor |

### Shell Config Files

```bash
~/.bashrc           # runs every time you open a new terminal
~/.bash_profile     # runs once at login
~/.profile          # login fallback
/etc/profile        # system-wide for all users
/etc/bash.bashrc    # system-wide bashrc

# Apply changes without restarting terminal
source ~/.bashrc
```

### Aliases

```bash
# Add these to ~/.bashrc
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias update='sudo apt update && sudo apt upgrade'
alias ports='ss -tulnp'
alias myip='curl -s ifconfig.me'
alias freq='history | awk "{print \$2}" | sort | uniq -c | sort -rn | head -20'

# Apply
source ~/.bashrc

# View all aliases
alias
```

---

## 2.7 Bash Scripting — From Zero

### Your First Script

```bash
# Step 1: Create file
nano hello.sh

# Step 2: Write inside
#!/bin/bash
echo "Hello, Aniket!"
echo "Today: $(date)"
echo "You are in: $(pwd)"

# Step 3: Make executable
chmod +x hello.sh

# Step 4: Run
./hello.sh
```

> 💡 `#!/bin/bash` is the **shebang** — tells Linux which interpreter to use. Always put on line 1.

### Variables

```bash
#!/bin/bash
NAME="Aniket"
AGE=25
CURRENT_DATE=$(date +%Y-%m-%d)     # store command output
readonly MAX=100                    # read-only variable

echo "My name is ${NAME}"          # always use curly braces
echo "I am ${AGE} years old"
echo "Today: ${CURRENT_DATE}"
```

### User Input

```bash
read -p "Enter your name: " USERNAME
read -sp "Enter password: " PASSWORD   # -s = silent
echo ""
read -t 10 -p "Continue? (y/n): " CONFIRM   # timeout after 10s
```

### Conditionals

```bash
# Numeric comparisons
-eq   # equal
-ne   # not equal
-gt   # greater than
-lt   # less than
-ge   # greater than or equal
-le   # less than or equal

# String comparisons
==    # equal
!=    # not equal
-z    # empty string
-n    # not empty string

# File checks
-f    # is a regular file
-d    # is a directory
-e    # exists
-r    # readable
-w    # writable
-x    # executable
```

```bash
#!/bin/bash
AGE=20
FILE="/etc/nginx/nginx.conf"
ENV="production"

# Numeric
if [ $AGE -ge 18 ]; then
    echo "Adult"
elif [ $AGE -lt 13 ]; then
    echo "Child"
else
    echo "Teenager"
fi

# File check
if [ -f "$FILE" ]; then
    echo "File exists"
fi

# String check
if [ -z "$ENV" ]; then
    echo "ENV is empty"
fi

if [ "$ENV" == "production" ]; then
    echo "Production mode"
fi
```

### Loops

```bash
# For — list
for FRUIT in apple banana mango; do
    echo "Fruit: $FRUIT"
done

# For — range
for i in {1..5}; do
    echo "Number: $i"
done

# For — files
for FILE in /var/log/*.log; do
    echo "Processing: $FILE"
done

# While
COUNTER=1
while [ $COUNTER -le 5 ]; do
    echo "Count: $COUNTER"
    ((COUNTER++))
done

# Loop control
for i in {1..10}; do
    if [ $i -eq 5 ]; then continue; fi
    if [ $i -eq 8 ]; then break; fi
    echo $i
done
```

### Functions

```bash
#!/bin/bash

# Basic function
greet() {
    local NAME=$1       # local = only exists inside function
    local AGE=$2
    echo "Hi ${NAME}, you are ${AGE} years old"
}

# Function that returns a value
add() {
    local RESULT=$(( $1 + $2 ))
    echo $RESULT        # use echo to "return" values
}

# Logging functions (use in all scripts)
log_info()  { echo "[INFO]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_warn()  { echo "[WARN]  $(date '+%Y-%m-%d %H:%M:%S') — $1"; }
log_error() { echo "[ERROR] $(date '+%Y-%m-%d %H:%M:%S') — $1" >&2; exit 1; }

# Call functions
greet "Aniket" 25
TOTAL=$(add 10 20)
echo "Total: $TOTAL"
log_info "Script started"
```

### Script Arguments

```bash
#!/bin/bash
# Run as: ./script.sh hello world 123
echo "Script: $0"       # ./script.sh
echo "Arg 1:  $1"       # hello
echo "Arg 2:  $2"       # world
echo "All:    $@"       # hello world 123
echo "Count:  $#"       # 3

# Always validate arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi
```

### Error Handling — Best Practices

```bash
#!/bin/bash

# These 3 lines should be at the top of every production script
set -e          # exit immediately if any command fails
set -u          # exit if undefined variable is used
set -o pipefail # catch errors inside pipes

# Shorthand for all three
set -euo pipefail

# Cleanup on exit
cleanup() {
    echo "Cleaning up..."
    rm -f /tmp/lockfile
}
trap cleanup EXIT

# Trap errors
handle_error() {
    echo "Error on line $1"
    exit 1
}
trap 'handle_error $LINENO' ERR

# Safe command execution
cp file.txt /backup/ || { echo "Copy failed!"; exit 1; }
```

### Retry Logic

```bash
retry() {
    local MAX=$1
    local DELAY=$2
    shift 2
    for i in $(seq 1 $MAX); do
        "$@" && return 0
        echo "Attempt $i/$MAX failed. Retrying in ${DELAY}s..."
        sleep $DELAY
    done
    echo "All $MAX attempts failed"
    return 1
}

# Usage
retry 3 5 curl -s https://api.example.com/health
```

### Script Locking (prevent duplicate runs)

```bash
LOCKFILE="/tmp/$(basename $0).lock"
if [ -f "$LOCKFILE" ]; then
    echo "Script already running"
    exit 1
fi
touch "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT
```

### Getopts — Argument Flags

```bash
#!/bin/bash
while getopts "e:p:vh" opt; do
    case $opt in
        e) ENV="$OPTARG" ;;
        p) PORT="$OPTARG" ;;
        v) VERBOSE=true ;;
        h) echo "Usage: $0 -e <env> -p <port> [-v]"; exit 0 ;;
        ?) echo "Invalid option"; exit 1 ;;
    esac
done

# Run as: ./deploy.sh -e production -p 8000 -v
```

### Arrays

```bash
# Indexed array
SERVERS=("server1" "server2" "server3")
echo "${SERVERS[0]}"            # first element
echo "${SERVERS[@]}"            # all elements
echo "${#SERVERS[@]}"           # length

# Associative array
declare -A CONFIG
CONFIG["host"]="localhost"
CONFIG["port"]="5432"
echo "${CONFIG["host"]}"

# Loop over array
for SERVER in "${SERVERS[@]}"; do
    echo "Pinging $SERVER"
done
```

### Heredoc

```bash
# Write multiline content to a file
cat << EOF > /etc/myapp/config.yml
app:
  name: myapp
  env: ${APP_ENV}
  port: 8000
EOF

# Run multiple commands on remote server over SSH
ssh user@server << 'EOF'
cd /var/www/myapp
git pull origin main
systemctl restart myapp
EOF
```

### Debugging Scripts

```bash
bash -x script.sh       # trace every command as it runs
bash -n script.sh       # syntax check only, don't run
set -x                  # enable trace inside script
set +x                  # disable trace
```

---

## 2.8 Job Control

```bash
./script.sh &           # run in background
jobs                    # list background jobs
fg %1                   # bring job 1 to foreground
bg %1                   # resume job 1 in background
Ctrl+Z                  # suspend current job
kill %1                 # kill job 1
kill 1234               # kill by PID
kill -9 1234            # force kill (SIGKILL)
```

---

## 2.9 tmux — Terminal Multiplexer

tmux keeps sessions alive even after you disconnect, and lets you split one terminal into multiple panes.

```bash
sudo apt install tmux

tmux                            # start new session
tmux new -s mysession           # named session
tmux ls                         # list sessions
tmux attach -t mysession        # attach to session
tmux kill-session -t mysession  # kill session
```

### tmux Key Bindings (all start with `Ctrl+B`)

| Shortcut | Action |
|----------|--------|
| `Ctrl+B "` | Split horizontally |
| `Ctrl+B %` | Split vertically |
| `Ctrl+B arrow` | Move between panes |
| `Ctrl+B c` | New window |
| `Ctrl+B n` | Next window |
| `Ctrl+B p` | Previous window |
| `Ctrl+B d` | Detach (keeps running) |
| `Ctrl+B [` | Scroll mode (q to quit) |
| `Ctrl+B z` | Zoom pane to fullscreen |

---

## 2.10 curl — Advanced Usage

```bash
# Basic requests
curl https://api.example.com
curl -I https://api.example.com                 # headers only
curl -v https://api.example.com                 # verbose (debug)

# HTTP methods
curl -X POST https://api.example.com/data \
     -H "Content-Type: application/json" \
     -d '{"key": "value"}'

curl -X PUT https://api.example.com/item/1 \
     -H "Authorization: Bearer TOKEN" \
     -d '{"name": "updated"}'

curl -X DELETE https://api.example.com/item/1

# Save output
curl -o output.json https://api.example.com
curl -O https://example.com/file.zip           # save with original filename

# Follow redirects
curl -L https://example.com

# Retry on failure
curl --retry 3 --retry-delay 2 https://api.example.com

# Timeout
curl --max-time 10 https://api.example.com

# Send file
curl -F "file=@/path/to/file.pdf" https://upload.example.com

# Basic auth
curl -u username:password https://api.example.com

# Bearer token
curl -H "Authorization: Bearer your_token" https://api.example.com

# Silent (no progress)
curl -s https://api.example.com | jq '.'
```

---

## ✅ Phase 2 Practice Tasks

- [ ] Write a script that takes a filename as argument and counts its lines
- [ ] Use `grep -P` to extract all IP addresses from `/var/log/auth.log`
- [ ] Write a backup script — creates `.tar.gz` with today's date in filename
- [ ] Use `jq` to parse JSON from a real API (try GitHub API)
- [ ] Create useful aliases in `~/.bashrc`, apply without restarting terminal
- [ ] Open tmux, create 3 panes, run different commands in each
- [ ] Write a script with `set -euo pipefail` and test what happens when a command fails
- [ ] Use `curl` to hit your own FastAPI endpoint from terminal and parse response with `jq`
