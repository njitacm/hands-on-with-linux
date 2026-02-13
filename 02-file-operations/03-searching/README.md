# Challenge 3: Searching & Filtering

As projects grow, you can't just browse around manually to find what you need. Linux provides powerful search tools that let you find files by name and find text inside files — across thousands of files in seconds.

## Learning Objectives

- Search for text patterns inside files with `grep`
- Find files by name, type, or other attributes with `find`
- Understand basic regular expressions for pattern matching
- Combine search tools for powerful queries

## Practice Files

This challenge includes a `sample-project/` directory — a small mock application with source code, configuration files, tests, logs, and documentation. You'll use it to practice real-world search scenarios.

```
sample-project/
├── src/
│   ├── app.py
│   ├── database.py
│   ├── auth.py
│   └── utils.py
├── config/
│   ├── settings.yml
│   └── database.conf
├── docs/
│   ├── README.md
│   └── CHANGELOG.md
├── tests/
│   ├── test_auth.py
│   └── test_utils.py
└── logs/
    └── app.log
```

## `grep` — Search Inside Files

`grep` searches for a text pattern inside files and prints every line that matches.

```bash
$ grep "TODO" sample-project/src/app.py
# TODO: Add error handling for database connection
```

### Searching Multiple Files

```bash
$ grep "TODO" sample-project/src/*.py
```

### Searching Recursively (All Files in a Directory)

The `-r` flag searches through all files in a directory and its subdirectories:

```bash
$ grep -r "TODO" sample-project/
```

This is one of the most useful commands you'll ever run. It answers the question: "Where in this project is X mentioned?"

### Useful `grep` Options

| Flag | Description |
|------|-------------|
| `-r` | Search recursively through directories |
| `-i` | Case-insensitive search |
| `-n` | Show line numbers |
| `-l` | Show only file names (not the matching lines) |
| `-c` | Show only the count of matches per file |
| `-v` | Invert — show lines that do NOT match |
| `-w` | Match whole words only |
| `--color` | Highlight matches (usually on by default) |

### Combining Flags

Flags can be combined. A very common combination:

```bash
$ grep -rn "FIXME" sample-project/
```

This recursively searches for "FIXME" and shows file paths with line numbers — perfect for tracking down issues.

```bash
$ grep -ri "error" sample-project/logs/app.log
```

Case-insensitive search for "error" in the log file.

```bash
$ grep -rl "database" sample-project/
```

List just the file names that mention "database" anywhere.

### Inverting a Search

Sometimes you want to find lines that *don't* match:

```bash
$ grep -v "INFO" sample-project/logs/app.log
```

This shows all log lines that are NOT informational — a quick way to filter for warnings and errors.

### Context Lines

You can show lines around each match:

| Flag | Description |
|------|-------------|
| `-A N` | Show N lines **A**fter each match |
| `-B N` | Show N lines **B**efore each match |
| `-C N` | Show N lines of **C**ontext (before and after) |

```bash
$ grep -C 2 "ERROR" sample-project/logs/app.log
```

This shows each ERROR line plus 2 lines above and below it — great for understanding the context around a problem.

### Basic Regular Expressions

`grep` supports patterns, not just plain text:

| Pattern | Meaning |
|---------|---------|
| `.` | Any single character |
| `*` | Zero or more of the preceding character |
| `^` | Start of line |
| `$` | End of line |
| `[abc]` | Any one of a, b, or c |
| `[0-9]` | Any digit |

```bash
$ grep "^\\[2026" sample-project/logs/app.log     # Lines starting with [2026
$ grep "ERROR\|WARN" sample-project/logs/app.log   # Lines with ERROR or WARN
$ grep -E "(TODO|FIXME)" sample-project/src/*.py   # Extended regex: TODO or FIXME
```

The `-E` flag enables **extended regex**, which supports `|` (or), `+` (one or more), and `()` (grouping) without needing backslashes.

## `find` — Search for Files

While `grep` searches *inside* files, `find` searches for files themselves — by name, type, size, modification date, and more.

### Find Files by Name

