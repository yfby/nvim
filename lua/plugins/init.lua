-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Shared dependencies referenced by multiple plugins
local shared_deps = {
  "nvim-lua/plenary.nvim",
}

require("lazy").setup({
  -- Theme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
  },

  -- Better status line
  "nvim-lualine/lualine.nvim",

  -- Dashboard
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("plugins.config.dashboard-nvim")
    end,
    dependencies = { "echasnovski/mini.icons" },
  },

  -- File tree sidebar
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "echasnovski/mini.icons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    dependencies = shared_deps,
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  },

  -- Better folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    ft = { "lua", "vim", "python", "javascript", "typescript", "rust", "go", "c", "cpp", "java" },
  },

  -- Mini.nvim individual modules (instead of full suite)
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.bufremove",
    lazy = true,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = {},
  },

  -- Better command line UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    ft = {
      "lua", "vim", "vimdoc",
      "javascript", "typescript", "javascriptreact", "typescriptreact", "jsx", "tsx",
      "python", "rust", "go", "c", "cpp", "java", "bash", "yaml", "json", "html", "css",
      "markdown", "markdown_inline",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },

  -- Modern code formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    config = function()
      require("plugins.config.conform")
    end,
  },

  -- Modern file explorer (edit directories like buffers)
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      require("plugins.config.oil")
    end,
  },

  -- Fast navigation with flashy labels
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Faster Lua LSP
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "lazy.nvim",      words = { "LazyVim" } },
        { path = "telescope.nvim", words = { "telescope" } },
      },
    },
  },

  -- Git diff viewer
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    config = function()
      require("plugins.config.diffview")
    end,
  },

  -- Color preview
  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto pairs for brackets/quotes (with CMP integration)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.config.autopairs")
    end,
  },

  -- Dot-repeat support (makes mini.surround, flash, etc. repeatable with .)
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Show git changes
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "InsertEnter" },
    config = function()
      require("plugins.config.gitsigns")
    end,
  },

  -- Git in vim (fugitive)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiff", "Glog", "Gblame", "Gpush", "Gpull" },
  },

  -- Show indentations
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost" },
    opts = {},
  },

  -- Treesitter-aware commenting (replaces Comment.nvim)
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Show keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.config.which-key")
    end,
  },

  -- Searching
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      shared_deps[1],
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.config.toggleterm")
    end,
  },

  -- Buffer management
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPost", "TabNewEntered" },
    dependencies = { "echasnovski/mini.icons" },
  },
  {
    "famiu/bufdelete.nvim",
  },

  -- Smart window splits (tmux + neovim)
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = { "BufReadPost" },
    opts = {},
  },

  -- Peek definition
  {
    "rmagatti/goto-preview",
    cmd = "GotoPreview",
    opts = {},
  },

  -- Quick file switching
  {
    "ThePrimeagen/harpoon",
    dependencies = shared_deps,
    event = "VeryLazy",
  },

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  -- Distraction-free mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {},
  },

  -- Debugging (DAP)
  {
    "mfussenegger/nvim-dap",
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepInto", "DapStepOver", "DapStepOut" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("plugins.config.dap")
    end,
  },

  -- Mason DAP integration
  {
    "williamboman/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        automatic_setup = true,
      })
    end,
  },

  -- Refactoring tools
  {
    "ThePrimeagen/refactoring.nvim",
    cmd = { "RefactoringInlineVariable", "RefactoringExtractVariable", "RefactoringExtractFunction" },
    dependencies = shared_deps,
  },

  -- Pretty diagnostics list
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {},
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {},
  },

  -- Session management
  {
    "olimorris/persisted.nvim",
  },

  -- Multi-cursor editing
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    init = function()
      require("plugins.config.vim-visual-multi")
    end,
  },

  -- Git conflict resolution
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    cmd = { "GitConflictChooseOurs", "GitConflictChooseTheirs", "GitConflictChooseBoth", "GitConflictChooseNone" },
    opts = {},
  },

  -- Better window management
  {
    "folke/edgy.nvim",
    cmd = { "EdgyOpen", "EdgyClose", "EdgyToggle" },
    opts = {},
  },

  -- Code outline sidebar
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll" },
  },

  -- Task runner / build system integration
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle", "OverseerOpen" },
    config = function()
      require("plugins.config.overseer")
    end,
  },

  -- Linter integration
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      require("plugins.config.lint")
    end,
  },

  -- Java development (jdtls wrapper with DAP, test runner, refactoring)
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- Split/join code blocks (treesitter-aware)
  {
    "Wansmer/treesj",
    keys = {
      { "<leader>j", function() require("treesj").toggle() end,                                 desc = "Toggle split/join" },
      { "<leader>J", function() require("treesj").toggle({ split = { recursive = true } }) end, desc = "Toggle split/join (recursive)" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 150,
      })
    end,
  },

  -- Project-wide search and replace
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = {},
  },

  -- Interactive REPL
  {
    "Vigemus/iron.nvim",
    cmd = { "IronRepl", "IronRestart", "IronHide", "IronFocus" },
    config = function()
      require("iron.core").setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            sh = { command = { "bash" } },
            python = { command = { "python" } },
            lua = { command = { "lua" } },
            javascript = { command = { "node" } },
            typescript = { command = { "ts-node" } },
            go = { command = { "gorepl" } },
            java = { command = { "jshell" } },
          },
          repl_open_cmd = require("iron.view").split.horizontal.botright(0.4),
        },
        keymaps = {
          send_motion = "<leader>rs",
          visual_send = "<leader>rs",
          send_file = "<leader>rf",
          send_line = "<leader>rl",
          send_mark = "<leader>rm",
          mark_motion = "<leader>rmm",
          mark_visual = "<leader>rmv",
          remove_mark = "<leader>rmd",
          cr = "<leader>r<cr>",
          interrupt = "<leader>rq",
          exit = "<leader>rx",
          clear = "<leader>rc",
        },
        highlight = {
          italic = true,
        },
      })
    end,
  },

  -- Neotest (test runner UI)
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
      "rcarriga/nvim-dap-ui",
    },
    cmd = { "Neotest", "NeotestRun", "NeotestSummary", "NeotestOutput" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
          require("neotest-vitest"),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        summary = { open = "botright vsplit | vertical resize 50" },
      })
    end,
  },

  -- Smart folding UX
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    tag = "v1.9",
    opts = {},
  },

  -- Check for plugin updates
  checker = { enabled = true },
})

