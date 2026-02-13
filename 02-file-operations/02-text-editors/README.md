# Challenge 2: Text Editors

So far you've been reading files. Now it's time to **edit** them. Linux has several terminal-based text editors. We'll focus on the two most common: **vim** and **nano**.

## Learning Objectives

- Understand why terminal-based editors matter
- Open, edit, save, and quit files in nano
- Open, edit, save, and quit files in vim
- Know the difference between vim's modes
- Choose which editor works best for you

## Why Edit in the Terminal?

You might be wondering: "Why not just use VS Code or Notepad?"

Good question. Terminal editors are essential when:

- You're connected to a **remote server** via SSH with no graphical interface
- You need to make a **quick config edit** without launching a full IDE
- You're inside a **Docker container** or minimal environment
- You're working in a **recovery console** where only basic tools are available

You don't need to write all your code in vim — but you *do* need to be comfortable making edits when it's your only option.

## Practice Files

This directory includes files to practice with:

| File | Purpose |
|------|---------|
| `fix-me.txt` | A file full of typos to correct |
| `shopping-list.txt` | A short list to add items to |
| `hello.py` | A Python file with TODOs to complete |

## Nano — The Beginner-Friendly Editor

Nano is straightforward and shows its keyboard shortcuts right on screen.

### Opening a File

```bash
$ nano fix-me.txt
```

### How Nano Works

When nano opens, you'll see:
- The file contents in the middle
- A title bar at the top
- A shortcut bar at the bottom (e.g., `^X Exit` means Ctrl+X to exit)

The `^` symbol means **Ctrl**. So `^O` means **Ctrl+O**.

### Essential Nano Shortcuts

| Shortcut | Action |
|----------|--------|
| **Ctrl+O** | Save (Write Out) — press Enter to confirm |
| **Ctrl+X** | Exit nano |
| **Ctrl+K** | Cut the current line |
| **Ctrl+U** | Paste the cut line |
| **Ctrl+W** | Search for text |
| **Ctrl+\\** | Search and replace |
| **Ctrl+G** | Show help |
| **Alt+U** | Undo |
| **Alt+E** | Redo |

### Basic Nano Workflow

1. Open the file: `nano filename`
2. Move around with arrow keys
3. Type to insert text (it just works — no special mode needed)
4. Save with **Ctrl+O**, press **Enter**
5. Quit with **Ctrl+X**

That's it. Nano is simple by design.

## Vim — The Powerful Editor

Vim is more complex than nano, but dramatically more efficient once you learn it. It's installed on virtually every Unix system and is the default editor in many environments.

The key concept: **vim has modes**.

### Vim's Modes

| Mode | Purpose | How to Enter |
|------|---------|--------------|
| **Normal** | Navigate and manipulate text | Press `Esc` (this is the default mode) |
| **Insert** | Type and edit text | Press `i`, `a`, `o`, or others |
| **Command** | Run commands (save, quit, search) | Press `:` from Normal mode |
| **Visual** | Select text | Press `v` from Normal mode |

When in doubt, press **Esc** to get back to Normal mode.

### Opening a File

```bash
$ vim fix-me.txt
```

You start in **Normal mode**. You can't type text yet — this confuses everyone at first.

### The Most Important Vim Commands

**Getting into Insert mode (so you can type):**

| Key | Action |
|-----|--------|
| `i` | Insert before the cursor |
| `a` | Insert after the cursor |
| `o` | Open a new line below and insert |
| `O` | Open a new line above and insert |
| `A` | Insert at the end of the line |

**Getting back to Normal mode:**

Press **Esc**. Always.

**Saving and quitting (from Normal mode, type `:` first):**

| Command | Action |
|---------|--------|
| `:w` | Save (write) |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving (discard changes) |
| `ZZ` | Save and quit (shortcut, no `:` needed) |

### Navigating in Normal Mode

You can use arrow keys, but vim has its own navigation that's faster once you're used to it:

| Key | Action |
|-----|--------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `w` | Jump forward one word |
| `b` | Jump backward one word |
| `0` | Jump to beginning of line |
| `$` | Jump to end of line |
| `gg` | Jump to first line of file |
| `G` | Jump to last line of file |
| `Ctrl+d` | Scroll down half a page |
| `Ctrl+u` | Scroll up half a page |

### Editing in Normal Mode

You don't have to be in Insert mode to make changes:

| Key | Action |
|-----|--------|
| `x` | Delete character under cursor |
| `dd` | Delete the entire current line |
| `yy` | Copy (yank) the current line |
| `p` | Paste below the current line |
| `u` | Undo |
| `Ctrl+r` | Redo |

### Searching in Vim

From Normal mode:

| Command | Action |
|---------|--------|
| `/pattern` | Search forward for "pattern" |
| `?pattern` | Search backward |
| `n` | Go to next match |
| `N` | Go to previous match |

### The Vim Survival Guide

If you remember nothing else, remember this:

1. **`i`** to start typing
2. **`Esc`** to stop typing
3. **`:wq`** to save and quit
4. **`:q!`** to quit without saving

## Which Editor Should You Use?

| | Nano | Vim |
|---|------|-----|
| Learning curve | Gentle | Steep |
| Speed once learned | Moderate | Very fast |
| Available everywhere | Most systems | Almost all systems |
| Best for | Quick edits, beginners | Heavy editing, power users |

**Our recommendation:** Learn nano first for immediate productivity. Start learning vim on the side — it's a long-term investment that pays off enormously.

You can set your default editor with:

```bash
$ export EDITOR=nano    # or vim
```

## Exercises

1. Open `fix-me.txt` in **nano**. Fix all the typos. Save and exit.

2. Open `shopping-list.txt` in **nano**. Add three more items to each category (Fruits, Dairy, Bakery). Add a new category called "Vegetables" with three items. Save and exit.

3. Open `fix-me.txt` in **vim**. (If you already fixed the typos, that's fine — practice navigating.) Try the following:
   - Press `gg` to go to the top, `G` to go to the bottom
   - Use `/` to search for a word
   - Press `dd` to delete a line, then `u` to undo it

4. Open `hello.py` in your editor of choice. Complete all three TODO items:
   - Write a `greet()` function
   - Call it with your name
   - Add a loop printing 1 through 5

   Save and test it:
   ```bash
   python3 hello.py
   ```

5. Create a brand new file using vim:
   ```bash
   vim my-notes.txt
   ```
   Type a few lines about what you've learned so far. Save and quit.

6. Open any file in vim and practice switching between Normal and Insert mode. Press `i` to enter Insert mode, type some text, press `Esc` to return to Normal mode. Repeat until it feels natural.

7. **Bonus**: In vim, open `fix-me.txt` and use search-and-replace to fix a typo across the whole file. The command is:
   ```
   :%s/old-word/new-word/g
   ```

## Quick Reference

### Nano

| Shortcut | Action |
|----------|--------|
| `Ctrl+O` | Save |
| `Ctrl+X` | Exit |
| `Ctrl+K` | Cut line |
| `Ctrl+U` | Paste |
| `Ctrl+W` | Search |
| `Ctrl+\\` | Search and replace |

### Vim

| Command | Action |
|---------|--------|
| `i` | Enter Insert mode |
| `Esc` | Return to Normal mode |
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |
| `dd` | Delete line |
| `u` | Undo |
| `/pattern` | Search |

---

**Previous:** [File Manipulation](../01-file-manipulation/) | **Next:** [Searching & Filtering](../03-searching/)
