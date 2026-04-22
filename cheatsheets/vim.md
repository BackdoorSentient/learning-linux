# 📋 Vim Cheatsheet

> Vim has modes. Understanding modes is the key to everything.

---

## Modes

| Mode | How to enter | What it does |
|------|-------------|--------------|
| Normal | `Esc` | Navigate and run commands |
| Insert | `i` | Type text |
| Visual | `v` | Select text |
| Command | `:` | Run commands (save, quit, search) |

> 💡 Always press `Esc` first if you're unsure which mode you're in.

---

## Opening and Closing

```
vim file.txt        open file
:w                  save
:q                  quit (fails if unsaved changes)
:wq                 save and quit
:q!                 quit WITHOUT saving (force)
:wqa                save and quit all open files
ZZ                  save and quit (shortcut)
```

---

## Moving Around (Normal Mode)

```
h j k l             ← ↓ ↑ → (or use arrow keys)
w                   move forward one word
b                   move backward one word
e                   move to end of word
0                   move to start of line
$                   move to end of line
gg                  go to first line
G                   go to last line
:42                 go to line 42
Ctrl+f              page down
Ctrl+b              page up
%                   jump to matching bracket
```

---

## Entering Insert Mode

```
i                   insert before cursor
a                   insert after cursor
I                   insert at start of line
A                   insert at end of line
o                   open new line below
O                   open new line above
```

---

## Editing (Normal Mode)

```
x                   delete character under cursor
dd                  delete (cut) current line
dw                  delete word
d$                  delete to end of line
D                   delete to end of line
yy                  copy (yank) current line
yw                  copy word
y$                  copy to end of line
p                   paste after cursor
P                   paste before cursor
u                   undo
Ctrl+r              redo
r<char>             replace single character
cw                  change word (delete + insert mode)
cc                  change entire line
.                   repeat last command
```

---

## Visual Mode (Select Text)

```
v                   start visual (character select)
V                   start visual line (line select)
Ctrl+v              start visual block (column select)
y                   copy selected text
d                   delete selected text
>                   indent selected
<                   unindent selected
```

---

## Search and Replace

```
/word               search forward for "word"
?word               search backward for "word"
n                   next match
N                   previous match
*                   search for word under cursor

# Replace
:s/old/new          replace first on current line
:s/old/new/g        replace all on current line
:%s/old/new/g       replace all in entire file
:%s/old/new/gc      replace all with confirmation
```

---

## Multiple Files

```
:e file.txt         open another file
:bn                 next buffer
:bp                 previous buffer
:ls                 list open buffers
:split file.txt     split window horizontally
:vsplit file.txt    split window vertically
Ctrl+w w            switch between split windows
Ctrl+w q            close split window
```

---

## Useful Commands

```
:set number         show line numbers
:set nonumber       hide line numbers
:set paste          paste mode (prevents auto-indent issues)
:set nopaste        turn off paste mode
gg=G                auto-indent entire file
:!command           run shell command (e.g. :!ls)
```

---

## vimrc — Useful Settings

```bash
nano ~/.vimrc
```

```vim
set number          " show line numbers
set tabstop=4       " tab = 4 spaces
set shiftwidth=4    " indent = 4 spaces
set expandtab       " use spaces, not tabs
set hlsearch        " highlight search results
set incsearch       " search as you type
set autoindent      " auto-indent new lines
syntax on           " syntax highlighting
```
