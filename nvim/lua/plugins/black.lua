return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      ["python"] = { "black" },
    },
    formatters = {
      black = {
        prepend_args = {"--line-length=200"},
      }
    }
  },
}
