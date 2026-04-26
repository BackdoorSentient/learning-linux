# Bandit Level 2

## Problem
File name contains spaces and starts with `--`

## What I saw
--spaces in this filename--

## Issues
- Spaces break arguments
- `--` treated as command option

## Solutions
cat -- "--spaces in this filename--"

OR

cat ./--spaces\ in\ this\ filename--

## Key Learnings
- Use quotes for spaces
- Use `\` to escape spaces
- Use `--` to stop option parsing
- Use `./` for weird filenames