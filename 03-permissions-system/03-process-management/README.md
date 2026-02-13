# Challenge 3: Process Management

Every command you run, every application you open, every service on the system — they're all **processes**. Linux gives you powerful tools to see what's running, control it, and stop it when needed.

## Learning Objectives

- View running processes with `ps` and `top`/`htop`
- Understand foreground and background jobs
- Move jobs between foreground and background
- Send signals to processes with `kill`
- Use keyboard shortcuts to control processes

## Practice Files

| File | Description |
|------|-------------|
| `busy-loop.sh` | A script that loops until you stop it |
| `cpu-eater.sh` | A script that uses CPU for 30 seconds |

## What Is a Process?

A **process** is a running instance of a program. When you type `ls`, a process is created, it runs, produces output, and exits. When you run a web server, a process starts and keeps running.

Every process has:

| Property | Description |
|----------|-------------|
| **PID** | Process ID — a unique number |
| **PPID** | Parent PID — the process that started it |
| **User** | The user account it's running as |
| **State** | Running, sleeping, stopped, zombie, etc. |
| **CPU/Memory** | Resources it's consuming |

## `ps` — Snapshot of Processes

`ps` shows a snapshot of running processes at the moment you run it.

```bash
$ ps
    PID TTY          TIME CMD
   1234 pts/0    00:00:00 bash
   5678 pts/0    00:00:00 ps
```

### Useful `ps` Options

```bash
$ ps aux                    # Show ALL processes from ALL users
$ ps aux | head -20         # First 20 processes
$ ps aux | grep python      # Find Python processes
$ ps -ef                    # Another common format (full listing)
$ ps -u $USER               # Only your processes
```

### Reading `ps aux` Output

```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1 169316 11884 ?        Ss   Feb10   0:03 /sbin/init
student   1234  0.0  0.0  10020  3456 pts/0    Ss   08:00   0:00 bash
```

Key columns:

| Column | Meaning |
|--------|---------|
| `USER` | Who owns the process |
| `PID` | Process ID |
| `%CPU` | CPU usage percentage |
| `%MEM` | Memory usage percentage |
| `STAT` | State (S=sleeping, R=running, Z=zombie, T=stopped) |
| `COMMAND` | The command that started the process |

## `top` — Live Process Monitor

`top` shows a continuously updating view of processes, sorted by CPU usage:

```bash
$ top
```

### Navigating `top`

| Key | Action |
|-----|--------|
| `q` | Quit |
| `M` | Sort by memory usage |
| `P` | Sort by CPU usage (default) |
| `k` | Kill a process (enter PID when prompted) |
| `u` | Filter by user |
| `1` | Toggle per-CPU core display |
| `h` | Help |

### The `top` Header

The first few lines show system-wide stats:

```
top - 14:30:00 up 3 days,  2:15,  1 user,  load average: 0.08, 0.03, 0.01
Tasks: 195 total,   1 running, 194 sleeping,   0 stopped,   0 zombie
%Cpu(s):  2.3 us,  0.5 sy,  0.0 ni, 97.0 id,  0.2 wa,  0.0 hi,  0.0 si
MiB Mem :  7851.4 total,  3245.2 free,  2156.8 used,  2449.4 buff/cache
```

| Line | Meaning |
|------|---------|
| **Load average** | System load over 1, 5, and 15 minutes |
| **Tasks** | Total processes and their states |
| **%Cpu** | CPU usage breakdown (us=user, sy=system, id=idle) |
| **Mem** | Memory usage |

## `htop` — A Better `top`

`htop` is an improved version of `top` with color, mouse support, and easier navigation:

```bash
$ htop
```

`htop` may need to be installed on some systems (`sudo apt install htop`).

Key advantages over `top`:
- Color-coded CPU and memory bars
- Scroll through the process list
- Click to sort by columns
- Press F9 to kill a process with a menu
- Press F5 for tree view (shows parent-child relationships)

## Foreground and Background Jobs

### Running in the Background with `&`

Add `&` to the end of a command to run it in the background:

```bash
$ ./busy-loop.sh &
[1] 12345
```

The shell tells you the **job number** (`[1]`) and the **PID** (`12345`). You get your prompt back immediately.

### `jobs` — List Background Jobs

```bash
$ jobs
[1]+  Running                 ./busy-loop.sh &
```

### `fg` — Bring a Job to the Foreground

```bash
$ fg %1                 # Bring job 1 to the foreground
$ fg                    # Bring the most recent background job forward
```

### `bg` — Resume a Stopped Job in the Background

If you stop a foreground process with Ctrl+Z, you can resume it in the background:

```bash
$ ./busy-loop.sh        # Running in foreground
^Z                       # Press Ctrl+Z to stop it
[1]+  Stopped                 ./busy-loop.sh

$ bg %1                 # Resume it in the background
[1]+ ./busy-loop.sh &
```

