# Challenge 1: File Manipulation

You can create files and directories — now it's time to learn how to copy, move, rename, and delete them. These are the operations you'll use constantly when organizing your work.

## Learning Objectives

- Copy files and directories with `cp`
- Move and rename files with `mv`
- Remove files and directories with `rm` and `rmdir`
- Use wildcards (globs) to work with multiple files at once
- Practice safe deletion habits

## Practice Files

This challenge includes a `playground/` directory with sample files to experiment with:

```
playground/
├── documents/
│   ├── report.txt
│   ├── notes.txt
│   └── todo.txt
├── images/
│   ├── photo1.txt
│   ├── photo2.txt
│   └── screenshot.txt
└── downloads/
    ├── archive.tar.gz.txt
    ├── installer.sh
    └── data-backup.csv
```

**Important:** Before you start, make a backup of the playground so you can reset it if needed:

```bash
cp -r playground playground-backup
```

## `cp` — Copy Files

Make a copy of a file:

```bash
$ cp source.txt destination.txt
```

### Copying to a Different Directory

```bash
$ cp report.txt /tmp/                  # Copy to /tmp, same name
$ cp report.txt /tmp/report-copy.txt   # Copy to /tmp with a new name
```

### Copying Multiple Files

You can copy several files into a directory at once:

```bash
$ cp file1.txt file2.txt file3.txt /tmp/
```

### Copying Directories

By default, `cp` only copies individual files. To copy a directory and everything inside it, use the `-r` (recursive) flag:

```bash
$ cp -r documents/ documents-backup/
```

Without `-r`, you'll get an error:

```bash
$ cp documents/ somewhere/
cp: -r not specified; omitting directory 'documents/'
```

### Useful `cp` Options

| Flag | Description |
|------|-------------|
| `-r` | Copy directories recursively |
| `-i` | Prompt before overwriting existing files |
| `-v` | Verbose — show what's being copied |
| `-n` | Don't overwrite existing files |

The `-i` flag is especially useful as a safety measure:

```bash
$ cp -i report.txt notes.txt
cp: overwrite 'notes.txt'? n
```

## `mv` — Move and Rename

`mv` does double duty — it both **moves** files to a new location and **renames** them.

### Renaming a File

```bash
$ mv oldname.txt newname.txt
```

### Moving a File to Another Directory

```bash
$ mv report.txt documents/
```

### Moving and Renaming at the Same Time

```bash
$ mv todo.txt documents/task-list.txt
```

### Moving Multiple Files

```bash
$ mv file1.txt file2.txt file3.txt target-directory/
```

### Moving Directories

Unlike `cp`, `mv` works on directories without needing `-r`:

```bash
$ mv old-folder/ new-folder/    # Rename a directory
$ mv project/ /tmp/             # Move a directory
```

### Useful `mv` Options

| Flag | Description |
|------|-------------|
| `-i` | Prompt before overwriting |
| `-v` | Verbose — show what's being moved |
| `-n` | Don't overwrite existing files |

## `rm` — Remove Files

Delete a file permanently:

```bash
$ rm unwanted-file.txt
```

**There is no trash can.** When you `rm` a file, it's gone. There is no undo. This is why careful habits matter.

### Removing Multiple Files

```bash
$ rm file1.txt file2.txt file3.txt
```

### Removing Directories

`rm` alone won't delete directories. You need the `-r` (recursive) flag:

```bash
$ rm -r old-directory/
```

This deletes the directory and **everything inside it**.

### Useful `rm` Options

| Flag | Description |
|------|-------------|
| `-r` | Remove directories and their contents recursively |
| `-i` | Prompt before every removal |
| `-v` | Verbose — show what's being removed |

### The `-i` Safety Net

Until you're confident, use `-i` to confirm each deletion:

```bash
$ rm -i *.txt
rm: remove regular file 'notes.txt'? y
rm: remove regular file 'report.txt'? n
```

## `rmdir` — Remove Empty Directories

`rmdir` only removes directories that are **empty** — a safer alternative to `rm -r`:

```bash
$ mkdir empty-dir
$ rmdir empty-dir           # Works — directory is empty

$ mkdir -p full-dir && touch full-dir/file.txt
$ rmdir full-dir
rmdir: failed to remove 'full-dir': Directory not empty
```

This is a good safety check. If `rmdir` fails, it means there are still files inside that you should review before deleting.

## Wildcards (Globbing)

Wildcards let you match multiple files with a pattern instead of naming them one by one.

### `*` — Matches Any Number of Characters

```bash
$ ls *.txt              # All .txt files
$ ls photo*             # Everything starting with "photo"
$ ls *.csv              # All CSV files
$ cp *.txt /tmp/        # Copy all .txt files to /tmp
```

### `?` — Matches Exactly One Character

```bash
$ ls photo?.txt         # Matches photo1.txt, photo2.txt, but not photo10.txt
```

### `[...]` — Matches One Character from a Set

```bash
$ ls photo[12].txt      # Matches photo1.txt and photo2.txt
$ ls file[a-z].txt      # Matches filea.txt through filez.txt
```

### `{...}` — Brace Expansion (Not Technically a Glob)

As you learned in Section 1, braces generate multiple strings:

```bash
$ cp report.{txt,bak}   # Same as: cp report.txt report.bak
$ mv file.{old,new}     # Same as: mv file.old file.new
```

### Wildcard Safety

**Always preview before you delete.** Run `ls` with your wildcard pattern first to see what matches:

```bash
$ ls *.txt              # Check what matches
notes.txt  report.txt  todo.txt

$ rm *.txt              # Now you know exactly what you're deleting
```

## Safe Deletion Practices

1. **Preview with `ls` first**: Always run `ls <pattern>` before `rm <pattern>`
2. **Use `-i` when uncertain**: `rm -i` asks you to confirm each file
3. **Avoid `rm -rf /`**: Never run `rm -rf` on `/` or with unquoted variables. Just don't.
4. **Use `rmdir` for empty directories**: It's safer than `rm -r` because it won't delete anything with contents
5. **Back things up**: When in doubt, `cp -r` your directory before making changes

## Exercises

Work inside the `playground/` directory. Remember to make a backup first with `cp -r playground playground-backup`.

1. Copy `documents/report.txt` to a new file called `documents/report-backup.txt`.

2. Copy the entire `documents/` directory to a new directory called `documents-archive/`.

3. Rename `downloads/installer.sh` to `downloads/setup.sh`.

4. Move all `.txt` files from `images/` into `documents/`.

5. Create a new directory called `organized/`. Move `downloads/data-backup.csv` into it.

6. Use a wildcard to list all files across the playground that end in `.txt`. Hint: `ls playground/**/*.txt` or `ls playground/*/*.txt`.

7. Remove `downloads/archive.tar.gz.txt` using `rm -i`. Confirm the deletion when prompted.

8. Create an empty directory called `temp/`, verify it's empty, then remove it with `rmdir`.

9. **Reset exercise**: If you've messed up the playground, delete it and restore from your backup:
   ```bash
   rm -r playground
   cp -r playground-backup playground
   ```

10. **Bonus**: Using a single command, create backup copies of all three files in `documents/` with a `.bak` extension. Hint: use a loop or brace expansion.

## Quick Reference

| Command | Description |
|---------|-------------|
| `cp src dest` | Copy a file |
| `cp -r src/ dest/` | Copy a directory recursively |
| `cp -i src dest` | Copy with overwrite confirmation |
| `mv src dest` | Move or rename a file |
| `mv src dir/` | Move a file into a directory |
| `rm file` | Delete a file (permanent!) |
| `rm -r dir/` | Delete a directory and its contents |
| `rm -i file` | Delete with confirmation |
| `rmdir dir/` | Remove an empty directory |
| `*` | Wildcard: any characters |
| `?` | Wildcard: exactly one character |
| `[abc]` | Wildcard: one character from set |

---

**Next:** [Text Editors](../02-text-editors/)
