# Challenge 4: Functions & Arguments

As scripts grow, repeating the same block of code becomes messy and error-prone. Functions let you name a block of code and call it whenever you need it — making scripts organized, readable, and reusable.

## Learning Objectives

- Define and call functions in bash
- Pass arguments to functions
- Return values from functions
- Use local variables inside functions
- Process script arguments with `shift`
- Build a script with a clean structure

## Practice Files

| File | Description |
|------|-------------|
| `utils-demo.sh` | A script demonstrating reusable utility functions |

Run `./utils-demo.sh` and read the source code.

## Defining Functions

### Basic Syntax

```bash
greet() {
    echo "Hello, World!"
}

# Call it
greet
```

You can also use the `function` keyword, but it's not required:

```bash
function greet {
    echo "Hello, World!"
}
```

**Important:** The function must be defined *before* it's called. Bash reads scripts top to bottom.

## Function Arguments

Functions receive arguments the same way scripts do — through `$1`, `$2`, etc.:

```bash
greet() {
    echo "Hello, $1!"
}

greet "Alice"       # Hello, Alice!
greet "Bob"         # Hello, Bob!
```

```bash
add() {
    echo $(($1 + $2))
}

result=$(add 10 20)
echo "Sum: $result"     # Sum: 30
```

| Variable | Meaning (inside a function) |
|----------|---------------------------|
| `$1`, `$2`, ... | Arguments passed to the function |
| `$#` | Number of arguments |
| `$@` | All arguments |
| `$0` | Still the script name (not the function name) |

## Return Values

### Numeric Return Codes

Functions can return an exit code (0-255) with `return`:

```bash
is_even() {
    if [ $(($1 % 2)) -eq 0 ]; then
        return 0    # true/success
    else
        return 1    # false/failure
    fi
}

if is_even 4; then
    echo "4 is even"
fi

if ! is_even 7; then
    echo "7 is odd"
fi
```

`return 0` means success (true), anything else means failure (false) — just like exit codes.

### Returning Strings/Data

For anything more than a status code, have the function `echo` and capture it with command substitution:

```bash
get_greeting() {
    local hour=$(date +%H)
    if [ "$hour" -lt 12 ]; then
        echo "Good morning"
    else
        echo "Good afternoon"
    fi
}

message=$(get_greeting)
echo "$message, $USER!"
```

## Local Variables

By default, variables in bash are **global** — they're visible everywhere, even outside the function. Use `local` to restrict a variable to the function:

```bash
demo() {
    local secret="only inside demo"
    global_var="visible everywhere"
    echo "Inside: $secret"
}

demo
echo "Outside: $secret"       # Empty — local to the function
echo "Outside: $global_var"   # "visible everywhere"
```

**Best practice:** Always use `local` for variables that don't need to be seen outside the function. This prevents accidental name collisions.

```bash
process_file() {
    local filename="$1"
    local line_count
    line_count=$(wc -l < "$filename")
    echo "$filename has $line_count lines"
}
```

## Processing Script Arguments with `shift`

`shift` removes the first argument, sliding everything down:

```bash
#!/bin/bash
echo "Before shift: $1 $2 $3"
shift
echo "After shift: $1 $2 $3"
```

```bash
$ ./script.sh a b c
Before shift: a b c
After shift: b c
```

This is useful for processing arguments in a loop:

```bash
while [ $# -gt 0 ]; do
    echo "Processing: $1"
    shift
done
```

### Parsing Options with a Loop

```bash
#!/bin/bash
verbose=false
output=""

while [ $# -gt 0 ]; do
    case "$1" in
        -v|--verbose)
            verbose=true
            ;;
        -o|--output)
            output="$2"
            shift       # Extra shift to skip the value
            ;;
        -h|--help)
            echo "Usage: $0 [-v] [-o file] [args...]"
            exit 0
            ;;
        *)
            echo "Processing: $1"
            ;;
    esac
    shift
done

$verbose && echo "Verbose mode enabled"
[ -n "$output" ] && echo "Output file: $output"
```

