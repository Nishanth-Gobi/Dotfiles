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
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
          grep = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },

}
