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
  },

  -- Kanagawa
  {
    "rebelot/kanagawa.nvim",
  },

  -- Nord
  {
    "shaunsingh/nord.nvim",
  },

  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- Melange (for Hackers-Green)
  {
    "savq/melange-nvim",
  },

  -- One Dark (for CuriOS theme)
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "dark", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
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
