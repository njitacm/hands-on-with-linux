# Challenge 5: System Information

Knowing how to check on your system's health is essential — whether you're troubleshooting a slow machine, checking if you're running low on disk space, or just trying to understand the hardware you're working with.

## Learning Objectives

- Check disk usage with `df` and `du`
- Monitor memory with `free`
- Get system identity with `uname` and `hostname`
- Check network basics with `ip` and `ss`
- Understand system uptime and load

## Disk Space: `df` and `du`

### `df` — Disk Free (Filesystem Level)

`df` shows how much space is used and available on each mounted filesystem:

```bash
$ df -h
```

The `-h` flag shows sizes in human-readable format (GB, MB).

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   22G   26G  46% /
tmpfs           3.9G     0  3.9G   0% /dev/shm
/dev/sda2       200G   89G  101G  47% /home
```

| Column | Meaning |
|--------|---------|
| `Filesystem` | The disk partition or device |
| `Size` | Total capacity |
| `Used` | Space consumed |
| `Avail` | Space remaining |
| `Use%` | Percentage full |
| `Mounted on` | Where it's accessible in the directory tree |

**Key insight:** If `Use%` hits 100% on `/`, your system may stop working properly. Keep an eye on it.

### `du` — Disk Usage (Directory Level)

`du` shows how much space a directory (and its contents) is using:

```bash
$ du -sh ~/Documents              # Summary of one directory
145M    /home/student/Documents

