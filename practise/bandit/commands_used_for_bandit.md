# Commands Used in Bandit

Simple notes for the commands I used while solving Bandit.

---

## `ssh`

Used to login to another machine/server from my terminal.

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

Meaning:

- `ssh` connects to the server
- `bandit0` is the username
- `bandit.labs.overthewire.org` is the server name
- `-p 2220` means connect using port 2220

---

## `man`

Used when I want to read help for a command.

```bash
man grep
```

Meaning:

- opens the manual page for `grep`

Inside `man`:

```bash
q
```

Used to quit.

---

## `pwd`

Used to check where I am right now.

```bash
pwd
```

Example output:

```bash
/home/bandit3/inhere
```

Meaning:

- I am currently inside this folder

---

## `ls`

Used to see files and folders.

```bash
ls
```

Shows normal files and folders.

```bash
ls -la
```

Shows everything, including hidden files.

Meaning:

- `-l` shows more details
- `-a` shows hidden files also

---

## `cd`

Used to move between folders.

```bash
cd inhere
```

Goes inside `inhere`.

```bash
cd ..
```

Goes one folder back.

```bash
cd ~
```

Goes to home folder.

---

## `cat`

Used to print file content on the terminal.

```bash
cat file.txt
```

Used when the file is small and readable.

For a file with spaces in name:

```bash
cat "spaces in this filename"
```

For a file named `-`:

```bash
cat ./-
```

Important:

- `cat` is not good for very large files
- if it keeps printing too much, stop it using `Ctrl + C`

---

## `clear`

Used to clean the terminal screen.

```bash
clear
```

This does not delete files. It only clears the screen.

---

## `less`

Used to open a big file page by page.

```bash
less data.txt
```

Inside `less`:

```bash
q
```

Quit.

```bash
/word
```

Search for a word.

```bash
n
```

Go to next match.

```bash
Space
```

Go to next page.

```bash
b
```

Go to previous page.

---

## `grep`

Used to search text inside a file.

```bash
grep millionth data.txt
```

Meaning:

- search for `millionth` inside `data.txt`
- print only the matching line

Other usage:

```bash
grep -i "hello" file.txt
```

Search without caring about capital/small letters.

```bash
grep -r "password" .
```

Search inside current folder and subfolders.

---

## `find`

Used to search for files and folders.

```bash
find . -size 1033c
```

Meaning:

- search from current folder
- find files with size exactly 1033 bytes

```bash
find / -user bandit7 -group bandit6 -size 33c
```

Meaning:

- search from root `/`
- find files owned by user `bandit7`
- group should be `bandit6`
- size should be 33 bytes

With hidden errors:

```bash
find / -user bandit7 -group bandit6 -size 33c 2>/dev/null
```

Meaning:

- same search
- hide permission denied errors

---

## `file`

Used to check what kind of file it is.

```bash
file filename
```

Example:

```bash
file data.txt
```

It can tell if the file is:

- normal text
- binary file
- gzip file
- bzip2 file
- tar archive
- hexdump

Useful before opening unknown files.

---

## `du`

Used to check file or folder size.

```bash
du -h filename
```

Meaning:

- `du` shows disk usage
- `-h` makes it easy to read

Example sizes:

```bash
4K
1M
20M
```

---

## `sort`

Used to sort lines.

```bash
sort data.txt
```

Meaning:

- arrange lines in order

Useful before using `uniq`.

---

## `uniq`

Used to remove repeated lines that are next to each other.

```bash
uniq data.txt
```

But this works best after sorting:

```bash
sort data.txt | uniq
```

Show only the line that appears once:

```bash
sort data.txt | uniq -u
```

Count repeated lines:

```bash
sort data.txt | uniq -c
```

---

## `strings`

Used to pull readable text from a weird/binary file.

```bash
strings data.txt
```

Useful when `cat` shows garbage.

With `grep`:

```bash
strings data.txt | grep password
```

Meaning:

- first pull readable text
- then search for `password`

---

## `base64`

Used to encode or decode base64 text.

Decode:

```bash
base64 -d data.txt
```

Decode text directly:

```bash
echo "aGVsbG8=" | base64 -d
```

Important:

- base64 is not password protection
- it is just another way to write data

---

## `tr`

Used to replace, change, or delete characters.

Convert small letters to capital:

```bash
echo "hello" | tr 'a-z' 'A-Z'
```

Remove numbers:

```bash
echo "hello123" | tr -d '0-9'
```

ROT13 style decoding:

```bash
echo "URYYB" | tr 'A-Z' 'N-ZA-M'
```

Meaning:

- `tr` works character by character

