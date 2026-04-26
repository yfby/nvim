-- Refactoring.nvim configuration
require("refactoring").setup {
  prompt_func_return_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  prompt_func_param_type = {
    go = true,
    java = true,
    cpp = true,
    c = true,
    h = true,
    hpp = true,
    cxx = true,
  },
  printf_statements = {},
  show_success = true,
}

-- Refactoring keymaps
local keymap = vim.keymap.set

-- Extract variable
keymap("v", "<leader>rev", function() require("refactoring").refactor("Extract Variable") end, { desc = "Extract Variable" })
keymap("n", "<leader>rev", function() require("refactoring").refactor("Extract Variable") end, { desc = "Extract Variable" })

-- Extract function
keymap("v", "<leader>ref", function() require("refactoring").refactor("Extract Function") end, { desc = "Extract Function" })
keymap("n", "<leader>ref", function() require("refactoring").refactor("Extract Function") end, { desc = "Extract Function" })

-- Extract block
keymap("v", "<leader>reb", function() require("refactoring").refactor("Extract Block") end, { desc = "Extract Block" })

-- Inline variable
keymap("n", "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, { desc = "Inline Variable" })
keymap("v", "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, { desc = "Inline Variable" })

-- Rename variable
keymap("n", "<leader>rr", function() require("refactoring").refactor("Rename Variable") end, { desc = "Rename Variable" })

-- Debug print (using new unified debug interface)
keymap("n", "<leader>rdp", function() require("refactoring").debug.print_var({}) end, { desc = "Debug Print Variable" })
keymap("n", "<leader>rds", function() require("refactoring").debug.cleanup({}) end, { desc = "Debug Cleanup" })
