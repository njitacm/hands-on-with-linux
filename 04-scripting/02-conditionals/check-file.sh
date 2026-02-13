#!/bin/bash
# Demonstrates file test operators.
# Usage: ./check-file.sh <filename>

if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

FILE="$1"

echo "Checking: $FILE"
echo "---"

if [ -e "$FILE" ]; then
    echo "[EXISTS]    Yes"
else
    echo "[EXISTS]    No"
    echo "File does not exist!"
    exit 1
fi

if [ -f "$FILE" ]; then
    echo "[TYPE]      Regular file"
elif [ -d "$FILE" ]; then
    echo "[TYPE]      Directory"
elif [ -L "$FILE" ]; then
    echo "[TYPE]      Symbolic link"
else
    echo "[TYPE]      Other"
fi

if [ -r "$FILE" ]; then
    echo "[READABLE]  Yes"
else
    echo "[READABLE]  No"
fi

if [ -w "$FILE" ]; then
    echo "[WRITABLE]  Yes"
else
    echo "[WRITABLE]  No"
fi

if [ -x "$FILE" ]; then
    echo "[EXECUTABLE] Yes"
else
    echo "[EXECUTABLE] No"
fi

if [ -s "$FILE" ]; then
    echo "[EMPTY]     No (has content)"
else
    echo "[EMPTY]     Yes (zero bytes)"
fi
