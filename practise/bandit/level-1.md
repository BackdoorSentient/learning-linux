# Bandit Level 1

## Problem
File name is `-`

## Issue
- `-` is treated as stdin by commands

## What is stdin?
- **stdin (standard input)** = where a program takes input from  
- By default → keyboard  


## Solution
cat ./-

## Key Learnings
- `-` can represent standard input
- Use `./` to refer to file explicitly

## file
- Shows the type of a file

### Usage
```bash
file filename
file readme
```

## du
- Shows disk usage(file size)

### Usage
```bash
du filename
```

## Better (human readable)
```bash
du -h filename
du -h readme
```

## find
- Used to search for files and directories

### Usage
```bash
find <path> -name "filename"
find . -name "readme"
```

## Find all files
```bash
find . -type f
```