-- =============================================================================
-- Config Loading Strategy (deferred via safe_require)
-- =============================================================================
local loader = require("core.loader")

-- Load critical configs immediately (UI essentials)
local critical_configs = {
  "plugins.config.theme",
  "plugins.config.lualine",
  "plugins.config.bufferline",
  "plugins.config.treesitter",
}

for _, module in ipairs(critical_configs) do
  loader.safe_require(module)
end

-- Defer non-critical configs to after VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local deferred_configs = {
      "plugins.config.indent-blankline",
      "plugins.config.nvim-tree",
      "plugins.config.telescope",
      "plugins.config.lsp",
      "plugins.config.noice",
      "plugins.config.cmp",
      "plugins.config.flash",
      "plugins.config.colorizer",
      "plugins.config.goto-preview",
      "plugins.config.harpoon",
      "plugins.config.persisted",
      "plugins.config.cheatsheet",
      "plugins.config.trouble",
      "plugins.config.git-conflict",
      "plugins.config.dap",
      "plugins.config.zen-mode",
      "plugins.config.neoscroll",
      "plugins.config.smart-splits",
      "plugins.config.refactoring",
      "plugins.config.jdtls",
      "plugins.config.todo-comments",
      "plugins.config.bqf",
      "plugins.config.aerial",
      "plugins.config.ufo",
      "plugins.config.copilot",
      "plugins.autocmds",
    }

    for _, module in ipairs(deferred_configs) do
      loader.safe_require(module)
    end
  end,
  once = true,
})

-- Load plugin keymaps after plugins are loaded
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    loader.safe_require("plugins.mappings")
  end,
  once = true,
})
