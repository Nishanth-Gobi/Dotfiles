return {
  -- Disable neo-tree (LazyVim now uses snacks.explorer by default)
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- Show dotfiles in snacks explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        replace_netrw = true,
      },
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = false,
          },
        },
      },
    },
  },

  -- Respect .gitignore in telescope find_files
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = false,
        },
      },
    },
  },
}
