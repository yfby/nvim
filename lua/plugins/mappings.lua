local keymap = vim.keymap.set

-- =============================================================================
-- Telescope
-- =============================================================================
keymap("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Search current buffer" })

keymap("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
keymap("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live grep" })
keymap("n", "<leader>fr", require("telescope.builtin").oldfiles, { desc = "Recent files" })
keymap("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Find buffers" })
keymap("n", "<leader>fc", require("telescope.builtin").commands, { desc = "Find commands" })
keymap("n", "<leader>fk", require("telescope.builtin").keymaps, { desc = "Find keymaps" })
keymap("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help tags" })
keymap("n", "<leader>fs", require("telescope.builtin").treesitter, { desc = "Treesitter symbols" })
keymap("n", "<leader>fl", require("telescope.builtin").lsp_document_symbols, { desc = "LSP symbols" })

-- Find TODOs
pcall(function()
  keymap("n", "<leader>ft", function()
    require("telescope").extensions["todo-comments"].todo()
  end, { desc = "TODOs" })
end)

-- Telescope Dap
pcall(function()
  local dap_ext = require("telescope").load_extension("dap")
  if dap_ext then
    keymap("n", "<leader>dd", dap_ext.list_breakpoints, { desc = "DAP breakpoints" })
    keymap("n", "<leader>dv", dap_ext.variables, { desc = "DAP variables" })
    keymap("n", "<leader>df", dap_ext.frames, { desc = "DAP frames" })
  end
end)

-- =============================================================================
-- Diagnostics / Trouble
-- =============================================================================
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics" })
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer Diagnostics" })
keymap("n", "<leader>xs", "<cmd>Trouble symbols toggle<CR>", { desc = "Symbols" })
keymap("n", "<leader>xl", "<cmd>Trouble lsp toggle<CR>", { desc = "LSP References" })
keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", { desc = "Quickfix" })
keymap("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "TODOs" })
keymap("n", "<leader>xT", "<cmd>TodoTroubleToggle filter.buf=0<CR>", { desc = "Buffer TODOs" })



-- =============================================================================
-- File Operations
-- =============================================================================
keymap("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
keymap("n", "<leader>x", function()
  require("mini.bufremove").delete(0)
end, { desc = "Delete buffer" })

-- =============================================================================
-- Formatting
-- =============================================================================
keymap("n", "<leader>uf", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format buffer" })

-- =============================================================================
-- Linting
-- =============================================================================
keymap("n", "<leader>ul", function()
  require("lint").try_lint()
end, { desc = "Lint buffer" })

-- =============================================================================
-- Git
-- =============================================================================
keymap("n", "<leader>gL", "<cmd>LazyGitCurrentFile<CR>", { desc = "LazyGit current file" })
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open diff view" })
keymap("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close diff view" })
keymap("n", "<leader>gm", "<cmd>GitMessenger<CR>", { desc = "Git messenger" })
keymap("n", "<leader>gh", "<cmd>GBrowse<CR>", { desc = "GitHub browse" })

-- Fugitive git keymaps
keymap("n", "<leader>gfc", "<cmd>Git commit<CR>", { desc = "Git commit" })
keymap("n", "<leader>gfa", "<cmd>Git commit --amend<CR>", { desc = "Git amend" })
keymap("n", "<leader>gfp", "<cmd>Git push<CR>", { desc = "Git push" })
keymap("n", "<leader>gfu", "<cmd>Git pull<CR>", { desc = "Git pull" })
keymap("n", "<leader>gfr", "<cmd>Git rebase<CR>", { desc = "Git rebase" })
keymap("n", "<leader>gfl", "<cmd>Git log<CR>", { desc = "Git log" })
keymap("n", "<leader>gfd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
keymap("n", "<leader>gfs", "<cmd>Gstatus<CR>", { desc = "Git status" })

-- =============================================================================
-- Debugging (DAP)
-- =============================================================================
keymap("n", "<leader>db", require("dap").toggle_breakpoint, { desc = "Toggle breakpoint" })
keymap("n", "<leader>dc", require("dap").continue, { desc = "Continue" })
keymap("n", "<leader>di", require("dap").step_into, { desc = "Step into" })
keymap("n", "<leader>do", require("dap").step_over, { desc = "Step over" })
keymap("n", "<leader>du", require("dap").step_out, { desc = "Step out" })
keymap("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "Open REPL" })
keymap("n", "<leader>dp", function()
  require("dap").pause()
end, { desc = "Pause" })
keymap("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })

-- =============================================================================
-- UI / Toggle
-- =============================================================================
keymap("n", "<leader>uz", "<cmd>ZenMode<CR>", { desc = "Zen Mode" })
keymap("n", "<leader>a", "<cmd>AerialToggle<CR>", { desc = "Aerial outline" })
keymap("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal" })

-- =============================================================================
-- Sessions
-- =============================================================================
keymap("n", "<leader>Se", "<cmd>Persisted load<CR>", { desc = "Load session" })
keymap("n", "<leader>Ss", "<cmd>Persisted save<CR>", { desc = "Save session" })
keymap("n", "<leader>St", "<cmd>Persisted toggle<CR>", { desc = "Toggle session" })

-- =============================================================================
-- Neovim
-- =============================================================================
keymap("n", "<leader>?", function()
  require("plugins.config.cheatsheet").open()
end, { desc = "Open cheatsheet" })
keymap("n", "<leader>m", "<cmd>Dashboard<CR>", { desc = "Dashboard" })
keymap("n", "<leader>up", "<cmd>Lazy<CR>", { desc = "Lazy" })
keymap("n", "<leader>um", "<cmd>Mason<CR>", { desc = "Mason" })
keymap("n", "<leader>ua", "<cmd>TSUpdate<CR>", { desc = "TS Update" })
keymap("n", "<leader>ui", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })

-- =============================================================================
-- WhichKey
-- =============================================================================
keymap("n", "<leader>wK", "<cmd>WhichKey<CR>", { desc = "WhichKey all" })

-- =============================================================================
-- Smart Splits
-- =============================================================================
keymap("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move left" })
keymap("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move down" })
keymap("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move up" })
keymap("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move right" })

-- Standard Vim window resize keybindings
keymap("n", "<C-w><", require("smart-splits").resize_left, { desc = "Resize left" })
keymap("n", "<C-w>>", require("smart-splits").resize_right, { desc = "Resize right" })
keymap("n", "<C-w>+", require("smart-splits").resize_down, { desc = "Resize down" })
keymap("n", "<C-w>-", require("smart-splits").resize_up, { desc = "Resize up" })

-- =============================================================================
-- Flash
-- =============================================================================
keymap("n", "<leader>s", function()
  require("flash").jump()
end, { desc = "Flash Jump" })
keymap("n", "<leader>ss", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
keymap("o", "<leader>r", function()
  require("flash").remote()
end, { desc = "Flash Remote" })
keymap("o", "<leader>R", function()
  require("flash").remote_treesitter()
end, { desc = "Flash Remote TS" })
