#!/bin/bash
# Displays key environment variables and their values.

echo "=== Your Environment ==="
echo ""
echo "Username:     $USER"
echo "Home:         $HOME"
echo "Shell:        $SHELL"
echo "Terminal:     $TERM"
echo "Editor:       ${EDITOR:-not set}"
echo "Language:     $LANG"
echo "Path:         $PATH"
echo ""
echo "=== Custom Variables ==="
echo "GREETING:     ${GREETING:-not set}"
echo "MY_PROJECT:   ${MY_PROJECT:-not set}"
