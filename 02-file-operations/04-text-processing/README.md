# Challenge 4: Text Processing & Comparison

Linux was built by people who work with text. As a result, it has an incredibly rich set of tools for slicing, sorting, comparing, and transforming text data. These tools are the backbone of data processing on the command line.

## Learning Objectives

- Compare files and find differences with `diff`
- Sort text data with `sort`
- Find and remove duplicates with `uniq`
- Extract columns from structured data with `cut`
- Translate and transform characters with `tr`
- Count lines, words, and characters with `wc`

## Practice Files

| File | Description |
|------|-------------|
| `names.txt` | A list of names with duplicates |
| `report-v1.txt` | Version 1 of a project status report |
| `report-v2.txt` | Version 2 of the same report |
| `sales.csv` | Sales data in CSV format |
| `scores.txt` | A list of numeric test scores |
| `messy-data.txt` | Semicolon-delimited employee data |

## `diff` — Compare Two Files

`diff` shows you what changed between two files — line by line.

```bash
$ diff report-v1.txt report-v2.txt
```

### Reading `diff` Output

The default output uses a compact notation:

```
3c3
< Sprint: 14
---
> Sprint: 15
```

- `<` marks lines from the **first** file
- `>` marks lines from the **second** file
- `c` means **changed**, `a` means **added**, `d` means **deleted**

### Unified Diff Format

The `-u` flag shows a more readable format (the same format used in `git diff`):

```bash
$ diff -u report-v1.txt report-v2.txt
```

Lines starting with `-` were removed, lines starting with `+` were added.

### Side-by-Side Comparison

```bash
$ diff -y report-v1.txt report-v2.txt
$ diff --side-by-side --width=80 report-v1.txt report-v2.txt
```

### Other Useful Flags

| Flag | Description |
|------|-------------|
| `-u` | Unified format (most readable) |
| `-y` | Side-by-side comparison |
| `-q` | Only report whether files differ (no details) |
| `-r` | Recursively compare directories |
| `--color` | Colorize the output |

## `sort` — Sort Lines

`sort` arranges lines of text in order.

```bash
$ sort names.txt
```

### Useful `sort` Options

| Flag | Description |
|------|-------------|
| `-r` | Reverse order (descending) |
| `-n` | Numeric sort (so 10 comes after 9, not after 1) |
| `-u` | Remove duplicates while sorting (unique) |
| `-k N` | Sort by the Nth field (column) |
| `-t ","` | Set the field delimiter (default is whitespace) |

### Examples

```bash
$ sort names.txt                    # Alphabetical
$ sort -r names.txt                 # Reverse alphabetical
$ sort -n scores.txt                # Numeric (lowest to highest)
$ sort -rn scores.txt               # Numeric descending (highest first)
```

### Sorting CSV Data by Column

```bash
$ sort -t "," -k 4 -n sales.csv    # Sort by 4th column (quantity), numerically
```

Here `-t ","` sets the comma as the field separator, and `-k 4` sorts by the 4th field.

## `uniq` — Remove Duplicate Lines

`uniq` removes **consecutive** duplicate lines. This means you almost always want to `sort` first.

```bash
$ sort names.txt | uniq
```

### Useful `uniq` Options

| Flag | Description |
|------|-------------|
| `-c` | Prefix each line with its count |
| `-d` | Show only duplicated lines |
| `-u` | Show only unique lines (not duplicated) |

### Counting Occurrences

This is one of the most common text-processing patterns in Linux:

```bash
$ sort names.txt | uniq -c | sort -rn
```

This pipeline:
1. Sorts the names (so duplicates are adjacent)
2. Counts consecutive duplicates
3. Sorts by count (highest first)

The result tells you which names appear most often.

## `cut` — Extract Columns

`cut` pulls out specific fields (columns) from structured text.

### Cutting by Delimiter

```bash
$ cut -d "," -f 2 sales.csv        # Get the 2nd field (region)
$ cut -d "," -f 1,3 sales.csv      # Get fields 1 and 3 (date, product)
$ cut -d "," -f 2-4 sales.csv      # Get fields 2 through 4
```

