-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },

  -- add more treesitter parsers (Neovim 0.12+)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
      })
    end,
    -- In 0.12, ensure_installed is handled via the new TSInstall command or system packages.
    -- We can automate it here for a better OOTB experience.
    init = function()
      local parsers = { "html", "javascript", "json", "tsx", "typescript", "yaml" }
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local ok, p = pcall(require, "nvim-treesitter.parsers")
          if ok then
            for _, lang in ipairs(parsers) do
              if not p.has_parser(lang) then
                vim.cmd("TSInstall " .. lang)
              end
            end
          end
        end,
      })
    end,
  },

  -- add DiffViewOpen
  { "sindrets/diffview.nvim" },
}
