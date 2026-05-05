# Bandit Level 8 → Level 9

## Level Goal

We are in the home directory of `bandit8`.

```bash
pwd
```

Output:

```bash
/home/bandit8
```

The file given for this level is:

```bash
data.txt
```

The password for the next level is hidden inside this file.  
The important hint is that the password is the **only line that appears once**.

---

## What I Checked First

### 1. Checking current directory

```bash
pwd
```

### Breakdown

- `pwd` means **print working directory**.
- It shows where we are currently standing in the Linux file system.
- Here it showed:

```bash
/home/bandit8
```

So we are inside the home folder of the `bandit8` user.

---

### 2. Listing files

```bash
ls -la
```

### Breakdown

- `ls` lists files and folders.
- `-l` shows details like permissions, owner, group, size, and date.
- `-a` shows hidden files too, like `.bashrc` and `.profile`.

The important file here is:

```bash
data.txt
```

Its permissions are:

```bash
-rw-r-----
```

This means:

- The file owner can read and write.
- The group can read.
- Others have no permission.

The file belongs to:

```bash
bandit9 bandit8
```

That means user `bandit9` owns the file, and group `bandit8` can read it.  
Since we are logged in as `bandit8`, we can read this file.

---

### 3. Checking the file type

```bash
file ./*
```

Output:

```bash
./data.txt: ASCII text
```

### Breakdown

- `file` tells what kind of file something is.
- `./*` means check all normal files in the current folder.
- It told us that `data.txt` is simple text.

So we do not need tools like `tar`, `gzip`, or `strings` here.  
We can directly use text commands on it.

---

## Commands I Tried That Did Not Work

### 1. Wrong file command

```bash
file data.txt -size
```

Output:

```bash
file: option requires an argument -- 'e'
```

### Why it failed

This command looks like we are trying to check the file size using `file`, but `file` does not work like that.

Also, `-size` is not a valid option for the `file` command.  
Because of the `-e` part inside `-size`, Linux treated it like the `-e` option and expected an argument after it.

To check file size, better commands are:

```bash
ls -lh data.txt
```

or:

```bash
du -h data.txt
```

---

### 2. Another wrong file command

```bash
file data.txt --size
```

Output:

```bash
file: unrecognized option '--size'
```

### Why it failed

`--size` is not an option supported by the `file` command.

The `file` command is mainly used to check the file type, not the file size.

Correct command for file size:

```bash
ls -lh data.txt
```

---

### 3. Wrong grep command

```bash
grep --string data.txt
```

Output:

```bash
grep: unrecognized option '--string'
```

### Why it failed

`grep` does not have an option called `--string`.

The normal format of `grep` is:

```bash
grep "text_to_search" filename
```

Example:

```bash
grep "hello" data.txt
```

But for this level, `grep` is not the best tool because we do not know what exact text we are searching for.

Here we need to find the line that appears only once.

---

## Final Solution

```bash
sort data.txt | uniq -u
```

This prints the password for the next level.

---

## Solution Breakdown

### Full command

```bash
sort data.txt | uniq -u
```

This command has three main parts:

1. `sort data.txt`
2. `|`
3. `uniq -u`

---

### 1. `sort data.txt`

```bash
sort data.txt
```

This sorts all lines inside `data.txt`.

Why this is needed:

`uniq` only compares nearby lines.  
So if duplicate lines are far away from each other, `uniq` may not catch them properly.

Sorting puts same lines next to each other.

Example:

Before sorting:

```bash
apple
banana
apple
orange
banana
grape
```

After sorting:

```bash
apple
apple
banana
banana
grape
orange
```

Now duplicate lines are grouped together.

---

### 2. `|`

```bash
|
```

This is called a pipe.

It sends the output of the command on the left side into the command on the right side.

So this:

```bash
sort data.txt | uniq -u
```

means:

- First sort the file.
- Then send the sorted output to `uniq -u`.

We are not creating a new file here. 
We are just passing the result from one command to another.

---

### 3. `uniq -u`

```bash
uniq -u
```

This prints only the lines that appear once.

- `uniq` is used to work with repeated lines.
- `-u` means show only unique lines.

Since the level says the password is the only line that appears once, this command gives us the password directly.

---

## Why This Works

The file has many repeated lines and only one line that is not repeated.

But `uniq -u` needs repeated lines to be next to each other.

So we first sort the file:

```bash
sort data.txt
```

Then we keep only the line that appears once:

```bash
uniq -u
```

Final command:

```bash
sort data.txt | uniq -u
```

---

## Login to Next Level

After getting the password, use it to login as `bandit9`:

```bash
ssh bandit9@bandit.labs.overthewire.org -p 2220
```

---

## Key Learning

For this level, the main idea is:

```bash
sort + uniq
```

When a file has many repeated lines and we need the one line that appears only once, this pattern is very useful:

```bash
sort filename | uniq -u
```