| Flag | Description |
|------|-------------|
| `-d` | Set the delimiter (default is tab) |
| `-f N` | Extract field N |
| `-f N,M` | Extract fields N and M |
| `-f N-M` | Extract fields N through M |

### Cutting by Character Position

```bash
$ cut -c 1-10 report-v1.txt        # First 10 characters of each line
```

### Working with Different Delimiters

The `messy-data.txt` file uses semicolons instead of commas:

```bash
$ cut -d ";" -f 1,3 messy-data.txt     # Names and emails
```

## `tr` — Translate Characters

`tr` replaces or deletes characters. It reads from standard input, so you'll always use it with a pipe or redirection.

### Replacing Characters

```bash
$ echo "hello world" | tr 'a-z' 'A-Z'          # Convert to uppercase
HELLO WORLD

$ echo "HELLO WORLD" | tr 'A-Z' 'a-z'          # Convert to lowercase
hello world
```

### Replacing Delimiters

Convert semicolons to commas:

```bash
$ cat messy-data.txt | tr ';' ','
```

### Deleting Characters

```bash
$ echo "Hello, World!" | tr -d ','              # Delete all commas
Hello World!

$ echo "phone: 555-0101" | tr -d '-'            # Remove dashes
phone: 5550101
```

### Squeezing Repeated Characters

```bash
$ echo "too    many    spaces" | tr -s ' '      # Collapse multiple spaces
too many spaces
```

## `wc` — Count Things

You saw `wc` briefly in Section 1. It's also a key text-processing tool.

```bash
$ wc -l names.txt                   # How many names?
$ wc -l sales.csv                   # How many rows (including header)?
$ sort names.txt | uniq | wc -l     # How many unique names?
```

## Exercises

1. Run `diff -u report-v1.txt report-v2.txt`. What changed between the two versions? Which tasks were completed? Which blockers were resolved?

2. Sort `names.txt` alphabetically. Then sort it in reverse order.

3. How many times does each name appear in `names.txt`? Use `sort | uniq -c | sort -rn` to find out. Who appears most often?

4. Sort `scores.txt` numerically. What are the highest and lowest scores?

5. Extract just the "region" column (column 2) from `sales.csv`. Then pipe it through `sort | uniq -c | sort -rn` to see which region has the most sales entries.

6. Extract the "salesperson" column (column 6) from `sales.csv` and find who has the most sales records.

7. Use `cut` to extract names and email addresses (columns 1 and 3) from `messy-data.txt`.

8. Convert the semicolons in `messy-data.txt` to commas using `tr`, making it a proper CSV file. Redirect the output to a new file called `clean-data.csv`.

9. Use `wc -l` to count how many unique names are in `names.txt`. Hint: pipe `sort | uniq` into `wc -l`.

10. Extract all the product names from `sales.csv` (column 3), sort them, remove duplicates, and count how many unique products there are — all in one pipeline.

11. **Bonus**: Use `diff -r` to compare two directories (try comparing `../03-searching/sample-project/src/` with `../03-searching/sample-project/tests/`). What does it show?

12. **Bonus**: Create a pipeline that converts `messy-data.txt` into a nicely formatted output showing just names and departments, with commas replaced by tabs:
    ```bash
    cut -d ";" -f 1,2 messy-data.txt | tr ';' '\t'
    ```

## Quick Reference

| Command | Description |
|---------|-------------|
| `diff file1 file2` | Compare two files |
| `diff -u file1 file2` | Unified diff format |
| `diff -y file1 file2` | Side-by-side comparison |
| `sort file` | Sort lines alphabetically |
| `sort -n file` | Sort numerically |
| `sort -r file` | Sort in reverse |
| `sort -t "," -k N file` | Sort by Nth field with delimiter |
| `uniq` | Remove consecutive duplicates |
| `uniq -c` | Count duplicates |
| `cut -d "," -f N file` | Extract field N using delimiter |
| `tr 'a' 'b'` | Replace character a with b |
| `tr -d 'x'` | Delete character x |
| `tr -s ' '` | Squeeze repeated spaces |
| `wc -l file` | Count lines |

---

**Previous:** [Searching & Filtering](../03-searching/) | **Next:** [Pipes & Redirection](../05-pipes-redirection/)
