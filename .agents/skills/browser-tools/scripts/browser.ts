import puppeteer from 'puppeteer-core';

const BROWSER_URL = 'http://localhost:9222';

async function main() {
  const args = process.argv.slice(2);
  const command = args[0];

  if (!command) {
    console.log('Usage: browser-tool <command> [args]');
    console.log('Commands: open-url, click, fill, extract, screenshot, eval');
    process.exit(1);
  }

  let browser;
  try {
    browser = await puppeteer.connect({
      browserURL: BROWSER_URL,
      defaultViewport: null,
    });

    const pages = await browser.pages();
    let page: puppeteer.Page;

    // Optional: Get tab index from environment or first arg after command
    let tabIndex = 0;
    if (process.env.BROWSER_TAB_INDEX) {
      tabIndex = parseInt(process.env.BROWSER_TAB_INDEX);
    }

    switch (command) {
      case 'list-tabs':
        const tabList = await Promise.all(pages.map(async (p, i) => ({
          index: i,
          title: await p.title(),
          url: p.url()
        })));
        console.log(JSON.stringify(tabList, null, 2));
        break;

      case 'open-url':
        const url = args[1];
        if (!url) throw new Error('URL is required');
        page = await browser.newPage();
        await page.goto(url, { waitUntil: 'networkidle2' });
        console.log(`Navigated to ${url} in a new tab`);
        break;

      case 'navigate':
        const navUrl = args[1];
        if (!navUrl) throw new Error('URL is required');
        page = pages[tabIndex] || pages[0];
        await page.goto(navUrl, { waitUntil: 'networkidle2' });
        console.log(`Navigated to ${navUrl} in tab ${tabIndex}`);
        break;

      case 'click':
        const selector = args[1];
        if (!selector) throw new Error('Selector is required');
        page = pages[tabIndex] || pages[0];
        await page.bringToFront();
        await page.waitForSelector(selector);
        await page.click(selector);
        console.log(`Clicked on ${selector} in tab ${tabIndex}`);
        break;

      case 'fill':
        const fillSelector = args[1];
        const value = args[2];
        if (!fillSelector || value === undefined) throw new Error('Selector and value are required');
        page = pages[tabIndex] || pages[0];
        await page.bringToFront();
        await page.waitForSelector(fillSelector);
        await page.type(fillSelector, value);
        console.log(`Filled ${fillSelector} with "${value}" in tab ${tabIndex}`);
        break;

      case 'extract':
        const extractSelector = args[1];
        if (!extractSelector) throw new Error('Selector is required');
        page = pages[tabIndex] || pages[0];
        await page.waitForSelector(extractSelector);
        const text = await page.$eval(extractSelector, el => (el as HTMLElement).innerText);
        console.log(text);
        break;

      case 'screenshot':
        const filename = args[1] || 'screenshot.png';
        page = pages[tabIndex] || pages[0];
        await page.bringToFront();
        await page.screenshot({ path: filename });
        console.log(`Screenshot saved to ${filename} from tab ${tabIndex}`);
        break;

      case 'eval':
        const script = args[1];
        if (!script) throw new Error('Script is required');
        page = pages[tabIndex] || pages[0];
        const result = await page.evaluate(script);
        console.log(JSON.stringify(result, null, 2));
        break;

      case 'switch-tab':
        const targetIndex = parseInt(args[1]);
        if (isNaN(targetIndex) || !pages[targetIndex]) throw new Error('Valid tab index is required');
        await pages[targetIndex].bringToFront();
        console.log(`Switched to tab ${targetIndex}: ${await pages[targetIndex].title()}`);
        break;

      default:
        console.error(`Unknown command: ${command}`);
        process.exit(1);
    }
  } catch (error: any) {
    console.error('Error:', error.message);
    process.exit(1);
  } finally {
    if (browser) {
      await browser.disconnect();
    }
  }
}

main();
