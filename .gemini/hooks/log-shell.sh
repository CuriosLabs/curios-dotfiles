#!/usr/bin/env bash
# Read JSON input from stdin
input=$(cat)

# Extract timestamp and command (requires 'jq')
timestamp=$(echo "$input" | jq -r '.timestamp')
command=$(echo "$input" | jq -r '.tool_input.command')

# Determine the log directory following XDG standards
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
LOG_DIR="$STATE_HOME/gemini"
LOG_FILE="$LOG_DIR/shell_history.log"

# Ensure the directory exists
mkdir -p "$LOG_DIR"

# Format like zsh_history: ': timestamp;command'
echo ": $timestamp;$command" >>"$LOG_FILE"

# Return an empty JSON object to allow the tool to proceed
echo "{}"
exit 0
