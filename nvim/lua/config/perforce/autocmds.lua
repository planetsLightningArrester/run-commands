-- Map Perforce autocomands

local openFiles = {}
local filesThatShouldBeOpenedBeforeSaved = {}

-- Pre-check if the opened file is tracked by Perforce
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "/dv/p4*" },
  callback = function(_)
    local fileFullPath = vim.fn.expand("%:p")
    local fileBaseDir = BaseDir(fileFullPath)

    if vim.fn.filereadable(fileFullPath) == 1 and Contains(openFiles, fileFullPath) ~= true then
      table.insert(openFiles, fileFullPath)

      local cmd = vim.api.nvim_exec2("!cd " .. fileBaseDir .. " && p4 files " .. fileFullPath, { output = true })
      local output = tostring(cmd.output)
      if output:match("//") then
        table.insert(filesThatShouldBeOpenedBeforeSaved, fileFullPath)
      end
    end
  end,
})

-- Auto-edit tracked files when entering in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  pattern = { "/dv/p4*" },
  callback = function(_)
    local fileFullPath = vim.fn.expand("%:p")
    local fileBaseDir = BaseDir(fileFullPath)

    if Contains(filesThatShouldBeOpenedBeforeSaved, fileFullPath) then
      local cmd = vim.api.nvim_exec2("!cd " .. fileBaseDir .. " && p4 edit " .. fileFullPath, { output = true })
      local output = tostring(cmd.output)
      if output:match("currently opened for edit") == false then
        vim.notify("[P4] Editing " .. fileFullPath)
      end
      ArrayRemove(filesThatShouldBeOpenedBeforeSaved, function(t, i, _)
        local v = t[i]
        return (v ~= fileFullPath)
      end)
    end
  end,
})

-- Clear watched files when closing the file
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "/dv/p4*" },
  callback = function(_)
    local fileFullPath = vim.fn.expand("%:p")

    ArrayRemove(openFiles, function(t, i, _)
      local v = t[i]
      return (v ~= fileFullPath)
    end)
    ArrayRemove(filesThatShouldBeOpenedBeforeSaved, function(t, i, _)
      local v = t[i]
      return (v ~= fileFullPath)
    end)
  end,
})
