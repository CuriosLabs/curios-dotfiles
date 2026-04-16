#!/usr/bin/env bash

# This script rotates the shell history log file if it was last modified on a different day.
# It is intended to be run as a SessionStart hook in Gemini CLI.

# Determine the log directory following XDG standards
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
LOG_DIR="$STATE_HOME/gemini"
LOG_FILE="$LOG_DIR/shell_history.log"

# Ensure the directory exists
mkdir -p "$LOG_DIR"

# Maximum number of rotated files to keep
MAX_FILES=5

# Exit if log file doesn't exist or is empty
if [[ ! -s "$LOG_FILE" ]]; then
    echo "{}"
    exit 0
fi

# Get last modification date in YYYY-MM-DD format
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    LAST_MOD=$(date -r "$LOG_FILE" +%Y-%m-%d)
else
    # Fallback for macOS/BSD
    LAST_MOD=$(stat -f "%Sm" -t "%Y-%m-%d" "$LOG_FILE")
fi

TODAY=$(date +%Y-%m-%d)

# Rotate if last modified on a different day
if [[ "$LAST_MOD" != "$TODAY" ]]; then
    # Shift existing rotated logs: .4 -> .5, .3 -> .4, etc.
    for ((i = MAX_FILES - 1; i >= 1; i--)); do
        if [[ -f "$LOG_FILE.$i" ]]; then
            mv "$LOG_FILE.$i" "$LOG_FILE.$((i + 1))"
        fi
    done

    # Move current log to .1
    mv "$LOG_FILE" "$LOG_FILE.1"
fi

# Return empty JSON to satisfy Gemini CLI hook requirement
echo "{}"
