# 📝 Phase 1 — Exercise Log

> Use this file to log what you practiced each day.
> Writing in your own words is the fastest way to learn.

---

## Day 1 — Date: 24 April 2026

### What I practiced today
- Learned basic terminal navigation (`pwd`, `ls`, `cd`)
- Created folders and files using `mkdir` and `touch`
- Wrote data into files using `echo` and `nano`
- Viewed file contents using `cat`, `head`, `tail`, `less`
- Copied files using `cp`
- Moved and renamed files using `mv`
- Understood relative paths like `../`
- Practiced debugging errors in commands


### Commands I tried
```bash
pwd
ls
ls -l

cd ..
cd ~
cd copy_practise

mkdir linux_practise
touch test_file.txt
touch copy_file.txt

echo "line 1" > copy_file.txt
cat copy_file.txt

cp test_file.txt copy.txt

mv copy_file.txt linux_practise/
mv copy_file.txt ../linux_practise/

head file.txt
tail file.txt
less file.txt
```

### What worked
- Creating files and folders worked smoothly  
- Writing to files using `echo` worked correctly  
- Viewing content using `cat`, `head`, `tail` was clear  
- Copying files using `cp source destination` worked after fixing syntax  
- Moving files worked when correct path was used  

### What broke / confused me
- Used `cp test_file.txt` without destination → error  
- Typed wrong filename (`copy_txt` instead of `copy_file.txt`)  
- Tried moving file to wrong location → “Not a directory” error  
- Confusion about relative path (`linux_practise/` vs `../linux_practise/`)  
- `nano` editor exit/save was confusing at first  

### What I learned from fixing it
- `cp` always needs both source and destination  
- File and folder names must match exactly (case-sensitive)  
- `mv` works for both moving and renaming  
- `../` is used to go to parent directory  
- Always check location using `pwd` and `ls` before running commands  
- Use `Ctrl + O` to save and `Ctrl + X` to exit in `nano`  

### Questions I still have
- When should I use `less` vs `cat` in real scenarios?  
- How to avoid path confusion quickly? 

---

## Day 2 — Date: ___________

### What I practiced today
- 

### Commands I tried
```bash

```

### What worked
- 

### What broke / confused me
- 

### What I learned from fixing it
- 

---

## Day 3 — Date: ___________

### What I practiced today
-

### Commands I tried
```bash

```

### What worked
-

### What broke / confused me
-

### What I learned from fixing it
-

---

> 💡 Keep adding Day 4, Day 5... as you go. This log becomes your personal Linux reference.
