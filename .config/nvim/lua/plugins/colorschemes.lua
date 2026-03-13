return {
  -- Catppuccin
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    },
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = false,
    },
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
    opts = {
      transparent = false,
    },
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    config = function()
      vim.g.nord_italic = false
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      require("nord").set()
    end,
  },

  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Melange (for Hackers-Green)
  {
    "savq/melange-nvim",
    config = function()
      vim.cmd.colorscheme("melange")
      -- Melange doesn't have a simple 'transparent' opt, so we clear the background highlight
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }):warmer
    end,
  },

  -- One Dark (for CuriOS theme)
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "dark", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
      transparent = false,
    },
  },

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
