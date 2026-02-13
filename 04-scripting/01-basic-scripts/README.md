# Challenge 1: Basic Scripts

A shell script is just a text file containing commands that the shell executes in order. Everything you've been typing at the prompt — you can put it in a file and run it whenever you want. That's scripting.

## Learning Objectives

- Understand what a shebang line is and why it matters
- Create, make executable, and run your first bash script
- Use variables to store and manipulate data
- Read user input in scripts
- Use command substitution to capture command output
- Understand exit codes

## Practice Files

| File | Description |
|------|-------------|
| `hello.sh` | A simple "Hello World" script |
| `greeting.sh` | A script using variables and command substitution |

Run them to see what they do, then read the source code.

## Your First Script

### Step 1: Create the File

```bash
$ vim my-script.sh
```

Write this:

```bash
#!/bin/bash
echo "Hello, world!"
```

### Step 2: Make It Executable

```bash
$ chmod +x my-script.sh
```

### Step 3: Run It

```bash
$ ./my-script.sh
Hello, world!
```

That's it. You just wrote a shell script.

## The Shebang Line

The first line of a script should be the **shebang** (also called hashbang):

```bash
#!/bin/bash
```

This tells the system which interpreter to use to run the script. Without it, the system might not know how to execute the file.

| Shebang | Interpreter |
|---------|-------------|
| `#!/bin/bash` | Bash shell |
| `#!/bin/sh` | POSIX shell (more portable, fewer features) |
| `#!/usr/bin/env python3` | Python 3 |
| `#!/usr/bin/env node` | Node.js |

The `env` form (`#!/usr/bin/env bash`) is more portable because it finds the interpreter via `PATH` rather than hardcoding a location.

## Variables

### Setting Variables

```bash
#!/bin/bash
NAME="Alice"
AGE=25
COURSE="Linux Workshop"

echo "Hi, I'm $NAME."
echo "I'm $AGE years old."
echo "I'm taking $COURSE."
```

**Rules for variable names:**
- Letters, numbers, and underscores only
- Cannot start with a number
- By convention, use UPPERCASE for constants and exported variables, lowercase for local script variables
- **No spaces** around the `=` sign

### Using Variables

Use `$` to reference a variable. Use `${}` when the variable name needs to be separated from surrounding text:

```bash
NAME="file"
echo "$NAME_backup"          # Tries to find variable NAME_backup (empty!)
echo "${NAME}_backup"        # Correctly prints: file_backup
```

### Special Variables

These are set automatically by bash:

| Variable | Meaning |
|----------|---------|
| `$0` | The script's own name |
| `$1`, `$2`, ... | Command-line arguments |
| `$#` | Number of arguments |
| `$@` | All arguments as separate words |
| `$?` | Exit code of the last command |
| `$$` | PID of the current script |

```bash
#!/bin/bash
echo "Script name: $0"
echo "First argument: $1"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

```bash
$ ./my-script.sh hello world
Script name: ./my-script.sh
First argument: hello
All arguments: hello world
Number of arguments: 2
```

## Reading User Input

### `read` — Get Input from the User

```bash
#!/bin/bash
echo -n "What is your name? "
read name
echo "Hello, $name!"
```

### `read` with a Prompt

```bash
#!/bin/bash
read -p "Enter your name: " name
read -p "Enter your age: " age
echo "$name is $age years old."
```

### Silent Input (for Passwords)

```bash
read -sp "Enter password: " password
echo ""   # Print a newline since -s suppresses it
echo "Password received (length: ${#password})"
```

## Command Substitution

Capture the output of a command and store it in a variable:

```bash
TODAY=$(date +%Y-%m-%d)
FILE_COUNT=$(ls | wc -l)
CURRENT_DIR=$(pwd)

echo "Date: $TODAY"
echo "Files here: $FILE_COUNT"
echo "Directory: $CURRENT_DIR"
```

The `$(command)` syntax runs the command and replaces itself with the output. You may also see the older backtick syntax `` `command` ``, but `$()` is preferred because it nests cleanly.

## Arithmetic

Bash does integer arithmetic with `$(( ))`:

```bash
A=10
B=3
echo "Sum: $((A + B))"           # 13
echo "Difference: $((A - B))"    # 7
echo "Product: $((A * B))"       # 30
echo "Division: $((A / B))"      # 3 (integer division!)
echo "Remainder: $((A % B))"     # 1
```

**Note:** Bash only does integer math. For decimals, use `bc`:

```bash
echo "scale=2; 10 / 3" | bc      # 3.33
```

## Exit Codes

Every command returns an **exit code** when it finishes:

| Code | Meaning |
|------|---------|
| `0` | Success |
| Non-zero | Failure (1-255) |

```bash
$ ls /home
(output)
$ echo $?
0                   # Success

$ ls /nonexistent
ls: cannot access '/nonexistent': No such file or directory
$ echo $?
2                   # Failure
```

In your scripts, use `exit` to set the exit code:

```bash
#!/bin/bash
if [ ! -f "$1" ]; then
    echo "Error: File not found: $1"
    exit 1
fi
echo "Processing $1..."
exit 0
```

## Comments

Lines starting with `#` are comments — ignored by bash:

```bash
#!/bin/bash
# This is a comment
echo "Hello"    # This is an inline comment

# Comments are essential for explaining WHY, not WHAT.
# Bad:  # Print hello
# Good: # Greet the user so they know the script started
```

## Exercises

1. Run `./hello.sh` and `./greeting.sh`. Read the source code to understand how they work.

2. Create a script called `info.sh` that prints:
   - Your username
   - Your home directory
   - The current date and time
   - The number of files in the current directory

3. Create a script called `greet.sh` that takes a name as a command-line argument and prints a greeting:
   ```bash
   $ ./greet.sh Alice
   Hello, Alice! Welcome to Linux.
   ```
   If no argument is given, it should print an error message.

4. Create a script called `ask.sh` that uses `read` to ask for the user's name and favorite color, then prints a sentence using both.

5. Create a script called `math.sh` that takes two numbers as arguments and prints their sum, difference, and product:
   ```bash
   $ ./math.sh 10 3
   Sum: 13
   Difference: 7
   Product: 30
   ```

6. Create a script called `file-info.sh` that takes a filename as an argument and prints:
   - Whether the file exists
   - The file type (using `file`)
   - The number of lines (using `wc -l`)
   - The file size

7. Modify `greeting.sh` to ask for your name using `read` instead of having it hardcoded.

8. **Bonus**: Create a script called `backup.sh` that creates a timestamped backup of a file:
   ```bash
   $ ./backup.sh notes.txt
   Backup created: notes.txt.2026-02-13_143000.bak
   ```

## Quick Reference

| Concept | Syntax |
|---------|--------|
| Shebang | `#!/bin/bash` |
| Variable assignment | `NAME="value"` |
| Variable use | `$NAME` or `${NAME}` |
| Command substitution | `$(command)` |
| Arithmetic | `$((expression))` |
| Read input | `read -p "prompt: " var` |
| Arguments | `$1`, `$2`, `$@`, `$#` |
| Exit code | `exit 0` (success), `exit 1` (failure) |
| Last exit code | `$?` |
| Comment | `# comment text` |
| Make executable | `chmod +x script.sh` |
| Run script | `./script.sh` |

---

**Next:** [Conditionals](../02-conditionals/)
