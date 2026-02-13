# Challenge 2: Conditionals

Scripts become truly useful when they can make decisions. Conditionals let your scripts check conditions, handle different cases, and respond to the unexpected.

## Learning Objectives

- Write `if`/`elif`/`else` statements
- Use test expressions to compare strings, numbers, and files
- Understand the `test` command and `[ ]` syntax
- Use `case` statements for multiple options
- Combine conditions with `&&` and `||`

## Practice Files

| File | Description |
|------|-------------|
| `check-file.sh` | A script demonstrating file test operators |

Run `./check-file.sh` on different files and directories to see what it reports.

## The `if` Statement

### Basic Syntax

```bash
if [ condition ]; then
    # commands to run if condition is true
fi
```

### With `else`

```bash
if [ condition ]; then
    echo "Condition is true"
else
    echo "Condition is false"
fi
```

### With `elif`

```bash
if [ condition1 ]; then
    echo "First condition is true"
elif [ condition2 ]; then
    echo "Second condition is true"
else
    echo "Neither condition is true"
fi
```

**Important syntax notes:**
- Spaces inside `[ ]` are required: `[ "$x" = "y" ]` not `["$x"="y"]`
- The `then` can go on the same line after `;` or on the next line
- Always quote your variables inside tests: `"$var"` not `$var`

## Test Expressions

The `[ ]` syntax is actually a shorthand for the `test` command. These are equivalent:

```bash
if [ "$name" = "Alice" ]; then ...
if test "$name" = "Alice"; then ...
```

### String Comparisons

| Expression | True When |
|-----------|-----------|
| `[ "$a" = "$b" ]` | Strings are equal |
| `[ "$a" != "$b" ]` | Strings are not equal |
| `[ -z "$a" ]` | String is empty (zero length) |
| `[ -n "$a" ]` | String is not empty |

```bash
NAME="Alice"
if [ "$NAME" = "Alice" ]; then
    echo "Hi Alice!"
fi

if [ -z "$UNDEFINED_VAR" ]; then
    echo "Variable is empty or not set"
fi
```

### Numeric Comparisons

For numbers, use these operators instead of `=`, `<`, `>`:

| Expression | Meaning |
|-----------|---------|
| `[ "$a" -eq "$b" ]` | Equal |
| `[ "$a" -ne "$b" ]` | Not equal |
| `[ "$a" -lt "$b" ]` | Less than |
| `[ "$a" -le "$b" ]` | Less than or equal |
| `[ "$a" -gt "$b" ]` | Greater than |
| `[ "$a" -ge "$b" ]` | Greater than or equal |

```bash
AGE=20
if [ "$AGE" -ge 18 ]; then
    echo "You are an adult."
else
    echo "You are a minor."
fi
```

**Why not `<` and `>`?** In `[ ]`, `<` and `>` are shell redirection operators. Using them will create files instead of comparing values. Use `-lt` and `-gt` instead.

### File Tests

| Expression | True When |
|-----------|-----------|
| `[ -e "$file" ]` | File exists |
| `[ -f "$file" ]` | Is a regular file |
| `[ -d "$file" ]` | Is a directory |
| `[ -r "$file" ]` | Is readable |
| `[ -w "$file" ]` | Is writable |
| `[ -x "$file" ]` | Is executable |
| `[ -s "$file" ]` | File exists and is not empty |
| `[ -L "$file" ]` | Is a symbolic link |

```bash
if [ -f "$1" ]; then
    echo "$1 is a file"
elif [ -d "$1" ]; then
    echo "$1 is a directory"
else
    echo "$1 does not exist"
fi
```

## Combining Conditions

### AND (`&&` or `-a`)

```bash
if [ "$age" -ge 18 ] && [ "$age" -le 65 ]; then
    echo "Working age"
fi
```

### OR (`||` or `-o`)

```bash
if [ "$color" = "red" ] || [ "$color" = "blue" ]; then
    echo "Primary color"
fi
```

### NOT (`!`)

```bash
if [ ! -f "$file" ]; then
    echo "File does not exist"
fi
```

## `[[ ]]` — Extended Test (Bash Only)

