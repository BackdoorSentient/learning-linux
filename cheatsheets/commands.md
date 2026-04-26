# 📋 Linux Commands Cheatsheet

> Quick reference for the most used Linux commands

---

## Navigation

```bash
pwd                         # where am I?
ls -la                      # list all files with details
cd /path                    # go to path
cd ~                        # go home
cd ..                       # go up one level
cd -                        # go back to previous directory
tree -L 2                   # visual directory tree (2 levels)
```

## Files & Directories

```bash
touch file.txt              # create empty file
mkdir -p a/b/c              # create nested dirs
cp -r src/ dst/             # copy folder
mv old new                  # move or rename
rm -rf folder/              # delete folder (careful!)
ln -s /real/path ~/link     # create symbolic link
```

## Viewing Files

```bash
cat file.txt                # print file
less file.txt               # scroll (q=quit, /=search)
head -n 20 file.txt         # first 20 lines
tail -n 20 file.txt         # last 20 lines
tail -f /var/log/syslog     # follow file live
```

## Search

```bash
grep -r "word" /path        # search in files recursively
grep -i "word" file         # case insensitive
grep -n "word" file         # show line numbers
grep -v "word" file         # lines NOT matching
grep -oP "\d+\.\d+\.\d+\.\d+" file  # extract IPs (Perl regex)
find / -name "*.log" 2>/dev/null    # find files by name
find / -size +100M 2>/dev/null      # find files > 100MB
locate filename             # fast find (needs updatedb)
which python3               # where is this command?
```

## Text Processing

```bash
sed 's/old/new/g' file      # replace all
awk '{print $1}' file       # print first column
awk -F',' '{print $2}' f    # CSV second column
sort -rn file               # sort numeric reverse
sort -u file                # sort + remove duplicates
uniq -c file                # count occurrences
cut -d',' -f1 file.csv      # cut first CSV field
wc -l file                  # count lines
tr 'a-z' 'A-Z' < file       # uppercase
jq '.field' data.json       # JSON field extraction
jq '.[]|.name' data.json    # all names from array
```

## Permissions

```bash
chmod 755 file              # rwxr-xr-x
chmod 644 file              # rw-r--r--
chmod 600 file              # rw------- (private)
chmod +x script.sh          # add execute
chown user:group file       # change owner
chown -R user:group dir/    # recursive
ls -la                      # view permissions
stat file                   # detailed file info
```

## Process Management

```bash
ps aux                      # all processes
ps aux --sort=-%cpu | head  # top CPU processes
top                         # live monitor (q=quit)
htop                        # better live monitor
kill 1234                   # graceful kill
kill -9 1234                # force kill
pkill -f "python app.py"    # kill by command match
pgrep nginx                 # find PID by name
```

## Disk

```bash
df -h                       # disk space all filesystems
du -sh /var/log             # folder size
du -sh /* 2>/dev/null | sort -rh | head -10  # largest dirs
lsblk                       # list block devices
lsblk -f                    # show filesystems
```

## Networking

```bash
ip addr                     # show IPs
ip route                    # routing table
ss -tulnp                   # listening ports
ping -c 4 google.com        # test connectivity
traceroute google.com       # trace network path
mtr google.com              # live traceroute
dig google.com +short       # DNS lookup
curl -s https://ifconfig.me # my public IP
curl -I https://example.com # HTTP headers
curl -v https://example.com # verbose debug
```

## Services (systemd)

```bash
sudo systemctl start svc    # start
sudo systemctl stop svc     # stop
sudo systemctl restart svc  # restart
sudo systemctl status svc   # status
sudo systemctl enable svc   # enable on boot
sudo systemctl disable svc  # disable on boot
journalctl -u svc -f        # follow logs
journalctl -b -p err        # errors since boot
systemd-analyze blame       # boot time per service
```

## Packages

```bash
sudo apt update             # refresh package list
sudo apt upgrade            # upgrade all
sudo apt install pkg        # install
sudo apt remove pkg         # remove
sudo apt purge pkg          # remove + config
apt search keyword          # search packages
apt show pkg                # package info
sudo apt autoremove         # clean unused
```

## SSH

```bash
ssh user@host               # connect
ssh -p 2222 user@host       # custom port
ssh-keygen -t ed25519       # generate key pair
ssh-copy-id user@host       # copy key to server
scp file.txt user@host:/path    # copy file to server
rsync -avz src/ user@host:/dst/ # sync folder
ssh -L 5433:localhost:5432 user@host  # port forward
```

## Archives

```bash
tar -czf archive.tar.gz folder/    # create compressed archive
tar -xzf archive.tar.gz            # extract
tar -tzf archive.tar.gz            # list contents
zip -r archive.zip folder/         # create zip
unzip archive.zip                  # extract zip
```

## Pipes & Redirection

```bash
cmd > file.txt              # save output (overwrite)
cmd >> file.txt             # save output (append)
cmd 2> error.txt            # save errors
cmd > /dev/null 2>&1        # discard all output
cmd1 | cmd2                 # pipe output to next command
```

## curl

```bash
curl https://url                        # GET request
curl -X POST url -d '{"k":"v"}' -H "Content-Type: application/json"
curl -H "Authorization: Bearer TOKEN" url
curl -o file.zip https://url/file.zip   # download
curl --retry 3 https://url              # retry on fail
curl -s url | jq '.'                    # pretty JSON output
```

## Special Cases
```bash
- File named `-` → use `cat ./-`
- File with spaces → use quotes or `\`
- File starting with `-` → use `--`
JSON output
```