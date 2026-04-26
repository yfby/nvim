require("overseer").setup({
  task_list = {
    direction = "bottom",
    min_height = 25,
    max_height = 40,
    default_detail = 1,
  },
  form = {
    border = "rounded",
    zindex = 40,
    win_opts = {
      winblend = 0,
    },
  },
  task_win = {
    padding = 1,
    border = "rounded",
  },
  templates = { "builtin", "user" },
  dap = false,
  task_launcher_direction = "right",
  cache = {
    enabled = true,
    dir = vim.fn.stdpath("cache") .. "/overseer",
  },
})

-- Keybindings for overseer
local keymap = vim.keymap.set

keymap("n", "<leader>wr", "<cmd>OverseerRun<CR>", { desc = "Run task" })
keymap("n", "<leader>wt", "<cmd>OverseerToggle<CR>", { desc = "Toggle task runner" })
keymap("n", "<leader>wa", "<cmd>OverseerTaskAction<CR>", { desc = "Task action" })
keymap("n", "<leader>wq", "<cmd>OverseerQuickAction<CR>", { desc = "Quick action" })
