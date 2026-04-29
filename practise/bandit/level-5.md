# Bandit Level 5 → Level 6

In this level, the password is hidden somewhere inside the **inhere** folder.

The file has these conditions:

- human-readable  
- 1033 bytes in size  
- not executable  

## Commands I used

### Go inside the folder
```bash
cd inhere
```

### See files and folders
```bash
ls
```

### See hidden files too
```bash
ls -la
```

### Find files by size
```bash
find . -size 1033c
```

Explanation:

- `find` → search files/folders  
- `.` → search in current folder  
- `-size 1033c` → exactly 1033 bytes (`c` means bytes)

### Check file type
```bash
file ./maybehere07/.file2
```

Explanation:

- `file` tells what type of file it is

### See file size in human-readable way
```bash
du -h ./maybehere07/.file2
```

Explanation:

- `du` → disk usage  
- `-h` → human readable

### Read the password
```bash
cat ./maybehere07/.file2
```

## What I learned

- `find` helps search with conditions  
- `file` helps know whether file is text or binary  
- `du -h` shows file size nicely  
- hidden files start with `.`
