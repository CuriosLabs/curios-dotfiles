#!/usr/bin/env bash
# Read JSON input from stdin
input=$(cat)

# Extract timestamp and command (requires 'jq')
timestamp=$(echo "$input" | jq -r '.timestamp')
command=$(echo "$input" | jq -r '.tool_input.command')

# Format like zsh_history: ': timestamp;command' in the home directory
echo ": $timestamp;$command" >>"$HOME/.gemini/shell_history.log"

# Return an empty JSON object to allow the tool to proceed
echo "{}"
exit 0
