-- Set Python configs based on .vscode/*

local workspace = vim.fn.getcwd()

-- Search for .pylintrc inside .vscode/
local pylint_executable = "pylint"
local pylintrc = workspace .. "/.vscode/.pylintrc"
local pylintrc_args = {}
if vim.fn.filereadable(pylintrc) == 1 then
  vim.notify("[python] Found '.vscode/.pylintrc'")
  pylintrc_args.args = {
    "--rcfile=" .. pylintrc,
  }
end

-- Search for Python configs inside .vscode/settings.json
local vscode_settings = workspace .. "/.vscode/settings.json"
if vim.fn.filereadable(vscode_settings) == 1 then
  -- Searching for paths pointing to an specific pylint
  local pattern = 'python%.linting%.pylintPath":%s"(.+)"'
  for line in io.lines(vscode_settings) do
    local match = string.match(line, pattern)
    if match ~= nil then
      vim.notify("[python] Using pylint from '" .. match .. "'")
      pylint_executable = match
      break
    end
  end
end

-- Apply changes
require("lint.linters.pylint").args = {
  rcfile = pylintrc,
}

require("lspconfig").pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = false,
        },
        mccabe = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        pylint = {
          executable = pylint_executable,
          enabled = true,
          args = pylintrc_args,
        },
      },
      configurationSources = { "pylint" },
    },
  },
})
