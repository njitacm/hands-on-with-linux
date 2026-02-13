# Sample .bashrc additions
# =========================
# These are examples you can add to your own ~/.bashrc

# Custom aliases
alias ll='ls -la'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias gl='git log --oneline -10'

# Custom prompt (shows username@host:directory$)
# PS1='\u@\h:\w\$ '

# Add a custom directory to PATH
# export PATH="$HOME/bin:$PATH"

# Set default editor
export EDITOR=vim

# Set a custom greeting
export GREETING="Welcome back, $(whoami)!"
