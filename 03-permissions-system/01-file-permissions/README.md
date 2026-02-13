# Challenge 1: File Permissions

Linux is a multi-user system. Permissions control who can read, write, and execute every file and directory. Understanding permissions is essential for security, collaboration, and getting your scripts to actually run.

## Learning Objectives

- Read and interpret permission strings (`rwxr-xr--`)
- Understand the owner, group, and others model
- Change permissions with `chmod` using both symbolic and numeric notation
- Change file ownership with `chown`
- Understand how permissions apply to directories

## Practice Files

| File | Description |
|------|-------------|
| `secret.txt` | A file to practice restricting access |
| `public-info.txt` | A file to practice making world-readable |
| `run-me.sh` | A script that needs execute permission to run |

## Reading Permission Strings

When you run `ls -l`, the first column shows permissions:

```bash
$ ls -l
-rw-r--r-- 1 student student  156 Feb 13 10:00 public-info.txt
-rw-r--r-- 1 student student  112 Feb 13 10:00 secret.txt
-rw-r--r-- 1 student student  178 Feb 13 10:00 run-me.sh
```

The permission string `-rw-r--r--` has four parts:

```
 -  rw-  r--  r--
 │  │    │    │
 │  │    │    └── Others (everyone else)
 │  │    └─────── Group (users in the file's group)
 │  └──────────── Owner (the file's owner)
 └─────────────── Type (- = file, d = directory, l = link)
```

### The Three Permission Types

| Symbol | Permission | For Files | For Directories |
|--------|-----------|-----------|-----------------|
| `r` | Read | View file contents | List directory contents (`ls`) |
| `w` | Write | Modify file contents | Create/delete files in the directory |
| `x` | Execute | Run as a program | Enter the directory (`cd`) |
| `-` | None | No permission | No permission |

### Who Gets Permissions

Every file has three levels of access:

| Category | Abbreviation | Who |
|----------|-------------|-----|
| **Owner** | `u` (user) | The user who owns the file |
| **Group** | `g` | Users in the file's group |
| **Others** | `o` | Everyone else on the system |
| **All** | `a` | All three categories |

### Reading Examples

| String | Meaning |
|--------|---------|
| `-rwxr-xr-x` | File: owner can do everything, group and others can read and execute |
| `-rw-r--r--` | File: owner can read/write, everyone else can only read |
| `-rw-------` | File: only the owner can read/write, no one else can do anything |
| `drwxr-xr-x` | Directory: owner has full access, others can list and enter |
| `-rwx------` | File: only the owner can read, write, and execute |

## `chmod` — Change Permissions

### Symbolic Mode

Use letters to describe what to change:

```bash
$ chmod u+x run-me.sh         # Add execute for the owner
$ chmod g+rw secret.txt        # Add read+write for the group
$ chmod o-r secret.txt         # Remove read from others
$ chmod a+r public-info.txt    # Add read for everyone
```

The format is: `chmod [who][+/-/=][permissions] file`

| Operator | Meaning |
|----------|---------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exact permissions (replaces existing) |

More examples:

```bash
$ chmod u=rwx,g=rx,o=r file.txt    # Set specific permissions for each
$ chmod u+x script.sh               # Make a script executable
$ chmod go-rwx secret.txt           # Remove all permissions from group and others
```

### Numeric (Octal) Mode

Each permission has a numeric value:

| Permission | Value |
|-----------|-------|
| Read (r) | 4 |
| Write (w) | 2 |
| Execute (x) | 1 |
| None (-) | 0 |

Add them up for each category (owner, group, others):

| Permissions | Calculation | Number |
|------------|-------------|--------|
| `rwx` | 4+2+1 | 7 |
| `rw-` | 4+2+0 | 6 |
| `r-x` | 4+0+1 | 5 |
| `r--` | 4+0+0 | 4 |
| `---` | 0+0+0 | 0 |

Three digits = owner, group, others:

