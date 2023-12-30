-- Map debug adapter autocomands

-- Enable auto complete on REPL
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "dap-repl" },
  callback = function(_)
    require("dap.ext.autocompl").attach()
  end,
})