## Script Structure

A well-organized script follows a pattern:

```bash
#!/bin/bash
# Description of what the script does.

# --- Constants ---
readonly VERSION="1.0.0"
readonly DEFAULT_OUTPUT="/tmp/output.txt"

# --- Functions ---
usage() {
    echo "Usage: $0 [options] <input-file>"
    echo "Options:"
    echo "  -v, --verbose    Enable verbose output"
    echo "  -o, --output     Set output file"
    echo "  -h, --help       Show this help"
    exit 1
}

log() {
    echo "[$(date +%H:%M:%S)] $1"
}

process() {
    local input="$1"
    log "Processing $input..."
    # ... actual work here ...
    log "Done."
}

# --- Main ---
main() {
    # Parse arguments
    [ $# -eq 0 ] && usage

    local verbose=false
    local output="$DEFAULT_OUTPUT"

    while [ $# -gt 0 ]; do
        case "$1" in
            -v|--verbose) verbose=true ;;
            -o|--output)  output="$2"; shift ;;
            -h|--help)    usage ;;
            *)            break ;;
        esac
        shift
    done

    # Validate
    if [ ! -f "$1" ]; then
        echo "Error: File not found: $1"
        exit 1
    fi

    # Run
    process "$1"
}

main "$@"
```

The `main "$@"` pattern at the bottom passes all script arguments to the main function. This keeps the script organized and ensures functions are defined before they're called.

## Exercises

1. Run `./utils-demo.sh` and read its source code. Notice how it uses functions for logging and confirmation.

2. Write a function called `say_hello` that takes a name and prints a greeting. Call it three times with different names.

3. Write a function called `is_file` that takes a path and returns 0 if it's a regular file, 1 otherwise. Use it in an `if` statement.

4. Write a function called `count_files` that takes a directory path and returns the number of files in it (using `echo`, captured with `$()`).

5. Write a function called `to_upper` that takes a string and prints it in uppercase:
   ```bash
   to_upper() {
       echo "$1" | tr 'a-z' 'A-Z'
   }
   result=$(to_upper "hello world")
   echo "$result"     # HELLO WORLD
   ```

6. Create a script called `toolkit.sh` that defines several utility functions (at least 3) and uses them in a main function. For example: file backup, word counting, directory listing.

7. Write a script called `multi-greet.sh` that accepts any number of names as arguments and greets each one:
   ```bash
   $ ./multi-greet.sh Alice Bob Carol
   Hello, Alice!
   Hello, Bob!
   Hello, Carol!
   ```

8. Write a script with argument parsing that accepts `-v` (verbose), `-n <name>` (name), and `-h` (help). Print the values after parsing.

9. **Bonus**: Write a script called `mini-calc.sh` that works like a simple calculator:
   ```bash
   $ ./mini-calc.sh add 10 5      # 15
   $ ./mini-calc.sh sub 10 5      # 5
   $ ./mini-calc.sh mul 10 5      # 50
   $ ./mini-calc.sh div 10 5      # 2
   ```
   Use a separate function for each operation.

10. **Bonus**: Refactor the `menu.sh` script from the Conditionals challenge to use functions. Each menu option should call a function.

## Quick Reference

| Syntax | Description |
|--------|-------------|
| `name() { ... }` | Define a function |
| `name arg1 arg2` | Call a function with arguments |
| `$1, $2, $@, $#` | Access function arguments |
| `local var=value` | Declare a local variable |
| `return 0` | Return success from a function |
| `return 1` | Return failure from a function |
| `result=$(func)` | Capture function output |
| `shift` | Remove first argument, shift others down |
| `readonly VAR=val` | Declare a constant |
| `main "$@"` | Pass all script args to main function |

---

**Previous:** [Loops](../03-loops/) | **Next:** [Putting It All Together](../05-capstone/)
