return {
  { "nvim-treesitter/playground" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "go",
        "svelte",
        "css",
        "scss",
      },
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 10000 * 1024 -- 10 MB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            vim.notify("Tree sitter disabled")
            return true
          end
        end,
      },
    },
  },
}