---

## `tar`

Used to pack or unpack `.tar` files.

Extract:

```bash
tar -xvf file.tar
```

Meaning:

- `-x` extract
- `-v` show what is happening
- `-f` file name comes next

See what is inside without extracting:

```bash
tar -tvf file.tar
```

Meaning:

- `-t` list contents

---

## `gzip`

Used for `.gz` compressed files.

Decompress:

```bash
gzip -d file.gz
```

Same thing:

```bash
gunzip file.gz
```

Meaning:

- turns `.gz` file back into normal file

---

## `bzip2`

Used for `.bz2` compressed files.

Decompress:

```bash
bzip2 -d file.bz2
```

Same thing:

```bash
bunzip2 file.bz2
```

Meaning:

- turns `.bz2` file back into normal file

---

## `xxd`

Used to see or reverse hex data.

Show file in hex:

```bash
xxd file.txt
```

Reverse hex dump back to original file:

```bash
xxd -r data.txt > output
```

Meaning:

- `xxd` shows raw bytes in hex
- `xxd -r` reverses hex back to real data
- `> output` saves result in a new file

---

## `cut`

Used to take only one part from a line.

```bash
grep millionth data.txt | cut -d ' ' -f2
```

Meaning:

- `grep millionth data.txt` finds the line
- `cut` splits the line
- `-d ' '` means split using space
- `-f2` means print the second part

---

## `echo`

Used to print text.

```bash
echo "hello"
```

Can also send text into another command:

```bash
echo "hello" | base64
```

Meaning:

- print `hello`
- send it to `base64`

---

## `|` pipe

Used to send output of one command into another command.

```bash
strings data.txt | grep password
```

Meaning:

- `strings data.txt` gives readable text
- `grep password` searches inside that output

Another example:

```bash
sort data.txt | uniq -u
```

Meaning:

- sort lines first
- then show only unique line

---

## `>` output save

Used to save command output into a file.

```bash
xxd -r data.txt > output
```

Meaning:

- run the command
- save result inside `output`

Important:

- `>` replaces old file content if the file already exists

---

## `>>` output append

Used to add output at the end of a file.

```bash
echo "new note" >> notes.md
```

Meaning:

- add this line at the end
- do not delete old content

---

## `2>/dev/null`

Used to hide errors.

```bash
find / -name password 2>/dev/null
```

Meaning:

- normal output will still show
- error messages will be hidden

Useful when many `Permission denied` errors appear.

---

## `Ctrl + C`

Used to stop a running command.

Example:

```bash
cat data.txt
```

If it keeps printing too much, press:

```bash
Ctrl + C
```

Meaning:

- stop the current command

---

## `nano`

Used to create or edit a file from terminal.

```bash
nano level-5.md
```

Save:

```bash
Ctrl + O
Enter
```

Exit:

```bash
Ctrl + X
```

Meaning:

- `Ctrl + O` saves
- `Enter` confirms file name
- `Ctrl + X` exits nano

---

## `mkdir`

Used to create a folder.

```bash
mkdir notes
```

Meaning:

- creates a folder named `notes`

---

## `cp`

Used to copy files or folders.

```bash
cp file.txt copy.txt
```

Meaning:

- copy `file.txt`
- new copied file name is `copy.txt`

Copy folder:

```bash
cp -r folder1 folder2
```

Meaning:

- `-r` copies folder with everything inside it

---

## `mv`

Used to move or rename files.

Rename:

```bash
mv old.txt new.txt
```

Move:

```bash
mv file.txt folder/
```

Meaning:

- same command is used for moving and renaming

---

## `rm`

Used to delete files.

```bash
rm file.txt
```

Delete folder with everything inside:

```bash
rm -r foldername
```

Force delete:

```bash
rm -rf foldername
```

Be careful:

- `rm` deletes directly
- no recycle bin in terminal

---

## `rmdir`

Used to remove empty folders.

```bash
rmdir foldername
```

Important:

- works only if folder is empty

---

## `chmod`

Used to change file permissions.

```bash
chmod +x script.sh
```

Meaning:

- make `script.sh` executable

---

## `whoami`

Used to check which user I am logged in as.

```bash
whoami
```

Example output:

```bash
bandit7
```

---

## `head`

Used to show first lines of a file.

```bash
head file.txt
```

Show first 5 lines:

```bash
head -n 5 file.txt
```

---

## `tail`

Used to show last lines of a file.

```bash
tail file.txt
```

Show live new lines:

```bash
tail -f file.txt
```

Meaning:

- useful for logs
- it keeps watching the file

Stop it using:

```bash
Ctrl + C
```
