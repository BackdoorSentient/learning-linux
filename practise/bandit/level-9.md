# Bandit Level 9 → Level 10

## Level Goal

We are logged in as `bandit9`.

The file for this level is:

```bash
data.txt
```

The password for the next level is hidden inside `data.txt`.

The clue says:

- The password is inside one of the few human-readable strings.
- The password line is near several `=` characters.

So the main idea is:

```bash
strings data.txt | grep "=="
```

---

## Commands I Used

### 1. Listing all files

```bash
ls -la
```

Output:

```bash
total 40
drwxr-xr-x   2 root     root     4096 Apr  3 15:17 .
drwxr-xr-x 150 root     root     4096 Apr  3 15:20 ..
-rw-r--r--   1 root     root      220 Mar 31  2024 .bash_logout
-rw-r--r--   1 root     root     3851 Apr  3 15:10 .bashrc
-rw-r-----   1 bandit10 bandit9 19382 Apr  3 15:17 data.txt
-rw-r--r--   1 root     root      807 Mar 31  2024 .profile
```

### Breakdown

`ls -la` shows all files with details.

- `ls` means list files.
- `-l` shows detailed information.
- `-a` shows hidden files also.

Important file:

```bash
data.txt
```

Permission:

```bash
-rw-r-----
```

Owner and group:

```bash
bandit10 bandit9
```

This means:

- User `bandit10` owns the file.
- Group `bandit9` can read the file.
- Since we are logged in as `bandit9`, we can read it.

---

## 2. Trying grep directly

```bash
grep = data.txt
```

Output:

```bash
grep: data.txt: binary file matches
```

### Breakdown

`grep` is used to search text inside a file.

Here we searched for:

```bash
=
```

But the output said:

```bash
binary file matches
```

This means `grep` found `=`, but it thinks the file is binary, not clean text.

So instead of printing the matching line, it only tells us that the binary file has a match.

This is why direct `grep` is not enough here.

---

## 3. Checking file type

```bash
file ./data.txt
```

Output:

```bash
./data.txt: data
```

### Breakdown

`file` tells us what kind of file it is.

Here it says:

```bash
data
```

That means Linux does not see it as a normal text file.

So the file may contain mixed content:

- readable text
- unreadable/binary data

That is why `cat` or direct `grep` is not clean for this level.

---

## 4. Checking file size

```bash
du -h data.txt
```

Output:

```bash
20K	data.txt
```

### Breakdown

`du` shows disk usage.

- `du` means disk usage.
- `-h` means human-readable format.

So instead of showing size in blocks, it shows:

```bash
20K
```

This tells us the file is around 20 KB.

This command does not solve the level, but it helps us understand the file.

---

## 5. Trying grep again with quotes

```bash
grep "=" data.txt
```

Output:

```bash
grep: data.txt: binary file matches
```

### Breakdown

This is almost the same as:

```bash
grep = data.txt
```

The quotes are fine, but the issue is still the same.

The file is detected as binary, so `grep` does not print the matching line.

It only says:

```bash
binary file matches
```

So we need another command before `grep`.

---

## 6. Using strings

```bash
strings data.txt
```

### Breakdown

`strings` extracts readable text from a file.

This is useful when a file contains binary or messy data.

Since `data.txt` is not clean text, `strings` helps us pull out the readable parts.

The command by itself shows many readable strings, so we still need to filter the useful line.

---

## 7. Mistake: running grep on the file again

```bash
grep "==" data.txt
```

Output:

```bash
grep: data.txt: binary file matches
```

### Breakdown

This searches directly inside `data.txt`.

But again, `data.txt` is treated as binary.

So we get the same problem:

```bash
binary file matches
```

The mistake here is that `grep` is still reading the original binary file.

We need `grep` to search inside the output of `strings`, not directly inside `data.txt`.

---

## Final Correct Command

```bash
strings data.txt | grep "=="
```

Output:

```bash
 ========== the
========== password
========== is
========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

### Breakdown

This command has three parts:

```bash
strings data.txt
```

This extracts readable text from `data.txt`.

```bash
|
```

This pipe sends the output of the left command into the right command.

```bash
grep "=="
```

This searches only for lines containing `==`.

So the full command means:

```text
Get readable text from data.txt, then show only the lines that contain ==.
```

That is why it gives:

```bash
========== FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

The password is:

```bash
FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

---

## 8. Mistake: adding filename after grep while using pipe

```bash
strings data.txt | grep "==" data.txt
```

Output:

```bash
grep: data.txt: binary file matches
```

### Why this failed

This looks close, but it changes how `grep` works.

When we write:

```bash
strings data.txt | grep "=="
```

`grep` searches inside the output coming from `strings`.

But when we write:

```bash
strings data.txt | grep "==" data.txt
```

we are giving `data.txt` as a file argument to `grep`.

So `grep` ignores the piped output and searches directly inside `data.txt`.

That brings back the same binary file problem.

Correct:

```bash
strings data.txt | grep "=="
```

Wrong for this level:

```bash
strings data.txt | grep "==" data.txt
```

---

## Why The Correct Command Works

The file is not normal text.

So first we clean the output using:

```bash
strings data.txt
```

Then we search for the clue pattern:

```bash
grep "=="
```

The pipe connects both commands:

```bash
strings data.txt | grep "=="
```

This gives only the useful readable lines.

---

## Login to Next Level

Now login as `bandit10`:

```bash
ssh bandit10@bandit.labs.overthewire.org -p 2220
```

Use this password:

```bash
FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey
```

---

## Key Learning

For messy or binary files, direct `grep` may only say:

```bash
binary file matches
```

In that case, use:

```bash
strings filename
```

And if you know what pattern to search:

```bash
strings filename | grep "pattern"
```

For this level:

```bash
strings data.txt | grep "=="
```