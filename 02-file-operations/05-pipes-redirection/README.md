# Challenge 5: Pipes & Redirection

This is where the command line goes from useful to **powerful**. Pipes and redirection let you connect commands together, building complex data-processing workflows from simple building blocks. It's the Unix philosophy in action: small tools that do one thing well, combined together.

## Learning Objectives

- Redirect command output to files with `>` and `>>`
- Redirect file contents into commands with `<`
- Chain commands together with pipes (`|`)
- Understand stdin, stdout, and stderr
- Redirect error messages separately
- Build multi-step pipelines

## Practice Files

| File | Description |
|------|-------------|
| `access.log` | A web server access log (30 entries) |
| `words.txt` | A list of fruit names with duplicates |

## Standard Streams

Every Linux command has three standard **streams** — channels for data to flow in and out:

| Stream | Name | Number | Description |
|--------|------|--------|-------------|
| **stdin** | Standard Input | 0 | Where a command reads its input (default: keyboard) |
| **stdout** | Standard Output | 1 | Where a command writes its output (default: screen) |
| **stderr** | Standard Error | 2 | Where a command writes error messages (default: screen) |

By default, all three are connected to your terminal. Redirection lets you reconnect them to files or other commands.

```
              ┌──────────┐
  stdin ───►  │          │  ───► stdout (normal output)
  (input)     │ command  │
              │          │  ───► stderr (error messages)
              └──────────┘
```

## Output Redirection: `>` and `>>`

### `>` — Write Output to a File (Overwrite)

```bash
$ echo "Hello, World!" > greeting.txt
$ cat greeting.txt
Hello, World!
```

If the file already exists, `>` **overwrites** it completely:

```bash
$ echo "Goodbye!" > greeting.txt
$ cat greeting.txt
Goodbye!
```

### `>>` — Append Output to a File

```bash
$ echo "Line 1" > log.txt
$ echo "Line 2" >> log.txt
$ echo "Line 3" >> log.txt
$ cat log.txt
Line 1
Line 2
Line 3
```

The difference is critical:
- `>` **replaces** the entire file
- `>>` **adds to the end** of the file

### Redirecting Command Output

Any command's output can be redirected:

```bash
$ ls -la > file-listing.txt                 # Save a directory listing
$ date > timestamp.txt                       # Save the current date
$ sort words.txt > sorted-words.txt          # Save sorted output
$ grep "ERROR" access.log > errors-only.txt  # Save filtered results
```

## Input Redirection: `<`

Feed a file's contents into a command as input:

```bash
$ sort < words.txt
$ wc -l < access.log
```

In many cases, this is equivalent to passing the file as an argument (`sort words.txt`), but input redirection is important in scripts and when a command only reads from stdin.

## Error Redirection: `2>`

Error messages go to stderr (stream 2), which is separate from stdout. You can redirect them independently:

```bash
$ ls /nonexistent 2> errors.txt             # Redirect only errors to a file
$ cat errors.txt
ls: cannot access '/nonexistent': No such file or directory
```

### Redirecting Both stdout and stderr

```bash
$ ls /home /nonexistent > output.txt 2> errors.txt    # Separate files
$ ls /home /nonexistent > all-output.txt 2>&1          # Both to same file
$ ls /home /nonexistent &> all-output.txt              # Shorthand for both
```

The `2>&1` syntax means "redirect stream 2 (stderr) to the same place as stream 1 (stdout)."

### Discarding Output

Send output to `/dev/null` — a special file that discards everything written to it:

```bash
$ ls /nonexistent 2> /dev/null              # Suppress error messages
$ command > /dev/null 2>&1                   # Suppress ALL output
```

## Pipes: `|`

The pipe operator takes the **stdout of one command** and feeds it as **stdin to the next command**. This is the most powerful concept on this page.

```bash
$ command1 | command2 | command3
```

Data flows left to right: command1's output becomes command2's input, and command2's output becomes command3's input.

### Basic Pipe Examples

```bash
$ ls -la | less                             # Browse a long listing page by page
$ cat access.log | head -5                  # First 5 lines of the log
$ history | grep "git"                      # Find past git commands
$ cat words.txt | sort | uniq              # Sorted unique words
```

### Real-World Pipeline Examples

**Count how many unique IP addresses are in the access log:**

```bash
$ cut -d " " -f 1 access.log | sort | uniq | wc -l
```

