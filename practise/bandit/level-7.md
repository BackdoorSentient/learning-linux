# Bandit Level 7 → Level 8

In this level, the password is in **data.txt** next to the word:

```bash
millionth
```

## Commands I used

### See files
```bash
ls -la
```

I saw:

```bash
data.txt
```

and file size was huge.

### I made this mistake first
```bash
cat data.txt
```

This kept running because the file is very large.

To stop it:

```bash
Ctrl + C
```

### Correct command
```bash
grep millionth data.txt
```

Explanation:

- `grep` searches text inside files  
- `millionth` is the word to search  
- `data.txt` is the file

This shows:

```bash
millionth PASSWORD
```

### Cleaner way
```bash
grep millionth data.txt | cut -d ' ' -f2
```

Explanation:

- `|` sends output to next command  
- `cut` splits text  
- `-d ' '` means split by space  
- `-f2` means show second part only

### Clear terminal
```bash
clear
```

## What I learned

- `cat` prints whole file  
- `grep` searches smartly  
- use `Ctrl + C` to stop running command
