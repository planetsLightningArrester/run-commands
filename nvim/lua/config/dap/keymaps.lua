-- Map debug adapter keymaps

-- Map on which key
require("which-key").add({ prefix = "<leader>", group = "debug" })

-- Toggle debug view
vim.keymap.set("n", "<leader>dt", function()
  require("dapui").toggle()
end, { desc = "Toggle debugger UI" })
-- Toggle breakpoint
vim.keymap.set("n", "<leader>dbb", function()
  require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
-- Set a log breakpoint
vim.keymap.set("n", "<Leader>dbl", function()
  require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Set log on breakpoint" })
-- Set a conditional breakpoint
vim.keymap.set("n", "<Leader>dbc", function()
  require("dap").set_breakpoint(nil, vim.fn.input("Condition: "), nil)
end, { desc = "Set a conditional breakpoint" })
-- Break on error
vim.keymap.set("n", "<Leader>dbe", function()
  require("dap").set_exception_breakpoints()
end, { desc = "Break on error" })
-- Disable break on error
vim.keymap.set("n", "<Leader>dbd", function()
  require("dap").set_exception_breakpoints()
end, { desc = "Disable break on error" })
-- Start/continue
vim.keymap.set("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Continue" })
-- Pause
vim.keymap.set("n", "<leader>dp", function()
  require("dap").pause()
end, { desc = "Pause" })
-- Step into
vim.keymap.set("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Step into" })
-- Step out
vim.keymap.set("n", "<leader>do", function()
  require("dap").step_out()
end, { desc = "Step out" })
-- Step over
vim.keymap.set("n", "<leader>dv", function()
  require("dap").step_over()
end, { desc = "Step over" })
-- Terminate the debug session
vim.keymap.set("n", "<leader>dx", function()
  require("dap").terminate()
end, { desc = "Terminate session" })
-- Get hover info
vim.keymap.set("n", "<leader>dk", function()
  require("dap.ui.widgets").preview()
end, { desc = "Show hover info" })
-- Restore the UI layout
vim.keymap.set("n", "<leader>dr", function()
  require("dapui").open({ reset = true })
end, { desc = "Restore the UI" })
