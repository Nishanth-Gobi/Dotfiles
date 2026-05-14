vim.env.PATH = "/opt/homebrew/opt/node@20/bin:" .. vim.env.PATH

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
