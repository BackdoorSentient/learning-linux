# Bandit Level 10 → Level 11

## Level Goal

We are logged in as `bandit10`.

The file for this level is:

```bash
data.txt
```

The password for the next level is stored inside this file, but it is not written directly in normal plain text.

It is stored as **base64 encoded data**.

So our job is simple:

```text
Decode the base64 text and get the real password.
```

---

## What Is Base64?

Base64 is a way to convert data into safe text characters.

It usually looks like a long random-looking string.

Example:

```bash
VGhlIHBhc3N3b3JkIGlzIGFiYzEyMw==
```

This does not look readable at first.

But after decoding it, it may become normal text like:

```bash
The password is abc123
```

So in this level, `data.txt` contains encoded text.
We need to decode it.

---

## Commands to Use

### 1. List files

```bash
ls -la
```

### Breakdown

- `ls` lists files and folders.
- `-l` shows detailed information.
- `-a` shows hidden files too.

The important file here is:

```bash
data.txt
```

---

### 3. Check file type

```bash
file data.txt
```

Possible output:

```bash
data.txt: ASCII text
```

### Breakdown

- `file` tells what kind of file it is.
- `ASCII text` means this file is readable text.
- But readable does not always mean decoded.
- The content is readable, but still encoded in base64.

So `cat` can show the encoded text, but it will not directly give the final password.

---

### 4. View the encoded content

```bash
cat data.txt
```

Example output:

```bash
VGhlIHBhc3N3b3JkIGlzIElGdWt3S0dzRlc4TU9xM0lSRnFyeEUxaHhUTkViVVBSCg==
```

### Breakdown

- `cat` prints the content of the file.
- Here it prints a base64 encoded string.
- This is not the final password yet.
- We still need to decode it.

---

## Final Solution

```bash
base64 -d data.txt
```

Output:

```bash
The password is abcd1234
```

The password is:

```bash
abcd1234
```

---

## Solution Breakdown

### Full command

```bash
base64 -d data.txt
```

This command has three parts:

1. `base64`
2. `-d`
3. `data.txt`

---

### 1. `base64`

```bash
base64
```

### Breakdown

`base64` is used for encoding and decoding base64 text.

Encoding means converting normal data into base64.

Decoding means converting base64 back into normal readable text.

In this level, the file is already encoded, so we need decoding.

---

### 2. `-d`

```bash
-d
```

### Breakdown

`-d` means **decode**.

Without `-d`, the `base64` command will encode data.

That would be wrong here because the file is already encoded.

Correct:

```bash
base64 -d data.txt
```

Wrong for this level:

```bash
base64 data.txt
```

Why wrong?

Because it will encode the already encoded text again.

---

### 3. `data.txt`

```bash
data.txt
```

### Breakdown

This is the file we are giving to the `base64` command.

So this command:

```bash
base64 -d data.txt
```

means:

```text
Decode the base64 content inside data.txt.
```

---

## Another Working Method

You can also use pipe:

```bash
cat data.txt | base64 -d
```

### Breakdown

This means:

- `cat data.txt` prints the encoded content.
- `|` sends that output to the next command.
- `base64 -d` decodes it.

So this:

```bash
cat data.txt | base64 -d
```

does the same thing as:

```bash
base64 -d data.txt
```

But the shorter and cleaner version is:

```bash
base64 -d data.txt
```

---

## Why This Works

The file contains base64 encoded text.

So normal `cat` only shows the encoded version:

```bash
VGhlIHBhc3N3b3JkIGlz...
```

But after decoding it with:

```bash
base64 -d data.txt
```

we get the real message:

```bash
The password is IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```

---

## Key Learning

For this level, the main idea is:

```bash
base64 decoding
```

When a file contains base64 encoded text, use:

```bash
base64 -d filename
```

For this level:

```bash
base64 -d data.txt
```

If you see a long string ending with `=`, `==`, or looking like random letters and numbers, it may be base64.

But remember, not every string ending with `=` is always base64.
Here we know it is base64 because the level hint tells us.