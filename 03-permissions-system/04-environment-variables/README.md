# Challenge 4: Environment Variables

Environment variables are how Linux configures itself. They're key-value pairs that programs read to know things like where to find files, which editor to use, and what language to display in. They're also the foundation of shell scripting.

## Learning Objectives

- Understand what environment variables are and why they matter
- View and set variables in the shell
- Understand the difference between shell variables and environment variables
- Work with the `PATH` variable
- Make changes persistent with `.bashrc` and `.profile`
- Use aliases to create shortcuts

## Practice Files

| File | Description |
|------|-------------|
| `show-env.sh` | A script that displays your environment variables |
| `sample-bashrc.sh` | Example additions for your `.bashrc` |

## What Are Environment Variables?

Environment variables are named values that the shell and programs use for configuration. Think of them as system-wide settings.

```bash
$ echo $HOME
/home/student

$ echo $USER
student

$ echo $SHELL
/bin/bash
```

The `$` prefix tells the shell to **expand** the variable — replace it with its value.

### Common Environment Variables

| Variable | Purpose | Example Value |
|----------|---------|---------------|
| `HOME` | Your home directory | `/home/student` |
| `USER` | Your username | `student` |
| `SHELL` | Your default shell | `/bin/bash` |
| `PATH` | Where to find commands | `/usr/local/bin:/usr/bin:/bin` |
| `PWD` | Current working directory | `/home/student/projects` |
| `EDITOR` | Default text editor | `vim` |
| `LANG` | System language/locale | `en_US.UTF-8` |
| `TERM` | Terminal type | `xterm-256color` |

### Viewing All Variables

```bash
$ env                       # Show all environment variables
$ env | sort                # Sorted for easier reading
$ env | grep PATH           # Find a specific one
$ printenv HOME             # Print a specific variable
```

## Setting Variables

### Shell Variables (Current Session Only)

```bash
$ MY_NAME="Alice"
$ echo $MY_NAME
Alice
```

This variable exists only in the current shell session. Close the terminal and it's gone.

**Important:** No spaces around the `=` sign:

```bash
$ MY_NAME="Alice"           # Correct
$ MY_NAME = "Alice"         # WRONG — bash thinks MY_NAME is a command
```

### Environment Variables (Inherited by Child Processes)

Shell variables are only visible in the current shell. To make them available to programs you run, **export** them:

```bash
$ MY_VAR="hello"
$ bash -c 'echo $MY_VAR'    # Empty — child process can't see it

$ export MY_VAR="hello"
$ bash -c 'echo $MY_VAR'    # "hello" — now it's exported
hello
```

The difference:
- **Shell variable**: `MY_VAR="hello"` — visible only here
- **Environment variable**: `export MY_VAR="hello"` — visible to programs you launch

### Unsetting Variables

```bash
$ unset MY_VAR               # Remove the variable entirely
```

## The `PATH` Variable

`PATH` is the most important environment variable. It tells the shell **where to look for commands**.

```bash
$ echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```

It's a list of directories separated by colons (`:`). When you type a command like `ls`, the shell searches each directory in order until it finds it.

### How `PATH` Works

```bash
$ which ls                    # Where does the shell find ls?
/usr/bin/ls

$ which python3
/usr/bin/python3
```

`which` tells you the full path to a command by searching `PATH`.

### Adding to `PATH`

```bash
$ export PATH="$HOME/bin:$PATH"
```

This adds `$HOME/bin` to the **beginning** of your PATH. Now commands in `~/bin/` will be found first.

**Why put it at the beginning?** Because the shell searches left to right and uses the first match. Putting your directory first means your versions of commands take priority.

### Common `PATH` Mistake

```bash
$ export PATH="/only/this/directory"     # BAD — replaces the entire PATH
```

This would make every other command disappear. Always include `$PATH` when adding to it:

```bash
$ export PATH="/new/directory:$PATH"     # GOOD — adds to existing PATH
```

## Making Changes Persistent

Variables set in the terminal are lost when you close it. To make them permanent, add them to a configuration file.

### `.bashrc` vs `.profile`

