-- Debug adapter (DAP) plugins
return {
  { "nvim-neotest/nvim-nio" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      config = function() end,
    },
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { "leoluz/nvim-dap-go" },
}
