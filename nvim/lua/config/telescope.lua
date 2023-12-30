require("telescope").setup {
  pickers = {
    live_grep = {
      additional_args = function(_)
        return { "--hidden" }
      end
    },
  },
}
