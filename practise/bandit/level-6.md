# Bandit Level 6 → Level 7

In this level, the password file is somewhere in the whole system.

Conditions:

- owned by user **bandit7**  
- group **bandit6**  
- size **33 bytes**

## Commands I used

### Search from root
```bash
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

Explanation:

- `/` → search whole system  
- `-user bandit7` → owner is bandit7  
- `-group bandit6` → group is bandit6  
- `-size 33c` → exactly 33 bytes  
- `2>/dev/null` → hide permission denied errors

### Read the file
```bash
cat /var/lib/dpkg/info/bandit7.password
```

## Important thing I learned

I made this mistake:

```bash
cat var/lib/dpkg/info/bandit7.password
```

This failed because I forgot `/` in the beginning.

Correct path:

```bash
/var/lib/dpkg/info/bandit7.password
```

## Extra things learned

### What is `/dev/null`?

A black hole in Linux.

Anything sent there disappears.

Example:
```bash
command 2>/dev/null
```

This hides errors only.