### The Ctrl+Z → bg Pattern

This is a very common workflow:

1. Start a command and realize it's going to take a while
2. Press **Ctrl+Z** to suspend it
3. Run `bg` to resume it in the background
4. Continue working in the terminal

## Signals and `kill`

**Signals** are messages you send to processes. The `kill` command sends signals (despite its name, it doesn't always kill things).

### Sending Signals

```bash
$ kill 12345              # Send SIGTERM (graceful shutdown) to PID 12345
$ kill -9 12345           # Send SIGKILL (force kill) to PID 12345
$ kill %1                 # Send SIGTERM to job 1
```

### Common Signals

| Signal | Number | Meaning |
|--------|--------|---------|
| `SIGTERM` | 15 | Terminate gracefully (default) |
| `SIGKILL` | 9 | Force kill immediately (cannot be caught) |
| `SIGSTOP` | 19 | Pause/stop the process |
| `SIGCONT` | 18 | Resume a stopped process |
| `SIGINT` | 2 | Interrupt (same as Ctrl+C) |
| `SIGTSTP` | 20 | Terminal stop (same as Ctrl+Z) |

### Kill Etiquette

Always try `kill` (SIGTERM) first. This gives the process a chance to clean up (save files, close connections). Only use `kill -9` (SIGKILL) as a last resort when the process won't respond.

```bash
$ kill 12345              # Try this first
$ kill -9 12345           # Only if the above doesn't work
```

### `killall` — Kill by Name

```bash
$ killall busy-loop.sh    # Kill all processes with this name
```

### `pkill` — Kill by Pattern

```bash
$ pkill -f "busy-loop"    # Kill processes matching the pattern
```

## Keyboard Shortcuts for Processes

| Shortcut | Signal | Effect |
|----------|--------|--------|
| **Ctrl+C** | SIGINT | Interrupt and stop the foreground process |
| **Ctrl+Z** | SIGTSTP | Suspend the foreground process |
| **Ctrl+\\** | SIGQUIT | Quit and dump core (stronger than Ctrl+C) |

## Finding Processes

### `pgrep` — Find PIDs by Name

```bash
$ pgrep bash              # PIDs of all bash processes
$ pgrep -u $USER          # All your processes
$ pgrep -a python         # PIDs and full command lines for Python processes
```

### The `ps aux | grep` Pattern

A classic approach:

```bash
$ ps aux | grep "busy-loop"
```

## Exercises

1. Run `ps aux` and pipe it to `less`. Browse through the list. How many processes are running?

2. Run `ps aux | grep bash`. What do you see? Notice that the `grep` command itself shows up in the results.

3. Open `top`. Let it run for a few seconds and observe. Which process is using the most CPU? Press `M` to sort by memory. Press `q` to quit.

4. Run `./busy-loop.sh` in the foreground. Watch it print messages. Press **Ctrl+C** to stop it.

5. Run `./busy-loop.sh &` in the background. Run `jobs` to see it listed. Use `fg` to bring it to the foreground, then **Ctrl+C** to stop it.

6. Run `./busy-loop.sh` in the foreground. Press **Ctrl+Z** to suspend it. Run `jobs` to see it stopped. Use `bg` to resume it in the background. Finally, use `kill %1` to terminate it.

7. Run `./cpu-eater.sh &` in the background. Open `top` or `htop` and find it. Watch its CPU usage. It will stop after 30 seconds.

8. Run `./busy-loop.sh &` twice (two separate background jobs). Use `jobs` to see both. Kill one by job number (`kill %1`) and the other by PID. Verify they're gone with `jobs`.

9. Use `pgrep` to find the PID of your bash shell. Then use `ps -p <PID>` to get details about it.

10. **Bonus**: Run `./busy-loop.sh &` and use `kill -STOP` to pause it (it should stop printing). Then use `kill -CONT` to resume it. This is manual SIGSTOP/SIGCONT.

## Quick Reference

| Command | Description |
|---------|-------------|
| `ps aux` | Show all running processes |
| `ps aux \| grep name` | Find processes by name |
| `top` | Live process monitor |
| `htop` | Enhanced process monitor |
| `jobs` | List background jobs |
| `fg %N` | Bring job N to foreground |
| `bg %N` | Resume job N in background |
| `command &` | Run command in background |
| `kill PID` | Send SIGTERM to a process |
| `kill -9 PID` | Force kill a process |
| `killall name` | Kill all processes by name |
| `pgrep name` | Find PIDs by name |
| **Ctrl+C** | Stop foreground process |
| **Ctrl+Z** | Suspend foreground process |

---

**Previous:** [Users & Groups](../02-users-groups/) | **Next:** [Environment Variables](../04-environment-variables/)