Step by step:
1. `cut -d " " -f 1` — extract the first field (IP address)
2. `sort` — sort them (so duplicates are adjacent)
3. `uniq` — remove duplicates
4. `wc -l` — count the remaining lines

**Find the most active IP address:**

```bash
$ cut -d " " -f 1 access.log | sort | uniq -c | sort -rn | head -1
```

**Count requests by HTTP status code:**

```bash
$ grep -oE '" [0-9]{3} ' access.log | sort | uniq -c | sort -rn
```

**Find all 4xx and 5xx error responses:**

```bash
$ grep -E '" (4|5)[0-9]{2} ' access.log
```

## Building Pipelines Step by Step

The best way to build a pipeline is incrementally. Start with one command and add stages:

```bash
# Step 1: See the raw data
$ cat access.log

# Step 2: Extract just the URLs
$ cat access.log | cut -d '"' -f 2

# Step 3: Get just the paths (second word)
$ cat access.log | cut -d '"' -f 2 | cut -d ' ' -f 2

# Step 4: Sort and count unique pages
$ cat access.log | cut -d '"' -f 2 | cut -d ' ' -f 2 | sort | uniq -c | sort -rn
```

Each step, verify the output looks right before adding the next stage.

## `tee` — Write to a File AND the Screen

Sometimes you want to save output to a file while still seeing it in the terminal. `tee` splits the stream:

```bash
$ sort words.txt | uniq -c | tee results.txt
```

This displays the output AND saves it to `results.txt`. Without `tee`, you'd have to choose one or the other.

Use `tee -a` to append instead of overwrite:

```bash
$ date | tee -a log.txt
```

## Here Documents and Here Strings

### Here Document (`<<`)

Feed multiple lines of text into a command:

```bash
$ cat << EOF
This is line 1
This is line 2
This is line 3
EOF
```

The text between `<< EOF` and `EOF` is fed to `cat` as input. You can use any marker word, but `EOF` is conventional.

### Here String (`<<<`)

Feed a single string as input:

```bash
$ wc -w <<< "count these words"
3
```

## Exercises

1. Redirect the output of `date` to a file called `today.txt`. Verify its contents with `cat`.

2. Run `echo "Hello"` three times, appending (`>>`) to a file called `hellos.txt`. Verify it has three lines.

3. Use a pipe to count how many lines are in `access.log` without using the file as an argument (hint: `cat access.log | wc -l`).

4. Find all lines in `access.log` with status code `401` (unauthorized). Redirect the results to `failed-logins.txt`.

5. Build a pipeline to find the **5 most common words** in `words.txt`:
   ```bash
   sort words.txt | uniq -c | sort -rn | head -5
   ```

6. Extract all unique IP addresses from `access.log` and save them to `unique-ips.txt`.

7. Find the most requested URL path in `access.log`. Hint: extract the request field, then sort and count.

8. Use `tee` to sort `words.txt`, remove duplicates, display the result, AND save it to `unique-words.txt` — all in one pipeline.

9. Try running `ls /nonexistent`. You'll see an error. Now redirect only the error to `/dev/null`. The command should produce no output at all.

10. Run a command that produces both regular output and errors:
    ```bash
    ls /home /nonexistent
    ```
    Redirect stdout to `output.txt` and stderr to `errors.txt`. Check both files.

11. **Bonus**: Build a pipeline that analyzes `access.log` and produces a summary showing:
    - How many requests came from each IP address
    - Sorted by count (most requests first)

12. **Bonus**: Use a here document to create a file called `menu.txt` with a list of three menu items.

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `cmd > file` | Redirect stdout to file (overwrite) |
| `cmd >> file` | Redirect stdout to file (append) |
| `cmd < file` | Redirect file to stdin |
| `cmd 2> file` | Redirect stderr to file |
| `cmd &> file` | Redirect both stdout and stderr |
| `cmd 2>/dev/null` | Discard error messages |
| `cmd1 \| cmd2` | Pipe stdout of cmd1 into cmd2 |
| `cmd \| tee file` | Pipe and also save to file |
| `<< EOF ... EOF` | Here document (multi-line input) |
| `<<< "string"` | Here string (single-line input) |

---

**Previous:** [Text Processing & Comparison](../04-text-processing/) | **Next Section:** [Permissions, Processes & System Management](../../03-permissions-system/)
