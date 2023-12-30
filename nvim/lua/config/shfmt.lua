-- Set shfmt configs based on .vscode/*

local workspace = vim.fn.getcwd()

-- Search for .pylintrc inside .vscode/
local shfmt_prepend_args = {}

-- Search for Python configs inside .vscode/settings.json
local vscode_settings = workspace .. "/.vscode/settings.json"
if vim.fn.filereadable(vscode_settings) == 1 then
  -- Searching for paths pointing to an specific pylint
  local pattern = 'shellformat%.flag%":%s*"(.+)"'
  for line in io.lines(vscode_settings) do
    local match = string.match(line, pattern)
    if match ~= nil then
      vim.notify("[shfmt] Using shfmt configs from .vscode")
      for arg in string.gmatch(match, "%S+") do
        table.insert(shfmt_prepend_args, arg)
      end
      break
    end
  end
end

-- Apply changes
require("conform").formatters.shfmt = {
  prepend_args = shfmt_prepend_args,
}
