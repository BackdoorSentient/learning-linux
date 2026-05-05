# Bandit Level 11 → Level 12

## Level Goal

We are logged in as `bandit11`.

The file for this level is:

```bash
data.txt
```

The password for the next level is inside this file, but the text is not normal.

All lowercase and uppercase letters have been rotated by 13 positions.

This is called **ROT13**.

So our job is:

```text
Read data.txt and rotate the letters back by 13 positions.
```

---

## What Is ROT13?

ROT13 means **rotate by 13**.

Each letter is shifted 13 places forward in the alphabet.

Example:

```text
A → N
B → O
C → P
```

And after reaching the end, it wraps around:

```text
N → A
O → B
P → C
```

Same thing happens with lowercase letters:

```text
a → n
b → o
c → p
```

ROT13 is special because applying it twice gives back the original text.

Example:

```text
hello
```

After ROT13:

```text
uryyb
```

Apply ROT13 again:

```text
hello
```

So to decode ROT13, we use the same ROT13 conversion again.

---

## Commands to Use

### 1. List files

```bash
ls -la
```

### Breakdown

- `ls` lists files and folders.
- `-l` shows details like permissions, owner, group, size, and date.
- `-a` shows hidden files too.

The important file is:

```bash
data.txt
```

---

### 2. Check file type

```bash
file data.txt
```

Possible output:

```bash
data.txt: ASCII text
```

### Breakdown

- `file` tells us what kind of file it is.
- `ASCII text` means it is readable text.
- But the text is encoded using ROT13, so it will look strange.

---

### 3. View the file

```bash
cat data.txt
```

Example output:

```bash
Gur cnffjbeq vf 5Gr8L4qetPEsPk8htqjhRK8XSP6x2RHh
```

### Breakdown

- `cat` prints the content of the file.
- The text looks readable, but it does not make proper sense.
- That is because each letter has been shifted by 13 positions.

The first word:

```text
Gur
```

becomes:

```text
The
```

So we know we need ROT13 decoding.

---

## Final Solution

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Output:

```bash
The password is 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

The password is:

```bash
5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

---

## Solution Breakdown

### Full command

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

This command has three main parts:

1. `cat data.txt`
2. `|`
3. `tr 'A-Za-z' 'N-ZA-Mn-za-m'`

---

### 1. `cat data.txt`

```bash
cat data.txt
```

### Breakdown

`cat` prints the content of the file.

Here it prints the ROT13 encoded message.

Example:

```bash
Gur cnffjbeq vf 5Gr8L4qetPEsPk8htqjhRK8XSP6x2RHh
```

This is not the final readable message yet.

---

### 2. `|`

```bash
|
```

### Breakdown

This is called a pipe.

It sends the output of the left command into the right command.

So this:

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

means:

```text
Print data.txt, then send that text to tr for decoding.
```

---

### 3. `tr 'A-Za-z' 'N-ZA-Mn-za-m'`

```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

### Breakdown

`tr` means **translate**.

It replaces characters from one set with characters from another set.

Here:

```bash
'A-Za-z'
```

means all uppercase and lowercase letters:

```text
A to Z and a to z
```

And:

```bash
'N-ZA-Mn-za-m'
```

means the ROT13 shifted alphabet.

Uppercase mapping:

```text
A-Z  →  N-ZA-M
```

Lowercase mapping:

```text
a-z  →  n-za-m
```

So the command changes each letter back to its original form.

---

## Understanding The Mapping

This part:

```bash
'A-Za-z'
```

means:

```text
ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
```

This part:

```bash
'N-ZA-Mn-za-m'
```

means:

```text
NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm
```

So `tr` maps them like this:

```text
A → N
B → O
C → P
...
N → A
O → B
P → C
```

For lowercase:

```text
a → n
b → o
c → p
...
n → a
o → b
p → c
```

Numbers do not change.

So if the password has numbers like:

```text
5
8
4
```

they stay the same.

Only letters are rotated.

---

## Another Working Method

You can also use:

```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt
```

### Breakdown

This means:

- Take `data.txt` as input.
- Send it directly to `tr`.
- Decode the ROT13 text.

This avoids using `cat`.

Both commands work:

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

and:

```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt
```

For learning pipes, the first one is easier to understand.

---

## Common Mistake

### Wrong command

```bash
tr 'A-Z' 'N-ZA-M' data.txt
```

### Why this is wrong

`tr` does not take the filename like `grep` or `cat`.

This command will not read `data.txt` properly.

`tr` expects input from:

- a pipe, or
- input redirection

Correct with pipe:

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Correct with redirection:

```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt
```

---

## Why This Works

The file contains ROT13 encoded text.

The text says something like:

```bash
Gur cnffjbeq vf ...
```

After ROT13 decoding, it becomes:

```bash
The password is ...
```

So this command gives the final password:

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

---
## Key Learning

For this level, the main idea is:

```bash
ROT13 + tr
```

When letters are shifted and you need to replace characters, use:

```bash
tr
```

For ROT13 decoding:

```bash
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

Shorter version:

```bash
tr 'A-Za-z' 'N-ZA-Mn-za-m' < data.txt
```