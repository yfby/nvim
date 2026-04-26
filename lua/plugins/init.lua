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


-- Setup lazy.nvim
require("lazy").setup({
  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  -- Better status line
  'nvim-lualine/lualine.nvim',

  -- Dashboard
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("plugins.config.dashboard-nvim")
    end,
    dependencies = { 'mini.icons', 'nvim-web-devicons' },
  },

  -- File tree sidebar
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'mini.icons', 'nvim-web-devicons' },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
  },

  {
    "folke/todo-comments.nvim",
    cmd = { 'TodoTrouble', 'TodoTelescope' },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Better jumping/flying
  {
    'andyg/leap.nvim',
    url = 'https://codeberg.org/andyg/leap.nvim',
    event = 'VeryLazy',
    keys = {
      { 'gs', mode = { 'n', 'x', 'o' }, desc = 'Leap to windows' },
    },
  },

  -- Lazygit integration
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
  },

  -- Better folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    ft = { 'lua', 'vim', 'python', 'javascript', 'typescript', 'rust', 'go', 'c', 'cpp' },
  },

  -- Mini.nvim suite - modern, fast, lightweight utilities
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.bufremove").setup()
    end,
  },
  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup()
    end,
  },

  -- better command line UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- LSP STUFF!
  'neovim/nvim-lspconfig',
  'mason-org/mason.nvim',
  'mason-org/mason-lspconfig.nvim',

  -- Lua development (lazy load for lua files)
  {
    'folke/neodev.nvim',
    ft = 'lua',
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',
    },
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    ft = {
      'lua', 'vim', 'vimdoc',
      'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'jsx', 'tsx',
      'python', 'rust', 'go', 'c', 'cpp', 'java', 'bash', 'yaml', 'json', 'html', 'css',
      'markdown', 'markdown_inline',
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- Modern code formatting
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    opts = {},
  },

  -- Modern file explorer (edit directories like buffers)
  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    opts = {},
    dependencies = { 'mini.icons', 'nvim-web-devicons' },
  },

  -- Fast navigation with flashy labels
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Faster Lua LSP
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'lazy.nvim',      words = { 'LazyVim' } },
        { path = 'nvim-lspconfig', words = { 'lspconfig' } },
        { path = 'telescope.nvim', words = { 'telescope' } },
      },
    },
  },

  -- Modern testing framework
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
    },
    opts = {},
  },

  -- Git diff viewer
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
    opts = {},
  },

  -- Color preview
  {
    'NvChad/nvim-colorizer.lua',
    event = 'VeryLazy',
    opts = {},
  },

  -- Auto pairs for brackets/quotes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Show git changes
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'InsertEnter' },
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Git in vim (fugitive)
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gdiff', 'Glog', 'Gblame', 'Gpush', 'Gpull' },
  },

  -- Show indentations
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { 'BufReadPost' },
    opts = {}
  },

  -- Easily add comments
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
      require('Comment').setup()
    end,
  },

  -- Show keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.defer_fn(function()
        require("plugins.config.which-key")
      end, 100)
    end,
  },

  -- Searching
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },



  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },

  -- Buffer management
  {
    'akinsho/bufferline.nvim',
    event = { 'BufReadPost', 'TabNewEntered' },
    dependencies = { 'mini.icons', 'nvim-web-devicons' },
  },
  {
    'famiu/bufdelete.nvim',
  },



  -- Smart window splits (tmux + neovim)
  {
    'mrjones2014/smart-splits.nvim',
    opts = {},
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = { 'BufReadPost' },
    opts = {},
  },

  -- Peek definition
  {
    'rmagatti/goto-preview',
    cmd = 'GotoPreview',
    opts = {},
  },

  -- Quick file switching
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
  },

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  -- Distraction-free mode
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {},
  },



  -- Debugging (DAP)
  {
    'mfussenegger/nvim-dap',
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapStepInto', 'DapStepOver', 'DapStepOut' },
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      require("plugins.config.dap")
    end,
  },

  -- Mason DAP integration
  {
    'williamboman/mason-nvim-dap.nvim',
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        automatic_setup = true,
      })
    end,
  },

  -- Refactoring tools
  {
    'ThePrimeagen/refactoring.nvim',
    cmd = { 'RefactoringInlineVariable', 'RefactoringExtractVariable', 'RefactoringExtractFunction' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Pretty diagnostics list
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    opts = {},
  },

  -- Better quickfix
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {},
  },

  -- Session management
  {
    'olimorris/persisted.nvim',
  },

  -- Multi-cursor editing
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Git conflict resolution
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    cmd = { 'GitConflictChooseOurs', 'GitConflictChooseTheirs', 'GitConflictChooseBoth', 'GitConflictChooseNone' },
    opts = {},
  },



  -- Better window management
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Code outline sidebar
  {
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle', 'AerialOpen', 'AerialOpenAll' },
  },

  -- Task runner / build system integration
  {
    'stevearc/overseer.nvim',
    cmd = { 'OverseerRun', 'OverseerToggle', 'OverseerOpen' },
    config = function()
      require('plugins.config.overseer')
    end,
  },

  -- Linter integration
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost' },
    config = function()
      require('plugins.config.lint')
    end,
  },



  -- Check for plugin updates
  checker = { enabled = true },
})

-- Safe module loader
local loader = require("core.loader")

-- Load critical configs immediately (UI essentials)
local critical_configs = {
  "plugins.config.catppuccin",
  "plugins.config.lualine",
  "plugins.config.bufferline",
  "plugins.config.treesitter",
  "nvim-web-devicons",
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
      "plugins.config.toggleterm",
      "plugins.config.lsp",
      "plugins.config.noice",
      "plugins.config.cmp",
      "plugins.config.conform",
      "plugins.config.oil",
      "plugins.config.flash",
      "plugins.config.colorizer",
      "plugins.config.autopairs",
      "plugins.config.diffview",
      "plugins.config.goto-preview",
      "plugins.config.harpoon",
      "plugins.config.persisted",
      "plugins.config.cheatsheet",
      "plugins.config.trouble",
      "plugins.config.which-key",
      "plugins.config.git-conflict",
      "plugins.config.dap",
      "plugins.config.zen-mode",
      "plugins.config.neoscroll",
      "plugins.config.smart-splits",
      "plugins.config.refactoring",
      "plugins.config.gitsigns",
      "plugins.config.todo-comments",
      "plugins.config.bqf",
      "plugins.config.aerial",
      "plugins.config.neotest",
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
