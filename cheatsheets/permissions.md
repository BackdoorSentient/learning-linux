# 📋 Permissions Cheatsheet

---

## Permission Breakdown

```
-rwxr-xr-- 1 aniket developers 4096 Jan 01 file.txt
│└──┴──┴──                                            
│  │  │  └── others:  r-- = read only
│  │  └───── group:   r-x = read + execute  
│  └──────── owner:   rwx = read + write + execute
└─────────── type:    - = file, d = directory, l = symlink
```

## Permission Values

| Symbol | Octal | Meaning |
|--------|-------|---------|
| `r` | 4 | Read |
| `w` | 2 | Write |
| `x` | 1 | Execute |
| `-` | 0 | No permission |

## Common Octal Combinations

| Octal | Symbolic | Typical Use |
|-------|----------|-------------|
| `777` | `rwxrwxrwx` | Everyone full (avoid in production) |
| `755` | `rwxr-xr-x` | Directories, scripts |
| `644` | `rw-r--r--` | Regular files |
| `600` | `rw-------` | Private files (SSH private key) |
| `700` | `rwx------` | Private directories |
| `664` | `rw-rw-r--` | Shared group files |
| `444` | `r--r--r--` | Read-only for everyone |

## chmod — Quick Reference

```bash
# Octal notation
chmod 755 file
chmod 644 file
chmod 600 ~/.ssh/id_ed25519

# Symbolic notation
chmod +x script.sh          # add execute for all
chmod u+x script.sh         # add execute for owner
chmod g-w file              # remove write from group
chmod o-r file              # remove read from others
chmod a+r file              # add read for all (a = all)
chmod u=rw,g=r,o= file      # set exact permissions

# Recursive
chmod -R 755 directory/
```

## chown — Ownership

```bash
chown aniket file                   # change owner
chown aniket:developers file        # change owner and group
chown :developers file              # change group only
chown -R aniket:aniket directory/   # recursive
```

## Special Permissions

```bash
# SUID (4) — file runs as owner, not executor
chmod u+s file
chmod 4755 file     # rwsr-xr-x

# SGID (2) — files in dir inherit group
chmod g+s directory
chmod 2755 dir      # rwxr-sr-x

# Sticky bit (1) — only owner can delete in shared dir
chmod +t directory
chmod 1777 /tmp     # rwxrwxrwt

# Find SUID files (security audit)
find / -perm -4000 2>/dev/null

# Find world-writable files (security audit)
find / -perm -0002 -type f 2>/dev/null
```

## ACLs — Fine-Grained Permissions

```bash
sudo apt install acl

# Set ACL
setfacl -m u:john:rw file.txt       # give john rw
setfacl -m g:devs:r file.txt        # give devs group read
setfacl -R -m u:john:rw directory/  # recursive

# View ACL
getfacl file.txt

# Remove ACL
setfacl -x u:john file.txt

# Remove all ACLs
setfacl -b file.txt
```

## umask — Default Permissions

```bash
umask                   # view current umask
umask 022               # set umask

# umask subtracts from 666 (files) and 777 (dirs)
# umask 022 → files: 644, dirs: 755
# umask 027 → files: 640, dirs: 750

# Set permanently in ~/.bashrc
echo "umask 022" >> ~/.bashrc
```