```bash
$ chmod 755 run-me.sh       # rwxr-xr-x (common for scripts)
$ chmod 644 public-info.txt # rw-r--r-- (common for regular files)
$ chmod 600 secret.txt      # rw------- (private to owner)
$ chmod 700 my-directory/   # rwx------ (private directory)
```

### Common Permission Patterns

| Octal | Symbolic | Typical Use |
|-------|----------|-------------|
| `755` | `rwxr-xr-x` | Executable scripts, public directories |
| `644` | `rw-r--r--` | Regular files (default) |
| `600` | `rw-------` | Private files (SSH keys, credentials) |
| `700` | `rwx------` | Private directories |
| `777` | `rwxrwxrwx` | Everyone can do everything (avoid this!) |

## `chown` — Change Ownership

Change who owns a file:

```bash
$ chown alice file.txt             # Change owner to alice
$ chown alice:developers file.txt  # Change owner AND group
$ chown :developers file.txt       # Change only the group
$ chown -R alice:dev project/      # Recursively change a directory
```

**Note:** `chown` usually requires `sudo` because only root can give files to other users:

```bash
$ sudo chown alice:developers file.txt
```

## Directory Permissions

Permissions on directories work differently than on files:

| Permission | Effect on Directories |
|-----------|----------------------|
| `r` (read) | Can list the directory contents (`ls`) |
| `w` (write) | Can create, delete, and rename files inside |
| `x` (execute) | Can enter the directory (`cd`) and access files inside |

A common gotcha: you can have `r` without `x` on a directory. You'd be able to list file names but not actually open or `cd` into it. In practice, you almost always want `r` and `x` together on directories.

## The Execute Bit and Scripts

A script file needs the execute permission set before you can run it directly:

```bash
$ cat run-me.sh
#!/bin/bash
echo "Hello!"

$ ./run-me.sh
bash: ./run-me.sh: Permission denied

$ chmod +x run-me.sh
$ ./run-me.sh
Hello!
```

You can always bypass this by calling the interpreter directly:

```bash
$ bash run-me.sh     # Works even without execute permission
```

But setting the execute bit is the proper way.

## Exercises

1. Run `ls -l` in this directory. Read the permissions for each file. Who is the owner? What permissions does each category have?

2. Try running `./run-me.sh`. You should get "Permission denied." Add execute permission for the owner and try again:
   ```bash
   chmod u+x run-me.sh
   ./run-me.sh
   ```

3. Make `secret.txt` completely private — only you should be able to read and write it. No one else should have any access. Use numeric mode.

4. Make `public-info.txt` readable by everyone, but writable only by the owner. Use symbolic mode.

5. Set `run-me.sh` to `755`. What does each digit mean in terms of who can do what?

6. Create a new directory called `private/`. Set its permissions to `700`. Create a file inside it. Try to list its contents from another user (or note what would happen).

7. Use `ls -la` in your home directory. Find files with permissions `600`. These are typically private files like SSH keys. Why is `600` the right permission for sensitive files?

8. Create a file called `read-only.txt`. Write some text in it, then remove write permission from everyone (including yourself):
   ```bash
   chmod a-w read-only.txt
   ```
   Now try to edit it or append to it. What happens? How would you make it writable again?

9. **Bonus**: What permission string does `chmod 751` produce? Work it out by hand, then verify by creating a file and checking with `ls -l`.

10. **Bonus**: Create a directory where anyone can add files but only the owner can delete them. Hint: look up the "sticky bit" (`chmod +t` or `1` prefix).

## Quick Reference

| Command | Description |
|---------|-------------|
| `ls -l` | View permissions |
| `chmod u+x file` | Add execute for owner |
| `chmod go-rw file` | Remove read/write from group and others |
| `chmod 755 file` | Set rwxr-xr-x |
| `chmod 644 file` | Set rw-r--r-- |
| `chmod 600 file` | Set rw------- |
| `chmod -R 755 dir/` | Set permissions recursively |
| `chown user file` | Change owner |
| `chown user:group file` | Change owner and group |
| `chown -R user dir/` | Change ownership recursively |

---

**Next:** [Users & Groups](../02-users-groups/)
