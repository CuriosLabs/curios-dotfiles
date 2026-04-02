---
name: browser-tools
description:
 Interact with a Chrome-based browser using remote debugging tools at
 localhost:9222. Automate browser tasks like navigation, form filling,
 clicking, and data extraction.
---

# Browser Tools Skill

This skill provides a set of tools to interact with an existing browser instance
running with remote debugging enabled (`--remote-debugging-port=9222`).

## Commands and Usage

The `browser-tool` command is a wrapper for several browser automation tasks:

1. **Navigate**: Open a URL in the browser.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool open-url <url>
   ```

2. **Click**: Click an element by its CSS selector.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool click <selector>
   ```

3. **Fill**: Type text into an input field.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool fill <selector> <value>
   ```

4. **Extract**: Get the inner text of an element.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool extract <selector>
   ```

5. **Screenshot**: Take a screenshot of the current page.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool screenshot <filename.png>
   ```

6. **Eval**: Execute custom JavaScript in the browser context.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool eval "window.location.href"
   ```

7. **List Tabs**: Show all open tabs with their indices, titles, and URLs.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool list-tabs
   ```

8. **Switch Tab**: Bring a specific tab to the front by its index.

   ```bash
   ./.agents/skills/browser-tools/scripts/browser-tool switch-tab <index>
   ```

## Targeting Specific Tabs

By default, commands (click, fill, extract, etc.) target the **first tab (index 0)**. To target a different tab, use the `BROWSER_TAB_INDEX` environment variable:

```bash
BROWSER_TAB_INDEX=2 ./.agents/skills/browser-tools/scripts/browser-tool click "#my-button"
```

Use `list-tabs` to find the correct index.

## When to use me

- When you need to interact with a website (e.g., search for something).
- When you need to fill forms or automate repetitive web tasks.
- When you need to extract specific data from a web page.
- When you need visual confirmation of a web page state (screenshot).

## Important Notes

- **Automatic Launch**: The `browser-tool` script will automatically try to start Brave with remote debugging on port 9222 if it's not already running.
- **Brave Specific Setup**: In some Brave versions, you may need to open `brave://inspect/#remote-debugging` in the browser and check the **"Allow remote debugging for this browser instance"** box for the remote port to become active.
- **Dependency Management**: The script will also check for `puppeteer-core` and install it globally if it's missing.
- The tools use `puppeteer-core` to connect to the browser.
- By default, the tools connect to the first available tab or create a new one.
- Commands are executed from the project root using the `./.agents/skills/browser-tools/scripts/browser-tool` wrapper.
