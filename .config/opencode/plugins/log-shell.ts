import { appendFileSync, mkdirSync, existsSync, renameSync, statSync } from "node:fs";
import { join, dirname } from "node:path";
import { homedir } from "node:os";

/**
 * Log Shell Plugin for Opencode
 *
 * Logs every bash command call from tool_call and user commands
 * into $XDG_STATE_HOME/opencode/shell_history.log in .zsh_history format.
 * Rotates logs on startup.
 */
export default async function ({ directory }: { directory: string }) {
  const stateHome = process.env.XDG_STATE_HOME || join(homedir(), ".local", "state");
  const logPath = join(stateHome, "opencode", "shell_history.log");

  try {
    // Ensure the directory exists
    mkdirSync(dirname(logPath), { recursive: true });
  } catch (err) {
    // Silently fail
  }

  const checkDailyRotation = (maxFiles = 5) => {
    try {
      if (!existsSync(logPath)) return;
      const stats = statSync(logPath);
      if (stats.size === 0) return; // Don't rotate empty logs

      const lastModified = stats.mtime;
      const today = new Date();

      // If the log was last modified on a different day, rotate
      if (lastModified.toDateString() !== today.toDateString()) {
        // Shift existing rotated logs
        for (let i = maxFiles - 1; i >= 1; i--) {
          const oldPath = `${logPath}.${i}`;
          const nextPath = `${logPath}.${i + 1}`;
          if (existsSync(oldPath)) {
            renameSync(oldPath, nextPath);
          }
        }

        // Move current log to .1
        renameSync(logPath, `${logPath}.1`);
      }
    } catch (err) {
      // Silently fail as rotation should not interrupt the flow
    }
  };

  const logCommand = (command: string) => {
    if (!command) return;

    // Match .zsh_history format: ': <iso_timestamp>;<command>' (as in Pi extension)
    const timestamp = new Date().toISOString();
    const line = `: ${timestamp};${command}\n`;

    try {
      appendFileSync(logPath, line, "utf8");
    } catch (err) {
      // Silently fail as logging should not interrupt the flow
    }
  };

  return {
    // 0. Check rotation when a session is created
    "session.created": async () => {
      checkDailyRotation();
    },

    // 1. Intercept tool calls from the LLM
    "tool.execute.before": async (input: { tool: string; args: { command?: string } }) => {
      if (input.tool === "bash") {
        const command = input.args.command;
        if (command) logCommand(command);
      }
    },

    // 2. Intercept user commands from the TUI
    "tui.command.execute": async (input: { command: string }) => {
      logCommand(input.command);
    }
  };
}
