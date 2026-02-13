# Challenge 2: File System Navigation

Now that you can talk to the terminal, it's time to learn how to move around. The Linux file system is like a tree of folders (called **directories**), and you need to know how to navigate it.

## Learning Objectives

- Understand the Linux file system hierarchy
- Use `pwd`, `cd`, and `ls` to navigate and explore
- Distinguish between absolute and relative paths
- Use special directory shortcuts (`~`, `.`, `..`, `/`)

## The Linux File System

Everything in Linux starts from the **root directory**, written as `/`. From there, the entire system branches out like an upside-down tree:

```
/                    <- Root (the top of everything)
├── home/            <- User home directories
│   ├── alice/
│   └── bob/
├── etc/             <- System configuration files
├── var/             <- Variable data (logs, databases)
│   └── log/
├── tmp/             <- Temporary files
├── usr/             <- User programs and utilities
│   ├── bin/
│   └── lib/
└── bin/             <- Essential system commands
```

Key directories to know:

| Directory | Purpose |
|-----------|---------|
| `/` | Root — the starting point of everything |
| `/home` | Contains each user's personal directory |
| `~` | Shortcut for *your* home directory (e.g., `/home/student`) |
| `/etc` | System-wide configuration files |
| `/var/log` | System log files |
| `/tmp` | Temporary files (cleared on reboot) |
| `/usr/bin` | Most user commands live here |

## `pwd` — Where Am I?

**P**rint **W**orking **D**irectory. Shows the full path to your current location.

```bash
$ pwd
/home/student
```

Always run `pwd` when you're unsure where you are.

## `cd` — Change Directory

Move to a different directory.

```bash
$ cd /tmp          # Go to /tmp
$ pwd
/tmp

$ cd ~             # Go home
$ pwd
/home/student

$ cd ..            # Go up one level
$ pwd
/home
```

### Special Shortcuts

| Shortcut | Meaning |
|----------|---------|
| `~` | Your home directory |
| `.` | The current directory |
| `..` | The parent directory (one level up) |
| `/` | The root directory |
| `-` | The previous directory you were in |

The `-` shortcut is really handy for toggling between two directories:

```bash
$ cd /var/log
$ cd /tmp
$ cd -            # Back to /var/log
$ cd -            # Back to /tmp
```

### `cd` With No Arguments

Running `cd` with nothing after it takes you straight home:

```bash
$ cd /some/deep/nested/directory
$ cd
$ pwd
/home/student
```

## `ls` — List Directory Contents

See what files and directories are in your current location (or any location you specify).

```bash
$ ls
Desktop  Documents  Downloads  file.txt
```

### Useful `ls` Options

```bash
$ ls -l             # Long format — shows permissions, owner, size, date
$ ls -a             # Show ALL files, including hidden ones (starting with .)
$ ls -la            # Combine both
$ ls -lh            # Long format with human-readable file sizes (K, M, G)
$ ls -lt            # Long format, sorted by modification time (newest first)
```

### Reading `ls -l` Output

```
-rw-r--r-- 1 student student 1234 Feb 10 09:30 notes.txt
```

| Field | Meaning |
|-------|---------|
| `-rw-r--r--` | File permissions (covered in Section 3) |
| `1` | Number of hard links |
| `student` | Owner |
| `student` | Group |
| `1234` | File size in bytes |
| `Feb 10 09:30` | Last modified date |
| `notes.txt` | File name |

Don't worry about understanding every field right now — you'll learn permissions in Section 3. For now, focus on the file name, size, and date.

### Listing a Specific Directory

You don't have to `cd` into a directory to see what's inside it:

```bash
$ ls /var/log       # List contents of /var/log from anywhere
$ ls ~/Documents    # List your Documents folder
```

## Absolute vs Relative Paths

There are two ways to specify a location:

**Absolute path** — starts from root (`/`), works from anywhere:
```bash
$ cd /home/student/Documents
```

**Relative path** — starts from where you currently are:
```bash
$ cd Documents      # Only works if you're in /home/student
```

Think of it like giving directions:
- **Absolute**: "Go to 123 Main Street" (works no matter where you are)
- **Relative**: "Go two blocks north" (depends on where you're starting from)

### How to Tell Them Apart

- Starts with `/`, `~`, or a variable like `$HOME`? It's **absolute**.
- Starts with a directory name, `.`, or `..`? It's **relative**.

```bash
/home/student/file.txt    # Absolute
~/file.txt                # Absolute (~ expands to /home/student)
./file.txt                # Relative (current directory)
../file.txt               # Relative (parent directory)
file.txt                  # Relative (current directory, ./ is implied)
```

## Hidden Files

Files and directories that start with a `.` are **hidden** — they won't show up with a regular `ls`. These are commonly used for configuration files.

```bash
$ ls           # You might see nothing
$ ls -a        # Now you see .bashrc, .profile, .config/, etc.
```

Common hidden files in your home directory:

| File | Purpose |
|------|---------|
| `.bashrc` | Bash shell configuration (runs on every new terminal) |
| `.bash_history` | Your command history |
| `.profile` | Login shell configuration |
| `.ssh/` | SSH keys and configuration |

## Exercises

1. Run `pwd`. Where are you right now?

2. Navigate to the root directory (`/`) and run `ls`. What directories do you see?

3. Go to `/var/log` and list the files there. Then use `cd -` to go back to where you were.

4. From your home directory, navigate to this challenge's directory using an **absolute path**. Then go back home and navigate here again using a **relative path**.

5. Run `ls -la` in your home directory. How many hidden files and directories do you see? Can you guess what any of them are for?

6. Try these and notice the difference:
   ```bash
   ls /usr/bin
   ls -l /usr/bin
   ls -lh /usr/bin
   ```

7. Starting from your home directory, navigate to `/tmp`, then to `/etc`, then use `cd -`. Where did it take you? Why?

8. Without using `cd`, list the contents of three different directories in one terminal session.

## Quick Reference

| Command | Description |
|---------|-------------|
| `pwd` | Print current directory |
| `cd <path>` | Change to a directory |
| `cd` | Go to home directory |
| `cd ..` | Go up one level |
| `cd -` | Go to previous directory |
| `ls` | List directory contents |
| `ls -l` | Long format listing |
| `ls -a` | Show hidden files |
| `ls -lh` | Long format with readable sizes |

---

**Previous:** [Getting Started](../01-getting-started/) | **Next:** [Viewing & Reading Files](../03-viewing-files/)
