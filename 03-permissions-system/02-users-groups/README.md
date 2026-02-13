# Challenge 2: Users & Groups

Linux was designed for multiple users from the start. Every file is owned by a user and a group, every process runs as a user, and permissions tie it all together. Understanding users and groups is how you make sense of access control.

## Learning Objectives

- Understand the user and group model in Linux
- Inspect user and group information
- Understand what `sudo` does and when to use it
- Know where user information is stored
- Understand the difference between root and regular users

## Users in Linux

Every person (and every service) that interacts with a Linux system has a **user account**. Each user has:

| Property | Description |
|----------|-------------|
| **Username** | A human-readable name (e.g., `alice`) |
| **UID** | A numeric user ID (e.g., `1000`) |
| **Home directory** | Their personal space (e.g., `/home/alice`) |
| **Default shell** | The shell they get when they log in (e.g., `/bin/bash`) |
| **Primary group** | The group they belong to by default |

### Viewing Your User Info

```bash
$ whoami                    # Your username
student

$ id                        # Your UID, GID, and all group memberships
uid=1000(student) gid=1000(student) groups=1000(student),27(sudo),100(users)

$ id -u                     # Just your UID
1000

$ id -gn                    # Just your primary group name
student
```

### Viewing Other Users

```bash
$ id alice                  # Info about another user
$ who                       # Who is currently logged in
$ w                         # Who's logged in and what are they doing
$ last                      # Recent login history
```

## Groups

Groups let you manage permissions for collections of users. Instead of granting access to each person individually, you add them to a group and set permissions for the group.

```bash
$ groups                    # List your groups
student sudo users

$ groups alice              # List another user's groups
```

### How Groups Work with Permissions

Remember from the permissions challenge:

```
-rw-rw-r-- 1 alice developers project.txt
```

This file is owned by `alice` and belongs to the `developers` group. Any member of the `developers` group can read and write it.

## The Root User

`root` (UID 0) is the **superuser** — the all-powerful administrator account. Root can:

- Read, write, and execute any file regardless of permissions
- Install and remove software
- Create and delete user accounts
- Change system configuration
- Start and stop services

**You should almost never log in as root directly.** Instead, use `sudo`.

## `sudo` — Do Something as Root

`sudo` (**S**uper **U**ser **Do**) lets you run a single command with root privileges:

```bash
$ cat /etc/shadow
cat: /etc/shadow: Permission denied

$ sudo cat /etc/shadow
[sudo] password for student:
(contents of shadow file)
```

You'll be asked for **your** password (not root's), and the system checks whether your user is allowed to use `sudo`.

### Common `sudo` Usage

```bash
$ sudo apt update                  # Update package lists
$ sudo systemctl restart nginx     # Restart a service
$ sudo chown root:root file.txt    # Change ownership to root
$ sudo vim /etc/hosts              # Edit a system config file
```

### `sudo` Safety

- Only use `sudo` when you actually need elevated privileges
- Never run `sudo rm -rf /` or similar destructive commands
- If a command works without `sudo`, don't add it
- `sudo` usage is logged — administrators can see what you did

### Checking Sudo Access

```bash
$ sudo -l                  # List what you're allowed to do with sudo
```

## Where User Information Lives

| File | Contents |
|------|----------|
| `/etc/passwd` | User accounts (username, UID, home dir, shell) |
| `/etc/group` | Group definitions and memberships |
| `/etc/shadow` | Encrypted passwords (root-only access) |

### Reading `/etc/passwd`

```bash
$ cat /etc/passwd
```

Each line represents a user:

```
student:x:1000:1000:Student User:/home/student:/bin/bash
```

| Field | Meaning |
|-------|---------|
| `student` | Username |
| `x` | Password (stored in `/etc/shadow` instead) |
| `1000` | UID |
| `1000` | Primary GID |
| `Student User` | Full name / comment |
| `/home/student` | Home directory |
| `/bin/bash` | Default shell |

### Reading `/etc/group`

```bash
$ cat /etc/group
```

```
developers:x:1001:alice,bob,carol
```

| Field | Meaning |
|-------|---------|
| `developers` | Group name |
| `x` | Password (rarely used) |
| `1001` | GID |
| `alice,bob,carol` | Members |

## System Users vs Regular Users

Not every user is a real person. Linux creates **system users** for running services:

| User | Purpose |
|------|---------|
| `root` | Superuser (UID 0) |
| `www-data` | Web server processes |
| `nobody` | Unprivileged user for services |
| `sshd` | SSH daemon |
| `mysql` | MySQL database |

System users typically have UIDs below 1000 and don't have login shells. Regular users start at UID 1000.

You can see this in `/etc/passwd`:

```bash
$ grep "/bin/bash" /etc/passwd      # Users with a real login shell
$ grep "nologin" /etc/passwd        # System users that can't log in
```

## User Management Commands

These commands require `sudo`:

| Command | Description |
|---------|-------------|
| `sudo useradd username` | Create a new user |
| `sudo userdel username` | Delete a user |
| `sudo usermod -aG group user` | Add a user to a group |
| `sudo passwd username` | Set/change a user's password |
| `sudo groupadd groupname` | Create a new group |
| `sudo groupdel groupname` | Delete a group |

### Important Flags

```bash
$ sudo useradd -m -s /bin/bash newuser     # Create user with home dir and bash shell
$ sudo usermod -aG sudo newuser            # Add user to sudo group
```

The `-a` in `-aG` is critical — it means **append** to the group list. Without `-a`, `usermod -G` **replaces** all group memberships, which can lock a user out of everything.

## Exercises

1. Run `id` to see your UID, GID, and group memberships. What groups are you in?

2. Run `who` and `w` to see who's currently logged into the system. What extra information does `w` show that `who` doesn't?

3. Read `/etc/passwd`. How many user accounts exist on the system? How many have `/bin/bash` as their shell? (Hint: use `grep` and `wc -l`.)

4. Read `/etc/group`. Find a group that has multiple members.

5. Try to read `/etc/shadow` without sudo. What happens? Now try with `sudo`. Why is this file restricted?

6. Run `id` for the `root` user. What is root's UID?
   ```bash
   id root
   ```

7. Count how many system users (UID < 1000) vs regular users (UID >= 1000) exist on your system. Hint: look at the third field in `/etc/passwd`.

8. Run `sudo -l` to see what sudo privileges you have.

9. **Bonus**: If you have sudo access, create a new group called `workshop`, then add your user to it:
   ```bash
   sudo groupadd workshop
   sudo usermod -aG workshop $USER
   ```
   Run `groups` to verify. (You may need to log out and back in for it to take effect.)

10. **Bonus**: Find all users on the system that can't log in (their shell is `/usr/sbin/nologin` or `/bin/false`). These are system/service accounts.

## Quick Reference

| Command | Description |
|---------|-------------|
| `whoami` | Print your username |
| `id` | Print your UID, GID, and groups |
| `groups` | List your group memberships |
| `who` | Show who's logged in |
| `w` | Show who's logged in and their activity |
| `last` | Show recent login history |
| `sudo command` | Run command as root |
| `sudo -l` | List your sudo privileges |
| `sudo useradd -m user` | Create a new user |
| `sudo usermod -aG group user` | Add user to a group |
| `sudo passwd user` | Change a user's password |

---

**Previous:** [File Permissions](../01-file-permissions/) | **Next:** [Process Management](../03-process-management/)
