-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal mode mappings
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Normal mode mappings
vim.keymap.set("n", "<leader><tab>t", ":tabnew | terminal<CR>", { desc = "Terminal in new tab" })
