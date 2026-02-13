# Challenge 3: Viewing & Reading Files

You know how to navigate directories — now it's time to look inside files. Linux gives you several tools for reading files, each suited for different situations.

## Learning Objectives

- View entire files with `cat`
- Scroll through large files with `less`
- Preview the beginning or end of files with `head` and `tail`
- Count lines, words, and characters with `wc`
- Identify file types with `file`

## Practice Files

This directory contains several files to practice with:

| File | Description |
|------|-------------|
| `poem.txt` | A short text file |
| `server.log` | A simulated web server log |
| `data.csv` | An employee directory in CSV format |
| `mystery` | An unknown file — what could it be? |

## `cat` — Print a File's Contents

**Cat**enate and print. Dumps the entire file to your screen.

```bash
$ cat poem.txt
```

Best for: **Short files** that fit on one screen.

You can also number the lines:

```bash
$ cat -n poem.txt
```

Or display multiple files at once:

```bash
$ cat poem.txt data.csv
```

**Warning:** Don't `cat` very large files — they'll flood your terminal. Use `less` instead.

## `less` — Scroll Through Files

A **pager** that lets you scroll through a file one screenful at a time.

```bash
$ less server.log
```

### Navigating Inside `less`

| Key | Action |
|-----|--------|
| **Space** / **Page Down** | Scroll down one page |
| **b** / **Page Up** | Scroll up one page |
| **j** / **Down Arrow** | Scroll down one line |
| **k** / **Up Arrow** | Scroll up one line |
| **g** | Jump to the beginning of the file |
| **G** | Jump to the end of the file |
| **/<pattern>** | Search forward for "pattern" |
| **n** | Jump to next search match |
| **N** | Jump to previous search match |
| **q** | Quit |

Best for: **Any file you want to read carefully**, especially long ones. The file isn't loaded all at once, so it works well even for huge files.

There's a popular saying in Linux: **"less is more"** — `less` is actually an improved version of an older command called `more`. You might encounter `more` on some systems, but `less` can do everything `more` does and then some.

## `head` — View the Beginning

Shows the first 10 lines of a file by default.

```bash
$ head server.log           # First 10 lines
$ head -n 5 server.log      # First 5 lines
$ head -n 1 data.csv        # Just the header row of a CSV
```

Best for: **Peeking at the start** of a file, checking CSV headers, or previewing log files.

## `tail` — View the End

Shows the last 10 lines of a file by default.

```bash
$ tail server.log           # Last 10 lines
$ tail -n 5 server.log      # Last 5 lines
$ tail -n 20 server.log     # Last 20 lines
```

Best for: **Checking the latest entries** in log files or any file where the most recent data is at the bottom.

### Watching a File in Real Time

One of `tail`'s most useful features is the `-f` (follow) flag, which keeps watching the file for new lines:

```bash
$ tail -f server.log
```

This is incredibly useful for monitoring log files in real time. Press **Ctrl+C** to stop watching.

## `wc` — Count Lines, Words, and Characters

**W**ord **C**ount gives you statistics about a file.

```bash
$ wc poem.txt
  13   85  454 poem.txt
```

The three numbers are: **lines**, **words**, and **characters** (bytes).

Useful flags:

```bash
$ wc -l server.log      # Count only lines
$ wc -w poem.txt        # Count only words
$ wc -c data.csv        # Count only bytes
```

Best for: **Quick stats** — how long is this file? How many entries in this log?

## `file` — What Type of File Is This?

The `file` command inspects a file's contents to determine what kind of file it is — regardless of its name or extension.

```bash
$ file poem.txt
poem.txt: ASCII text

$ file data.csv
data.csv: CSV text

$ file mystery
mystery: Bourne-Again shell script, ASCII text executable
```

Best for: **Identifying unknown files.** File extensions can be misleading (or missing), but `file` looks at the actual contents.

## Exercises

Use the practice files in this directory for all exercises.

1. Use `cat` to view `poem.txt`. Now use `cat -n` to view it with line numbers. How many lines does the poem have?

2. Use `less` to open `server.log`. Practice scrolling up and down. Search for the word "ERROR" by typing `/ERROR` inside less. How many errors can you find? Press `q` to quit.

3. Use `head` to view just the first line of `data.csv`. What are the column names?

4. Use `tail` to view the last 5 lines of `server.log`. What was the last event?

5. Use `head` and `tail` together to extract *only* line 3 of `data.csv`. Hint: you can combine them with a pipe (`|`):
   ```bash
   head -n 3 data.csv | tail -n 1
   ```

6. Use `wc -l` to count how many lines are in each of the three text files. Which file is the longest?

7. Run `file` on every file in this directory. What type is `mystery`?

8. **Bonus**: If `mystery` is a script, can you run it? Try:
   ```bash
   ./mystery
   ```

## Quick Reference

| Command | Description |
|---------|-------------|
| `cat file` | Print entire file to screen |
| `cat -n file` | Print with line numbers |
| `less file` | Scroll through a file |
| `head file` | Show first 10 lines |
| `head -n N file` | Show first N lines |
| `tail file` | Show last 10 lines |
| `tail -n N file` | Show last N lines |
| `tail -f file` | Follow a file in real time |
| `wc file` | Count lines, words, bytes |
| `wc -l file` | Count only lines |
| `file file` | Identify file type |

---

**Previous:** [File System Navigation](../02-navigation/) | **Next:** [Creating & Organizing](../04-directories/)
