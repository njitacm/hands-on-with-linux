# Challenge 4: Creating & Organizing

You can navigate and read files — now it's time to create your own. This challenge covers making directories, creating files, and building organized project structures.

## Learning Objectives

- Create directories with `mkdir`
- Create empty files with `touch`
- Visualize directory structures with `tree`
- Build a well-organized project layout from scratch

## `mkdir` — Make Directories

Create a new directory:

```bash
$ mkdir projects
$ ls
projects
```

### Creating Nested Directories

Without the `-p` flag, `mkdir` can only create one level at a time:

```bash
$ mkdir a/b/c
mkdir: cannot create directory 'a/b/c': No such file or directory
```

The `-p` flag creates the entire path, including any parent directories that don't exist yet:

```bash
$ mkdir -p a/b/c
$ ls a
b
$ ls a/b
c
```

### Creating Multiple Directories at Once

```bash
$ mkdir dir1 dir2 dir3
$ mkdir -p project/{src,tests,docs}
```

That last command uses **brace expansion** — a shell feature that expands `{src,tests,docs}` into three separate arguments. It creates:

```
project/
├── src/
├── tests/
└── docs/
```

You can even nest brace expansions:

```bash
$ mkdir -p project/{src/{main,lib},tests,docs}
```

Creates:

```
project/
├── src/
│   ├── main/
│   └── lib/
├── tests/
└── docs/
```

## `touch` — Create Empty Files

`touch` creates a new empty file if it doesn't exist. If the file already exists, it updates its timestamp without changing the contents.

```bash
$ touch notes.txt
$ ls -l notes.txt
-rw-r--r-- 1 student student 0 Feb 13 10:00 notes.txt
```

Notice the file size is `0` — it's empty.

### Creating Multiple Files

```bash
$ touch file1.txt file2.txt file3.txt
```

### Combining `mkdir` and `touch`

A common pattern is to create a directory structure and then populate it with files:

```bash
$ mkdir -p myproject/src
$ touch myproject/src/main.py
$ touch myproject/README.md
```

## `tree` — Visualize Directory Structures

`tree` shows you a visual representation of a directory tree. It's incredibly useful for understanding how files are organized.

```bash
$ tree myproject
myproject
├── README.md
└── src
    └── main.py

1 directory, 2 files
```

### Useful `tree` Options

```bash
$ tree -L 2 /home          # Limit depth to 2 levels
$ tree -d                   # Show directories only, no files
$ tree -a                   # Include hidden files
$ tree --dirsfirst          # List directories before files
```

**Note:** `tree` may not be installed on all systems. If you get "command not found", you can install it (covered in Section 4) or use `ls -R` as a less pretty alternative:

```bash
$ ls -R myproject           # Recursively list all files
```

## Brace Expansion Deep Dive

Brace expansion is a shell feature (not a command) that generates strings. It's very powerful for creating structures quickly:

```bash
# Create numbered files
$ touch file{1,2,3,4,5}.txt

# Use ranges
$ touch log_{01..12}.txt          # log_01.txt through log_12.txt

# Combine with directories
$ mkdir -p app/{frontend,backend}/{src,tests,config}
```

That last one creates this entire structure in a single command:

```
app/
├── frontend/
│   ├── src/
│   ├── tests/
│   └── config/
└── backend/
    ├── src/
    ├── tests/
    └── config/
```

## Common Patterns

### Standard Project Layout

Most software projects follow recognizable structures. Here's a common one:

```
project-name/
├── README.md
├── src/
│   └── (source code)
├── tests/
│   └── (test files)
├── docs/
│   └── (documentation)
└── config/
    └── (configuration files)
```

### Organizing by Date

Useful for logs, notes, or data:

```
notes/
├── 2026/
│   ├── 01/
│   ├── 02/
│   └── 03/
```

Create it with: `mkdir -p notes/2026/{01..12}`

## Exercises

All exercises should be done from a temporary working directory. Create one first:

```bash
mkdir -p /tmp/linux-workshop-practice
cd /tmp/linux-workshop-practice
```

1. Create a directory called `my-first-project`. Inside it, create three subdirectories: `src`, `tests`, and `docs`. Do this **without** using the `-p` flag (you'll need multiple commands).

2. Now do the same thing in a **single command** using `mkdir -p` and brace expansion. Call it `my-second-project`.

3. Inside `my-second-project/src`, create three files: `app.py`, `utils.py`, and `config.py`. Use a single `touch` command.

4. Create the following structure using as few commands as possible:
   ```
   webapp/
   ├── frontend/
   │   ├── css/
   │   │   └── style.css
   │   ├── js/
   │   │   └── app.js
   │   └── index.html
   └── backend/
       ├── routes/
       ├── models/
       └── server.py
   ```

5. Use `tree` to verify your `webapp` structure looks correct. If `tree` isn't installed, use `ls -R webapp` instead.

6. Create a directory structure for 12 months of logs:
   ```
   logs/2026/{01..12}/
   ```
   Then create an `access.log` and `error.log` file in the January directory.

7. Run `touch` on a file that already exists. Then check its timestamp with `ls -l`. Run `touch` on it again. What changed? What stayed the same?

## Quick Reference

| Command | Description |
|---------|-------------|
| `mkdir dir` | Create a directory |
| `mkdir -p a/b/c` | Create nested directories (and parents) |
| `mkdir dir1 dir2` | Create multiple directories |
| `touch file` | Create an empty file (or update timestamp) |
| `tree` | Visualize directory tree |
| `tree -L N` | Limit tree depth to N levels |
| `tree -d` | Show directories only |
| `{a,b,c}` | Brace expansion: generates `a b c` |
| `{01..12}` | Range expansion: generates `01 02 ... 12` |

---

**Previous:** [Viewing & Reading Files](../03-viewing-files/) | **Next:** [Getting Help](../05-getting-help/)
