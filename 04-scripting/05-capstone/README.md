# Challenge 5: Putting It All Together

This is the capstone. You've learned commands, navigation, file operations, permissions, processes, variables, scripting, conditionals, loops, and functions. Now you'll combine everything to solve real-world problems.

This challenge introduces a few new tools (`awk`, `sed`, and package management) and then gives you open-ended projects to work through.

## Learning Objectives

- Use `awk` for column-based text processing
- Use `sed` for stream editing and find-and-replace
- Understand basic package management
- Combine everything you've learned into practical scripts

## Practice Files

| File | Description |
|------|-------------|
| `students.csv` | Student records with GPA, major, and year |
| `log-data/` | Three days of application logs |

## `awk` — Pattern Scanning and Processing

`awk` is a programming language designed for processing structured text. You don't need to learn all of it — even basic usage is incredibly powerful.

### The Basics

`awk` processes input line by line and splits each line into fields:

```bash
$ echo "Alice 25 Engineering" | awk '{print $1}'
Alice

$ echo "Alice 25 Engineering" | awk '{print $1, $3}'
Alice Engineering
```

| Variable | Meaning |
|----------|---------|
| `$0` | The entire line |
| `$1`, `$2`, ... | Individual fields |
| `NF` | Number of fields on the current line |
| `NR` | Current line number |

### Setting the Field Separator

By default, `awk` splits on whitespace. Use `-F` for other delimiters:

```bash
$ awk -F ',' '{print $2}' students.csv
name
Alice Chen
Bob Martinez
...
```

### Filtering Lines

```bash
# Print only lines where the 5th field (GPA) is >= 3.5
$ awk -F ',' '$5 >= 3.5' students.csv

# Print only Computer Science students
$ awk -F ',' '$4 == "Computer Science"' students.csv

# Skip the header line
$ awk -F ',' 'NR > 1 {print $2, $5}' students.csv
```

### Formatted Output

```bash
$ awk -F ',' 'NR > 1 {printf "%-20s GPA: %s\n", $2, $5}' students.csv
Alice Chen            GPA: 3.8
Bob Martinez          GPA: 3.2
...
```

### Calculations

```bash
# Calculate average GPA
$ awk -F ',' 'NR > 1 {sum += $5; count++} END {print "Average GPA:", sum/count}' students.csv
```

The `END` block runs after all lines have been processed.

### Common `awk` Patterns

```bash
# Count lines matching a pattern
awk '/ERROR/ {count++} END {print count}' logfile

# Sum a column
awk -F ',' 'NR > 1 {sum += $4} END {print sum}' data.csv

# Print unique values in a column
awk -F ',' 'NR > 1 {seen[$4]++} END {for (k in seen) print k, seen[k]}' students.csv
```

## `sed` — Stream Editor

`sed` transforms text as it flows through — find and replace, delete lines, insert text, and more. The most common use is substitution.

### Find and Replace

```bash
$ echo "Hello World" | sed 's/World/Linux/'
Hello Linux
```

The syntax is `s/pattern/replacement/flags`.

### Replace in a File

```bash
# Preview the change (prints to screen, doesn't modify file)
$ sed 's/old/new/g' filename.txt

# Actually modify the file in place
$ sed -i 's/old/new/g' filename.txt
```

| Flag | Meaning |
|------|---------|
| `g` | Replace all occurrences on each line (not just the first) |
| `i` | Case-insensitive matching (GNU sed) |
| `-i` | Edit the file in place |

### Deleting Lines

```bash
# Delete line 3
$ sed '3d' file.txt

# Delete lines matching a pattern
$ sed '/DEBUG/d' logfile

# Delete blank lines
$ sed '/^$/d' file.txt
```

### Printing Specific Lines

```bash
# Print only lines 5-10
$ sed -n '5,10p' file.txt

# Print lines matching a pattern
$ sed -n '/ERROR/p' logfile
```

The `-n` flag suppresses normal output, so only lines you explicitly `p`rint are shown.

### Practical `sed` Examples

```bash
# Remove comment lines (starting with #)
$ sed '/^#/d' config.txt

# Add a prefix to every line
$ sed 's/^/>> /' file.txt

# Remove trailing whitespace
$ sed 's/[[:space:]]*$//' file.txt

# Replace first occurrence on each line only
$ sed 's/foo/bar/' file.txt

# Replace all occurrences
$ sed 's/foo/bar/g' file.txt
```

## Package Management

Linux distributions use package managers to install, update, and remove software.

### Debian/Ubuntu (apt)

```bash
$ sudo apt update                   # Refresh package lists
$ sudo apt install <package>        # Install a package
$ sudo apt remove <package>         # Remove a package
$ sudo apt upgrade                  # Upgrade all installed packages
$ apt search <keyword>              # Search for packages
$ apt list --installed              # List installed packages
```

### Red Hat/Fedora (dnf/yum)

```bash
$ sudo dnf install <package>        # Install
$ sudo dnf remove <package>         # Remove
$ sudo dnf update                   # Update all packages
$ dnf search <keyword>              # Search
```

### Useful Packages to Know About

