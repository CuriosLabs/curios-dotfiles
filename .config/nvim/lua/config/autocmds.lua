-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Auto-reload colorscheme when changed externally
local function reload_colorscheme()
  local colorschemes_file = vim.fn.stdpath("config") .. "/lua/plugins/colorschemes.lua"
  local f = io.open(colorschemes_file, "r")
  if not f then
    return
  end
  local content = f:read("*all")
  f:close()
  local theme = content:match('colorscheme = "([^"]+)"')
  if theme and theme ~= vim.g.colors_name then
    vim.schedule(function()
      local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
      if ok then
        -- Also trigger transparency toggle if it was enabled (optional, but consistent with keymaps.lua)
        if _G.transparency_enabled then
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "ColumnBorder", { bg = "none" })
        end
      end
    end)
  end
end

local config_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local watcher = vim.uv.new_fs_event()
if watcher then
  watcher:start(
    config_dir,
    {},
    vim.schedule_wrap(function(err, filename)
      if not err and filename == "colorschemes.lua" then
        reload_colorscheme()
      end
    end)
  )
end
