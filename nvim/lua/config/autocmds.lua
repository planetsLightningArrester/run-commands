-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
require("config.dap.autocmds")
require("config.perforce.autocmds")

-- Wrap lines in Markdown files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md" },
  callback = function(_)
    vim.api.nvim_exec2("setlocal textwidth=80")
  end,
})