Bash provides `[[ ]]` which is more forgiving and has extra features:

```bash
# Pattern matching
if [[ "$name" == A* ]]; then
    echo "Name starts with A"
fi

# Regex matching
if [[ "$email" =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]]; then
    echo "Looks like an email"
fi

# Safe to use without quoting (but still good practice)
if [[ $var = "hello" ]]; then
    echo "hello"
fi
```

Key differences from `[ ]`:
- Supports `&&` and `||` inside the brackets
- Supports pattern matching with `==`
- Supports regex with `=~`
- Won't error on unquoted empty variables

## `case` Statements

When you have many options to check, `case` is cleaner than a chain of `elif`:

```bash
#!/bin/bash
read -p "Enter a fruit: " fruit

case "$fruit" in
    apple)
        echo "Apples are red or green."
        ;;
    banana)
        echo "Bananas are yellow."
        ;;
    orange|tangerine)
        echo "That's a citrus fruit."
        ;;
    *)
        echo "I don't know about $fruit."
        ;;
esac
```

Key syntax:
- Each pattern ends with `)`
- Each block ends with `;;`
- `*` is the default case (like `else`)
- `|` means "or" between patterns
- The whole thing ends with `esac` (`case` backwards)

### Using `case` for Script Options

```bash
#!/bin/bash
case "$1" in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    status)
        echo "Service is running."
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac
```

## Short-Circuit Evaluation

You can use `&&` and `||` outside of `if` statements for quick one-liners:

```bash
# Run second command only if first succeeds
[ -f "config.txt" ] && echo "Config found"

# Run second command only if first fails
[ -f "config.txt" ] || echo "Config missing!"

# Common pattern: check or exit
[ -z "$1" ] && echo "Usage: $0 <filename>" && exit 1
```

## Exercises

1. Run `./check-file.sh` on a regular file, a directory, and a path that doesn't exist. Read the script's source code to understand how it works.

2. Write a script called `age-check.sh` that asks for the user's age and prints:
   - "Child" if under 13
   - "Teenager" if 13-17
   - "Adult" if 18-64
   - "Senior" if 65+

3. Write a script called `file-or-dir.sh` that takes a path as an argument and reports whether it's a file, directory, or doesn't exist.

4. Write a script called `even-odd.sh` that takes a number as an argument and reports whether it's even or odd. (Hint: use `$((num % 2))`)

5. Write a script called `grade.sh` that takes a numeric score (0-100) as an argument and prints the letter grade:
   - 90-100: A
   - 80-89: B
   - 70-79: C
   - 60-69: D
   - Below 60: F

6. Write a `case` based script called `day-type.sh` that takes a day name (monday, tuesday, etc.) and prints whether it's a weekday or weekend.

7. Write a script called `compare.sh` that takes two numbers and prints which is larger, or if they're equal.

8. Write a script that checks if a required command exists before using it:
   ```bash
   if command -v htop > /dev/null 2>&1; then
       echo "htop is installed"
   else
       echo "htop is not installed"
   fi
   ```

9. **Bonus**: Write a script called `menu.sh` that displays a numbered menu (e.g., 1. List files, 2. Show date, 3. Show disk usage, 4. Quit). Use `read` and `case` to handle the user's choice. Loop until they choose Quit.

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `if [ cond ]; then ... fi` | Basic conditional |
| `if ... elif ... else ... fi` | Multi-branch conditional |
| `[ "$a" = "$b" ]` | String equality |
| `[ "$a" -eq "$b" ]` | Numeric equality |
| `[ -f "$file" ]` | File exists and is regular |
| `[ -d "$dir" ]` | Directory exists |
| `[ -z "$str" ]` | String is empty |
| `[ ! condition ]` | Negate a condition |
| `[[ pattern ]]` | Extended test (bash) |
| `case $var in ... esac` | Multi-option matching |
| `cmd1 && cmd2` | Run cmd2 only if cmd1 succeeds |
| `cmd1 \|\| cmd2` | Run cmd2 only if cmd1 fails |

---

**Previous:** [Basic Scripts](../01-basic-scripts/) | **Next:** [Loops](../03-loops/)