$ du -sh ~/*                      # Summary of everything in home
145M    /home/student/Documents
23M     /home/student/Downloads
1.2G    /home/student/projects
```

### Useful `du` Options

| Flag | Description |
|------|-------------|
| `-h` | Human-readable sizes |
| `-s` | Summary (total only, don't list subdirectories) |
| `-d N` | Limit depth to N levels |
| `--max-depth=1` | Same as `-d 1` |

### Finding What's Using the Most Space

```bash
$ du -sh ~/* | sort -rh | head -10
```

This shows the 10 largest items in your home directory, sorted by size.

A useful variation that goes one level deeper:

```bash
$ du -h --max-depth=1 /var | sort -rh | head -10
```

## Memory: `free`

`free` shows RAM (memory) usage:

```bash
$ free -h
              total        used        free      shared  buff/cache   available
Mem:          7.7Gi       2.1Gi       3.2Gi       256Mi       2.4Gi       5.1Gi
Swap:         2.0Gi          0B       2.0Gi
```

| Column | Meaning |
|--------|---------|
| `total` | Total physical RAM |
| `used` | RAM actively in use |
| `free` | Completely unused RAM |
| `buff/cache` | RAM used for disk caching (can be reclaimed) |
| `available` | RAM available for new programs (free + reclaimable cache) |

**Important:** `available` is what matters, not `free`. Linux uses "free" RAM for disk caching to speed things up, but that cache is released when programs need more memory. A system with low `free` but high `available` is perfectly healthy.

### Swap

Swap is disk space used as overflow when RAM runs out. If you see heavy swap usage, it means the system is running low on memory:

```bash
$ free -h | grep Swap
Swap:         2.0Gi       1.5Gi       500Mi     # This system is under memory pressure
```

## System Identity: `uname` and `hostname`

### `uname` — System Information

```bash
$ uname -a                    # Everything
Linux workshop 6.1.0-17-amd64 #1 SMP PREEMPT_DYNAMIC x86_64 GNU/Linux
```

### Useful `uname` Options

| Flag | Description |
|------|-------------|
| `-s` | Kernel name (e.g., `Linux`) |
| `-r` | Kernel release (e.g., `6.1.0-17-amd64`) |
| `-m` | Machine hardware (e.g., `x86_64` or `aarch64`) |
| `-n` | Hostname |
| `-a` | All of the above |

### `hostname` and Related

```bash
$ hostname                    # Short hostname
$ hostname -f                 # Fully qualified domain name (if configured)
```

### Distro Information

```bash
$ cat /etc/os-release         # Distribution name and version
$ lsb_release -a              # Another way (if installed)
```

## Uptime and Load

### `uptime`

```bash
$ uptime
 14:30:00 up 3 days, 2:15,  1 user,  load average: 0.08, 0.03, 0.01
```

### Load Average

The three load average numbers represent the average number of processes waiting for CPU time over the last 1, 5, and 15 minutes.

**Rule of thumb:** If the load average is consistently higher than the number of CPU cores, the system is overloaded.

```bash
$ nproc                       # How many CPU cores do you have?
4
```

A load of `4.00` on a 4-core system means 100% utilization. A load of `8.00` means processes are queuing up.

## Network Basics

### `ip` — Network Interfaces

```bash
$ ip addr                     # Show all network interfaces and IP addresses
$ ip addr show                # Same thing
$ ip route                    # Show routing table (where traffic goes)
```

To get just your IP address:

```bash
$ hostname -I                 # Your IP address(es)
```

### `ss` — Socket Statistics

`ss` replaced the older `netstat` command. It shows network connections:

```bash
$ ss -tuln                    # Show listening TCP and UDP ports
```

| Flag | Meaning |
|------|---------|
| `-t` | TCP connections |
| `-u` | UDP connections |
| `-l` | Only listening (waiting for connections) |
| `-n` | Show port numbers instead of service names |

## Other Useful Commands

### `lscpu` — CPU Information

```bash
$ lscpu
Architecture:          x86_64
CPU(s):                4
Model name:            Intel(R) Core(TM) i7-...
```

### `lsblk` — Block Devices (Disks)

```bash
$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0   256G  0 disk
├─sda1   8:1    0    50G  0 part /
└─sda2   8:2    0   200G  0 part /home
```

### `dmesg` — Kernel Messages

```bash
$ dmesg | tail -20            # Recent kernel messages (hardware events, etc.)
$ sudo dmesg | grep -i error  # Look for errors
```

## Exercises

1. Run `df -h`. How much total disk space does your system have? How much is used?

2. Use `du -sh` to check the size of this workshop directory. Then check your home directory.

3. Find the 5 largest directories in your home folder:
   ```bash
   du -sh ~/* | sort -rh | head -5
   ```

4. Run `free -h`. How much total RAM does your system have? How much is `available`? Is any swap being used?

5. Run `uname -a`. What kernel version are you running? What architecture?

6. Check what Linux distribution you're running:
   ```bash
   cat /etc/os-release
   ```

7. Run `uptime`. How long has your system been running? What's the load average?

8. Find how many CPU cores your system has with `nproc`. Is the load average (from `uptime`) higher or lower than the number of cores?

9. Use `ip addr` or `hostname -I` to find your system's IP address.

10. Use `ss -tuln` to see what ports are listening on your system. Can you identify any of the services?

11. **Bonus**: Write a one-line command that shows disk usage, memory usage, and uptime together:
    ```bash
    echo "=== Disk ===" && df -h / && echo "=== Memory ===" && free -h && echo "=== Uptime ===" && uptime
    ```

12. **Bonus**: Use `lsblk` to see your disk layout. How is the disk partitioned?

## Quick Reference

| Command | Description |
|---------|-------------|
| `df -h` | Show filesystem disk usage |
| `du -sh dir/` | Show directory size |
| `du -sh * \| sort -rh` | Find largest items |
| `free -h` | Show memory usage |
| `uname -a` | Show system information |
| `uname -r` | Show kernel version |
| `hostname` | Show hostname |
| `uptime` | Show uptime and load |
| `nproc` | Show number of CPU cores |
| `ip addr` | Show network interfaces |
| `ss -tuln` | Show listening ports |
| `lscpu` | Show CPU details |
| `lsblk` | Show disk layout |
| `cat /etc/os-release` | Show distro info |

---

**Previous:** [Environment Variables](../04-environment-variables/) | **Next Section:** [Shell Scripting & Automation](../../04-scripting/)
