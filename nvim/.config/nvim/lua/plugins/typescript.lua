return {
  -- Disable vtsls (crashes with SIGABRT in loop on Node 22)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = { enabled = false },
        ts_ls = {
          init_options = {
            maxTsServerMemory = 4096,
          },
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 4096,
                useSyntaxServer = "auto",
              },
            },
            javascript = {
              tsserver = {
                maxTsServerMemory = 4096,
                useSyntaxServer = "auto",
              },
            },
          },
        },
      },
    },
  },
}
