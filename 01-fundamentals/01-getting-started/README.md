# Challenge 1: Getting Started

Your first step into Linux — open a terminal and start talking to your computer.

## Learning Objectives

- Understand what a terminal is and why it matters
- Read and interpret the command prompt
- Run basic informational commands
- Understand the difference between a command, its options, and its arguments

## What Is a Terminal?

A terminal (also called a shell, console, or command line) is a text-based interface to your computer. Instead of clicking icons and menus, you type commands and the system responds with text output.

Why use it? Because it's **fast**, **scriptable**, and **powerful**. Nearly every server in the world is managed through a terminal. Learning it now gives you a skill that transfers everywhere.

## Understanding the Prompt

When you open a terminal, you'll see something like this:

```
username@hostname:~$
```

Let's break it down:

| Part | Meaning |
|------|---------|
| `username` | Your user account name |
| `@` | Separator (just means "at") |
| `hostname` | The name of the machine you're on |
| `:` | Separator |
| `~` | Your current directory (`~` means your home directory) |
| `$` | Indicates you're a normal user (a `#` means root/admin) |

The prompt tells you **who you are**, **where you are**, and **what machine you're on** — all before you even type a command.

## Your First Commands

### `whoami` — Who am I?

Prints your username.

```bash
$ whoami
student
```

### `hostname` — What machine is this?

Prints the name of the computer you're connected to.

```bash
$ hostname
linux-workshop
```

### `date` — What time is it?

Shows the current date and time.

```bash
$ date
Thu Feb 13 14:30:00 EST 2026
```

### `echo` — Say something

Prints whatever text you give it back to the screen.

```bash
$ echo "Hello, Linux!"
Hello, Linux!
```

You can also use it to do basic math with `$(( ))`:

```bash
$ echo $(( 2 + 2 ))
4
```

### `uptime` — How long has this machine been running?

```bash
$ uptime
 14:30:00 up 3 days, 2:15,  1 user,  load average: 0.08, 0.03, 0.01
```

### `clear` — Clean up the screen

If your terminal gets cluttered, `clear` wipes it clean. You can also press **Ctrl+L** as a shortcut.

```bash
$ clear
```

## Commands, Options, and Arguments

Most Linux commands follow this pattern:

```
command [options] [arguments]
```

- **Command**: The program to run (e.g., `date`)
- **Options**: Modify the command's behavior, usually start with `-` or `--` (e.g., `date -u` for UTC time)
- **Arguments**: What the command acts on (e.g., `echo "hello"` — the text is the argument)

Examples:

```bash
$ date              # No options, no arguments
$ date -u           # Option: show time in UTC
$ echo "hey there"  # Argument: the text to print
$ echo -n "no newline"  # Option + argument: -n suppresses the trailing newline
```

## Keyboard Shortcuts

These will save you a lot of time:

| Shortcut | Action |
|----------|--------|
| **Ctrl+C** | Cancel the current command |
| **Ctrl+L** | Clear the screen (same as `clear`) |
| **Up Arrow** | Recall previous command |
| **Down Arrow** | Go forward through command history |
| **Tab** | Auto-complete file names and commands |
| **Ctrl+A** | Jump to the beginning of the line |
| **Ctrl+E** | Jump to the end of the line |

Try pressing **Tab** after typing a partial command — the shell will try to complete it for you. If there are multiple matches, press **Tab** twice to see all options.

## Exercises

1. Run `whoami` and `hostname`. What user are you logged in as? What machine are you on?

2. Run `date`. Now run `date -u`. What's the difference?

3. Use `echo` to print your name to the screen.

4. Use `echo` and `$(( ))` to calculate `123 * 456`.

5. Run `uptime`. How long has your machine been running?

6. Try pressing the **Up Arrow** a few times. What happens? This is your **command history** — every command you type is saved so you can recall it later.

7. Type `ech` and press **Tab**. What happens? Now type `echo` and press **Tab** twice. What do you see?

8. Try running a command that doesn't exist, like `foobar`. Read the error message — what does it tell you?

## Quick Reference

| Command | Description |
|---------|-------------|
| `whoami` | Print your username |
| `hostname` | Print the machine name |
| `date` | Print the current date and time |
| `echo` | Print text to the screen |
| `uptime` | Show how long the system has been running |
| `clear` | Clear the terminal screen |

---

**Next:** [File System Navigation](../02-navigation/)