```bash
$ find sample-project/ -name "*.py"
```

This finds all files ending in `.py` inside the sample-project directory.

### Find Files by Name (Case-Insensitive)

```bash
$ find sample-project/ -iname "readme*"
```

### Find Only Files or Only Directories

```bash
$ find sample-project/ -type f              # Files only
$ find sample-project/ -type d              # Directories only
```

### Find by Size

```bash
$ find /var/log -size +1M                   # Files larger than 1 megabyte
$ find . -size -10k                         # Files smaller than 10 kilobytes
$ find . -empty                             # Empty files and directories
```

### Find by Modification Time

```bash
$ find . -mtime -7                          # Modified in the last 7 days
$ find . -mtime +30                         # Modified more than 30 days ago
```

### Combining Conditions

```bash
$ find sample-project/ -name "*.py" -type f
$ find sample-project/ -name "*.py" -not -name "test_*"
```

### Running Commands on Results

The `-exec` flag lets you run a command on every file found:

```bash
$ find sample-project/ -name "*.py" -exec grep -l "TODO" {} \;
```

This finds all `.py` files, then runs `grep` on each one to see which contain "TODO". The `{}` is a placeholder for each file name, and `\;` marks the end of the command.

## `locate` — Fast File Search

`locate` uses a pre-built database to find files almost instantly by name:

```bash
$ locate settings.yml
```

It's much faster than `find` because it searches a database rather than scanning the file system in real time. The downside: the database needs to be updated periodically.

```bash
$ sudo updatedb                 # Update the locate database
```

**Note:** `locate` may not be installed on all systems. If it's not available, stick with `find`.

## When to Use What

| Tool | Best For |
|------|----------|
| `grep` | Searching for text *inside* files |
| `grep -r` | Searching for text across an entire project |
| `find` | Searching for files by name, type, size, or date |
| `locate` | Quickly finding files by name (if database is up to date) |

## Exercises

Use the `sample-project/` directory for all exercises.

1. Use `grep -r` to find all TODO comments in the project. How many are there?

2. Use `grep -rn` to find all FIXME comments. Note the file names and line numbers.

3. Find all lines in `logs/app.log` that contain "ERROR". How many errors occurred?

4. Use `grep -v` to show all log lines that are NOT "INFO" level.

5. Use `grep` with context (`-C 2`) to show the lines around each "ERROR" in the log file. Can you understand what happened before each error?

6. Use `find` to list all Python files (`.py`) in the project.

7. Use `find` to list all configuration files (`.yml` and `.conf`).

8. Use `find` to locate all empty files or directories in the project (hint: `-empty`).

9. Combine `find` and `grep`: find all Python files that contain the word "password".
   ```bash
   find sample-project/ -name "*.py" -exec grep -l "password" {} \;
   ```

10. Use `grep -rn` to search for "database" (case-insensitive) across the entire project. Which files mention it?

11. **Bonus**: Use `grep -E` to find all lines in the log that contain either "ERROR" or "WARN" and count them (`-c`).

12. **Bonus**: The config files contain a hardcoded password. Can you find it using `grep`?

## Quick Reference

| Command | Description |
|---------|-------------|
| `grep "pattern" file` | Search for pattern in file |
| `grep -r "pattern" dir/` | Search recursively |
| `grep -rn "pattern" dir/` | Recursive with line numbers |
| `grep -ri "pattern" dir/` | Recursive, case-insensitive |
| `grep -l "pattern" files` | Show only file names |
| `grep -v "pattern" file` | Show non-matching lines |
| `grep -c "pattern" file` | Count matches |
| `grep -C N "pattern" file` | Show N context lines |
| `find dir/ -name "*.ext"` | Find files by name pattern |
| `find dir/ -type f` | Find files only |
| `find dir/ -type d` | Find directories only |
| `find dir/ -size +1M` | Find files larger than 1MB |
| `find dir/ -exec cmd {} \;` | Run command on each result |
| `locate filename` | Fast file name search |

---

**Previous:** [Text Editors](../02-text-editors/) | **Next:** [Text Processing & Comparison](../04-text-processing/)
