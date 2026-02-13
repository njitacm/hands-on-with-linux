# Challenge 3: Loops

Loops let scripts repeat actions — process every file in a directory, read every line of a file, retry an operation, or count through a range. If you find yourself doing the same thing multiple times, a loop can do it for you.

## Learning Objectives

- Iterate over lists with `for` loops
- Process files and command output with `for`
- Repeat while a condition holds with `while` loops
- Read files line by line
- Control loops with `break` and `continue`
- Use C-style `for` loops and `until` loops

## Practice Files

| File | Description |
|------|-------------|
| `servers.txt` | A list of server hostnames |
| `urls.txt` | A list of URLs |
| `rename-me/` | A directory of files to batch rename |

## `for` Loops

### Iterating Over a List

```bash
for fruit in apple banana cherry; do
    echo "I like $fruit"
done
```

Output:
```
I like apple
I like banana
I like cherry
```

### Iterating Over Files

```bash
for file in *.txt; do
    echo "Found file: $file"
done
```

This is one of the most common uses — do something to every file matching a pattern.

### Iterating Over a Range

```bash
for i in {1..5}; do
    echo "Number: $i"
done
```

Output:
```
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

With a step:

```bash
for i in {0..20..5}; do
    echo "$i"
done
# Output: 0, 5, 10, 15, 20
```

### Iterating Over Command Output

```bash
for user in $(who | cut -d ' ' -f 1 | sort -u); do
    echo "Logged in: $user"
done
```

### Iterating Over Lines in a File

```bash
for server in $(cat servers.txt); do
    echo "Pinging $server..."
done
```

**Note:** This approach has issues with lines containing spaces. For robust line-by-line reading, use `while read` (covered below).

### C-Style `for` Loop

```bash
for ((i = 0; i < 10; i++)); do
    echo "Count: $i"
done
```

This is useful when you need a counter with specific start, end, and step values.

## `while` Loops

A `while` loop repeats as long as a condition is true:

```bash
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

### Reading a File Line by Line

This is the proper way to process a file line by line, even if lines contain spaces:

```bash
while IFS= read -r line; do
    echo "Line: $line"
done < servers.txt
```

| Part | Purpose |
|------|---------|
| `IFS=` | Preserve leading/trailing whitespace |
| `read -r` | Don't interpret backslashes |
| `< servers.txt` | Feed the file into the loop |

### Piping Into a While Loop

```bash
cat servers.txt | while read -r server; do
    echo "Processing: $server"
done
```

### Reading with Multiple Fields

If each line has multiple fields:

```bash
echo "alice:25:engineering" | while IFS=: read -r name age dept; do
    echo "$name is $age, works in $dept"
done
```

### Infinite Loop

```bash
while true; do
    echo "Running... (Ctrl+C to stop)"
    sleep 2
done
```

### Waiting for a Condition

```bash
while [ ! -f /tmp/ready.flag ]; do
    echo "Waiting for ready flag..."
    sleep 1
done
echo "Ready!"
```

## `until` Loops

`until` is the opposite of `while` — it loops until the condition becomes true:

```bash
count=1
until [ $count -gt 5 ]; do
    echo "Count: $count"
    count=$((count + 1))
done
```

`until` is less common than `while`, but it reads more naturally in some situations:

```bash
until ping -c 1 example.com > /dev/null 2>&1; do
    echo "Waiting for network..."
    sleep 2
done
echo "Network is up!"
```

## Loop Control

### `break` — Exit the Loop Early

```bash
for i in {1..100}; do
    if [ $i -eq 5 ]; then
        echo "Stopping at $i"
        break
    fi
    echo "Number: $i"
done
```

### `continue` — Skip to the Next Iteration

```bash
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue    # Skip even numbers
    fi
    echo "Odd: $i"
done
```

## Practical Patterns

### Batch Rename Files

```bash
for file in rename-me/*.txt; do
    # Replace underscores with dashes in the filename
    newname=$(echo "$file" | tr '_' '-')
    echo "Would rename: $file -> $newname"
    # Uncomment the next line to actually rename:
    # mv "$file" "$newname"
done
```

**Best practice:** Always do a dry run first (just `echo`) before actually renaming or deleting.

### Process Each Line of a CSV

```bash
while IFS=, read -r date region product quantity price seller; do
    echo "$seller sold $quantity $product in $region"
done < ../../02-file-operations/04-text-processing/sales.csv
```

### Countdown Timer

```bash
for i in {10..1}; do
    echo "$i..."
    sleep 1
done
echo "Go!"
```

### Retry Logic

```bash
max_attempts=3
attempt=1

while [ $attempt -le $max_attempts ]; do
    echo "Attempt $attempt of $max_attempts..."
    if some_command; then
        echo "Success!"
        break
    fi
    attempt=$((attempt + 1))
    sleep 2
done

if [ $attempt -gt $max_attempts ]; then
    echo "Failed after $max_attempts attempts."
fi
```

## Exercises

1. Write a `for` loop that prints the numbers 1 through 10.

2. Write a `for` loop that iterates over `servers.txt` and prints each server name with a prefix:
   ```
   [SERVER] web-server-01
   [SERVER] web-server-02
   ...
   ```

3. Write a script that counts the number of lines in every `.txt` file in the current directory:
   ```bash
   for file in *.txt; do
       lines=$(wc -l < "$file")
       echo "$file: $lines lines"
   done
   ```

4. Write a `while` loop that reads `servers.txt` line by line and prints only server names containing "api".

5. Write a countdown script that takes a number as an argument and counts down to zero, printing each number with a 1-second delay.

6. Write a script that creates directories named `day-01` through `day-07`:
   ```bash
   for i in {01..07}; do
       mkdir "day-$i"
   done
   ```

7. Write a script that reads `servers.txt` and sorts the servers into categories (web, db, cache, api, monitoring) using a `case` statement inside a loop.

8. Write a dry-run batch rename script for the `rename-me/` directory that would replace underscores with dashes in every filename. Print what each file would be renamed to without actually renaming.

9. Write a `while` loop that asks the user for input and exits when they type "quit":
   ```bash
   while true; do
       read -p "Enter a command (quit to exit): " cmd
       if [ "$cmd" = "quit" ]; then
           break
       fi
       echo "You entered: $cmd"
   done
   ```

10. **Bonus**: Write a multiplication table script that uses nested `for` loops to print a 10x10 grid:
    ```
    1   2   3   4  ...
    2   4   6   8  ...
    3   6   9  12  ...
    ```

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `for x in list; do ... done` | Iterate over a list |
| `for x in *.txt; do ... done` | Iterate over files |
| `for i in {1..N}; do ... done` | Iterate over a range |
| `for ((i=0; i<N; i++)); do ... done` | C-style for loop |
| `while [ cond ]; do ... done` | Loop while condition is true |
| `while read -r line; do ... done < file` | Read file line by line |
| `until [ cond ]; do ... done` | Loop until condition is true |
| `break` | Exit the loop |
| `continue` | Skip to next iteration |

---

**Previous:** [Conditionals](../02-conditionals/) | **Next:** [Functions & Arguments](../04-functions/)
