-- Map Perforce keymaps
require("which-key").register({
  p = { name = "perforce" },
}, { prefix = "<leader>" })

-- p4 edit
vim.keymap.set("n", "<leader>pe", function()
  local fileFullPath = vim.fn.expand("%:p")
  local fileBaseDir = BaseDir(fileFullPath)

  -- Check if the file exists
  if vim.fn.filereadable(fileFullPath) == 0 then
    vim.notify("[P4] File not found: " .. fileFullPath)
    return
  end

  -- Function to call `p4 edit`. Required because `vim.ui.select` is async
  local function edit()
    -- Add execution permition for .sh/.csh files
    local extraArgs = ""
    if fileFullPath:match(".c?sh$") then
      vim.api.nvim_exec2("!chmod +x " .. fileFullPath, {})
      extraArgs = "-t text+x "
    end

    local cmd =
      vim.api.nvim_exec2("!cd " .. fileBaseDir .. " && p4 edit " .. extraArgs .. fileFullPath, { output = true })
    local output = tostring(cmd.output)
    if output:match("not under client") then
      vim.notify("[P4] Flie isn't inside a Perforce client")
    elseif output:match("not on client") then
      vim.notify("[P4] Flie isn't added. You must add it instead of edit it")
    elseif output:match("currently opened for edit") then
      vim.notify("[P4] File already opened for edit")
    else
      vim.notify("[P4] Editing " .. fileFullPath)
    end
  end

  -- Check if trying to p4 a file in a client that doesn't belong to the current user
  local user = os.getenv("USER")
  if user ~= "" and fileFullPath:match(user) == nil then
    vim.ui.select(
      { "No", "Yes" },
      { prompt = "Trying to edit a file in someonelse's client. Confirm?" },
      function(choice)
        if choice == "No" then
          return
        else
          edit()
        end
      end
    )
  else
    edit()
  end
end, { noremap = true, desc = "Edit the current file" })

-- p4 add
vim.keymap.set("n", "<leader>pa", function()
  local fileFullPath = vim.fn.expand("%:p")
  local fileBaseDir = BaseDir(fileFullPath)

  if vim.fn.filereadable(fileFullPath) == 0 then
    -- Check if the file exists
    vim.notify("[P4] File not found: " .. fileFullPath)
    return
  end

  -- Function to call `p4 add`. Required because `vim.ui.select` is async
  local function add()
    -- Add execution permition for .sh/.csh files
    local extraArgs = ""
    if fileFullPath:match(".c?sh$") then
      vim.api.nvim_exec2("!chmod +x " .. fileFullPath, {})
      extraArgs = "-t text+x "
    end

    local cmd =
      vim.api.nvim_exec2("!cd " .. fileBaseDir .. " && p4 add " .. extraArgs .. fileFullPath, { output = true })
    local output = tostring(cmd.output)
    if output:match("not under client") then
      vim.notify("[P4] Flie isn't inside a Perforce client")
    elseif output:match("can't add existing file") then
      vim.notify("[P4] Flie not added, because it's already tracked. You must edit it instead")
    elseif output:match("currently opened for add") then
      vim.notify("[P4] File already added")
    else
      vim.notify("[P4] Added " .. fileFullPath)
    end
  end

  -- Check if trying to p4 a file in a client that doesn't belong to the current user
  local user = os.getenv("USER")
  if user ~= "" and fileFullPath:match(user) == nil then
    vim.ui.select(
      { "No", "Yes" },
      { prompt = "Trying to add a file in someonelse's client. Confirm?" },
      function(choice)
        if choice == "No" then
          return
        else
          add()
        end
      end
    )
  else
    add()
  end
end, { noremap = true, desc = "Add the current file" })

-- p4 revert
vim.keymap.set("n", "<leader>pr", function()
  local fileFullPath = vim.fn.expand("%:p")
  local fileBaseDir = BaseDir(fileFullPath)

  -- Check if the file exists
  if vim.fn.filereadable(fileFullPath) == 0 then
    vim.notify("[P4] File not found: " .. fileFullPath)
    return
  end

  -- Function to call `p4 revert`. Required because `vim.ui.select` is async
  local function revert()
    local cmd = vim.api.nvim_exec2("!cd " .. fileBaseDir .. " && p4 revert " .. fileFullPath, { output = true })
    local output = tostring(cmd.output)
    if output:match("not under client") then
      vim.notify("[P4] Flie isn't inside a Perforce client")
    elseif output:match("can't add existing file") then
      vim.notify("[P4] Flie not added, it's already tracked. You must edit it instead")
    elseif output:match("not opened") then
      vim.notify("[P4] File already reverted or not tracked")
    else
      vim.notify("[P4] Reverted " .. fileFullPath)
    end
  end

  -- Check if trying to p4 a file in a client that doesn't belong to the current user
  local user = os.getenv("USER")
  if user ~= "" and fileFullPath:match(user) == nil then
    vim.ui.select(
      { "No", "Yes" },
      { prompt = "Trying to revert a file in someonelse's client. Confirm?" },
      function(choice)
        if choice == "No" then
          return
        else
          revert()
        end
      end
    )
  else
    revert()
  end
end, { noremap = true, desc = "Revert the current file" })
