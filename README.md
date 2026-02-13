# Welcome to Linux Crash Course!

## What is Linux Crash Course?

Linux Crash Course is a hands-on, beginner-friendly workshop designed to teach you the essential skills needed to work confidently with Linux systems. Whether you're preparing for a career in tech, system administration, development, or just want to understand the command line, this workshop will give you the foundational knowledge you need.

## Why Learn Linux?

- **Universal**: Linux powers servers, supercomputers, cloud infrastructure, and embedded systems
- **Essential for DevOps**: Most development and deployment environments run on Linux
- **Career Skills**: Linux knowledge is a requirement for many tech positions
- **Open Source**: Free, transparent, and community-driven
- **Powerful**: Command-line tools offer unmatched efficiency and automation capabilities

## Workshop Structure

This workshop is organized into **4 progressive sections**, each building on the previous one:

### [Section 1: Linux Fundamentals & Navigation](./01-fundamentals/)
Master the basics of moving around the Linux file system and understanding your environment.

**Challenges:**
1. [Getting Started](./01-fundamentals/01-getting-started/) - Terminal basics and first commands
2. [File System Navigation](./01-fundamentals/02-navigation/) - Moving through directories
3. [Viewing & Reading Files](./01-fundamentals/03-viewing-files/) - Reading and inspecting file contents
4. [Creating & Organizing](./01-fundamentals/04-directories/) - Creating and managing directories
5. [Getting Help](./01-fundamentals/05-getting-help/) - Finding documentation and help

### [Section 2: File Operations & Text Processing](./02-file-operations/)
Learn to manipulate files, process text, and combine commands efficiently.

**Challenges:**
1. [File Manipulation](./02-file-operations/01-file-manipulation/) - Copy, move, delete, and organize files
2. [Text Editors](./02-file-operations/02-text-editors/) - Edit files from the command line
3. [Searching & Filtering](./02-file-operations/03-searching/) - Find files and text patterns
4. [Text Processing & Comparison](./02-file-operations/04-text-processing/) - Process, transform, and compare text
5. [Pipes & Redirection](./02-file-operations/05-pipes-redirection/) - Combine commands powerfully

### [Section 3: Permissions, Processes & System Management](./03-permissions-system/)
Understand file permissions, users, processes, and system monitoring.

**Challenges:**
1. [File Permissions](./03-permissions-system/01-file-permissions/) - Control access to files
2. [Users & Groups](./03-permissions-system/02-users-groups/) - Understand user management
3. [Process Management](./03-permissions-system/03-process-management/) - View and control running processes
4. [Environment Variables](./03-permissions-system/04-environment-variables/) - Configure your shell environment
5. [System Information](./03-permissions-system/05-system-info/) - Check system resources and status

### [Section 4: Shell Scripting & Automation](./04-scripting/)
Write scripts to automate repetitive tasks and put it all together.

**Challenges:**
1. [Basic Scripts](./04-scripting/01-basic-scripts/) - Create your first shell scripts
2. [Conditionals](./04-scripting/02-conditionals/) - Add logic to scripts
3. [Loops](./04-scripting/03-loops/) - Iterate and repeat operations
4. [Functions & Arguments](./04-scripting/04-functions/) - Create reusable code
5. [Putting It All Together](./04-scripting/05-capstone/) - Real-world scripting and automation

## Getting Started

### Prerequisites

- Access to a Linux system
*OR*
- Terminal/SSH client
 
**No prior Linux experience required!**

### Setup Options

**Option 1: Local Installation**
- Install a Linux distribution (Ubuntu recommended for beginners)
- Use a virtual machine (VirtualBox, VMware)
- Use Windows Subsystem for Linux (WSL2)

**Option 2: NJIT Highlander AFS**
- Navigate to Highlander Nexus and read the AFS connection instructions
- Access via SSH from any operating system

### First Steps

1. **Clone this repository:**
   ```bash
   git clone https://github.com/yourusername/linux-crash-course.git
   cd linux-crash-course
   ```

2. **Start with Section 1:**
   ```bash
   cd 01-fundamentals/01-getting-started
   cat README.md
   ```

3. **Work through each challenge sequentially**

## How to Use This Workshop

### For Self-Paced Learning:

1. Read the README for each challenge
2. Try the commands and examples yourself
3. Complete the exercises at the end
4. Move to the next challenge when ready

## Workshop Philosophy

This workshop follows a **hands-on, learning-by-doing** approach:

- **Practical examples** you'll use in real work
- **Progressive difficulty** that builds confidence
- **Clear success criteria** so you know when you've mastered a concept
- **Real-world scenarios** not just abstract exercises
- **Command reference** sheets for quick lookup

## Tips for Success

- **Type, don't copy-paste**: Build muscle memory for commands
- **Make mistakes**: They're the best way to learn
- **Experiment**: Try variations of commands to see what happens
- **Read error messages**: They usually tell you what went wrong
- **Take breaks**: Learning is more effective in shorter sessions
- **Help others**: Teaching reinforces your own understanding

## Additional Resources

- [Official GNU/Linux Documentation](https://www.gnu.org/software/bash/manual/)
- [Linux Journey](https://linuxjourney.com/) - Interactive learning
- [ExplainShell](https://explainshell.com/) - Understand complex commands
- [Bash Guide](https://mywiki.wooledge.org/BashGuide) - Comprehensive bash reference
- [The Linux Command Line Book](http://linuxcommand.org/tlcl.php) - Free online book

## Troubleshooting

**"Command not found"**
- Check spelling and spacing
- Ensure the command is installed on your system
- Check your PATH variable

**"Permission denied"**
- You may need sudo privileges
- Check file permissions
- Ensure you're in the correct directory

**Getting Stuck?**
- Re-read the relevant section
- Check the cheat sheet
- Try `man commandname` or `commandname --help`
- Search online for the specific error message

## Contributing

Found a typo? Have a suggestion? Want to add a challenge?

1. Fork this repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## License

This workshop is released under the MIT License. See [LICENSE](./LICENSE) for details.

---

## Ready to Begin?

Start your Linux journey now:

```bash
cd 01-fundamentals/01-getting-started
```

**Remember**: Every Linux expert was once a beginner. You've got this!