| File | When It Runs |
|------|-------------|
| `~/.bashrc` | Every time you open a new terminal |
| `~/.profile` or `~/.bash_profile` | Once, when you log in |

For most purposes, **use `~/.bashrc`**.

### Adding to `.bashrc`

```bash
$ echo 'export MY_PROJECT="/home/student/projects"' >> ~/.bashrc
```

Or edit it with your text editor:

```bash
$ vim ~/.bashrc
```

After editing, reload it without closing your terminal:

```bash
$ source ~/.bashrc
```

`source` (or its shorthand `.`) re-reads the file in your current shell.

## Aliases

Aliases are shortcuts for commands. They're typically defined in `.bashrc`.

### Creating Aliases

```bash
$ alias ll='ls -la'
$ alias gs='git status'
$ alias ..='cd ..'
```

Now typing `ll` runs `ls -la`.

### Viewing and Removing Aliases

```bash
$ alias                     # List all aliases
$ alias ll                  # Show what ll expands to
$ unalias ll                # Remove the alias
```

### Making Aliases Permanent

Add them to your `~/.bashrc`:

```bash
alias ll='ls -la'
alias la='ls -A'
alias ..='cd ..'
alias gs='git status'
```

## Variable Expansion

The shell replaces variables with their values before running commands:

```bash
$ NAME="Linux"
$ echo "Hello, $NAME!"
Hello, Linux!

$ echo "Your home is $HOME"
Your home is /home/student
```

### Single vs Double Quotes

| Syntax | Behavior |
|--------|----------|
| `"double quotes"` | Variables **are** expanded |
| `'single quotes'` | Variables are **not** expanded (literal text) |

```bash
$ echo "Home is $HOME"           # Home is /home/student
$ echo 'Home is $HOME'           # Home is $HOME
```

### Default Values

You can provide a fallback if a variable is not set:

```bash
$ echo "${EDITOR:-nano}"          # Use $EDITOR, or "nano" if not set
```

## Exercises

1. Run `./show-env.sh` to see your current environment. Which variables are set? Which are "not set"?

2. Set a variable `MY_PROJECT` to any path and run `./show-env.sh` again. Does it show up? Why or why not? (Hint: did you `export` it?)

3. Print your `PATH` variable. How many directories are in it? (Hint: try `echo $PATH | tr ':' '\n' | wc -l`.)

4. Use `which` to find the locations of `ls`, `grep`, `vim`, and `python3`. Are they all in directories listed in your `PATH`?

5. Create a directory `~/bin`, add it to your PATH, and create a simple script in it:
   ```bash
   mkdir -p ~/bin
   export PATH="$HOME/bin:$PATH"
   echo '#!/bin/bash' > ~/bin/hello
   echo 'echo "Hello from your custom command!"' >> ~/bin/hello
   chmod +x ~/bin/hello
   hello
   ```

6. Create three aliases of your choosing. Test them. Then remove one with `unalias`.

7. Open `~/.bashrc` in your text editor and look at what's already there. Can you find any aliases or PATH modifications that were already set up?

8. Set your `EDITOR` variable to your preferred editor and export it. Verify with `echo $EDITOR`.

9. Demonstrate the difference between single and double quotes:
   ```bash
   echo "My shell is $SHELL"
   echo 'My shell is $SHELL'
   ```

10. **Bonus**: Add a custom alias and a PATH modification to your `~/.bashrc`. Source it and verify both work. Then open a new terminal and verify they're still active.

## Quick Reference

| Command | Description |
|---------|-------------|
| `echo $VAR` | Print a variable's value |
| `VAR=value` | Set a shell variable |
| `export VAR=value` | Set an environment variable |
| `unset VAR` | Remove a variable |
| `env` | List all environment variables |
| `printenv VAR` | Print a specific variable |
| `which command` | Find where a command lives |
| `alias name='cmd'` | Create an alias |
| `unalias name` | Remove an alias |
| `source ~/.bashrc` | Reload .bashrc |
| `export PATH="dir:$PATH"` | Add directory to PATH |

---

**Previous:** [Process Management](../03-process-management/) | **Next:** [System Information](../05-system-info/)