| Package | Description |
|---------|-------------|
| `htop` | Better process monitor |
| `tree` | Directory tree visualization |
| `jq` | JSON processor for the command line |
| `curl` | Transfer data from URLs |
| `wget` | Download files from the web |
| `tmux` | Terminal multiplexer (multiple sessions) |
| `git` | Version control |
| `shellcheck` | Bash script linter |

### Checking if Something Is Installed

```bash
$ command -v htop && echo "installed" || echo "not installed"
$ which tree
$ dpkg -l | grep package-name       # Debian/Ubuntu
```

## Capstone Projects

These are open-ended projects. Each one requires combining multiple skills from the entire workshop.

### Project 1: Log Analyzer

Write a script called `log-analyzer.sh` that analyzes the files in `log-data/` and produces a summary report.

**Requirements:**
- Accept a log directory as an argument (default to `log-data/`)
- For each log file, report:
  - Total number of entries
  - Count of INFO, WARN, and ERROR entries
  - List of unique users who logged in
- Produce a combined summary across all log files
- Save the report to a file

**Hints:**
- Use `grep -c` to count patterns
- Use `grep "User login" | awk '{print $NF}'` to extract usernames
- Use functions for each part of the analysis
- Use a `for` loop over `*.log` files

### Project 2: Student Report Generator

Write a script called `student-report.sh` that processes `students.csv` and generates reports.

**Requirements:**
- List students by major (grouped)
- Calculate average GPA per major
- Find the highest and lowest GPA
- List all students on the Dean's List (GPA >= 3.5)
- Accept command-line options to select which report to generate

**Hints:**
- Use `awk -F ','` to process CSV fields
- Use `sort -t ',' -k 5 -rn` to sort by GPA
- Use functions for each report type
- Use `case` to handle command-line options

### Project 3: System Health Check

Write a script called `health-check.sh` that performs a system health check and reports issues.

**Requirements:**
- Check disk usage (warn if any filesystem is over 80%)
- Check memory usage (warn if available memory is low)
- Check system load (warn if load exceeds CPU count)
- Check if key services are running (e.g., sshd)
- Use colored output for OK/WARNING/CRITICAL status
- Log results to a file with timestamps

**Hints:**
- Use `df -h` and `awk` to parse disk usage
- Use `free` and `awk` to parse memory
- Use `uptime` or `/proc/loadavg` for load
- Color codes: `\033[32m` (green), `\033[33m` (yellow), `\033[31m` (red), `\033[0m` (reset)

### Project 4: File Organizer

Write a script called `organizer.sh` that takes a messy directory and organizes files by type.

**Requirements:**
- Accept a source directory as an argument
- Create subdirectories: `documents/`, `images/`, `scripts/`, `data/`, `other/`
- Sort files by extension into the correct subdirectory
- Handle files with no extension
- Provide a dry-run mode (`-n` flag) that shows what would happen
- Log all moves to a log file

**Hints:**
- Use `${filename##*.}` to extract the file extension
- Use `case` to map extensions to categories
- Use a function for the move-or-log logic

## Exercises

1. Use `awk` to print only the names and GPAs of Computer Science students from `students.csv`.

2. Use `awk` to calculate the average GPA across all students.

3. Use `sed` to replace all occurrences of "ERROR" with "**ERROR**" in one of the log files (print to screen, don't modify the file).

4. Use `sed` to extract just the timestamps from a log file (delete everything after the `]`).

5. Write a one-liner that counts how many unique users logged in across all three log files.

6. Check if `tree` and `htop` are installed on your system. Install any that are missing (if you have sudo access).

7. Complete **Project 1** (Log Analyzer) — start simple and add features incrementally.

8. Complete **Project 2** (Student Report Generator) — focus on getting one report working, then add more.

9. **Bonus**: Complete **Project 3** (System Health Check) or **Project 4** (File Organizer).

10. **Bonus**: Run `shellcheck` on any of your scripts (install it first if needed). Fix any issues it identifies.

## Quick Reference

### awk

| Command | Description |
|---------|-------------|
| `awk '{print $1}' file` | Print first field |
| `awk -F ',' '{print $2}' file` | Use comma as delimiter |
| `awk '$3 > 10' file` | Filter by condition |
| `awk 'NR > 1' file` | Skip header line |
| `awk '{sum+=$1} END {print sum}' file` | Sum a column |

### sed

| Command | Description |
|---------|-------------|
| `sed 's/old/new/' file` | Replace first occurrence per line |
| `sed 's/old/new/g' file` | Replace all occurrences |
| `sed -i 's/old/new/g' file` | Edit file in place |
| `sed '/pattern/d' file` | Delete matching lines |
| `sed -n '5,10p' file` | Print lines 5-10 |

### Package Management (apt)

| Command | Description |
|---------|-------------|
| `sudo apt update` | Refresh package lists |
| `sudo apt install pkg` | Install a package |
| `sudo apt remove pkg` | Remove a package |
| `apt search keyword` | Search for packages |

---

**Previous:** [Functions & Arguments](../04-functions/) | **Back to:** [Workshop Home](../../)

Congratulations on completing the Linux Crash Course! You now have a solid foundation for working with Linux systems. Keep practicing, keep experimenting, and keep building.
