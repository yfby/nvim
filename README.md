# Neovim Configuration

A modern, feature-rich Neovim configuration with Catppuccin theme.

## Plugins

### TODO: reconfig visuals, and add option for gruvbox theme

### Core

| Plugin                        | Description                    |
| ----------------------------- | ------------------------------ |
| **lazy.nvim**                 | Plugin manager                 |
| **catppuccin/nvim**           | Beautiful theme (Mocha flavor) |
| **nvim-lualine/lualine.nvim** | Status line                    |

### UI/UX

| Plugin                                  | Description           |
| --------------------------------------- | --------------------- |
| **glepnir/dashboard-nvim**              | Start screen          |
| **folke/which-key.nvim**                | Keybinding hints      |
| **folke/noice.nvim**                    | Better cmdline UI     |
| **folke/zen-mode.nvim**                 | Distraction-free mode |
| **folke/edgy.nvim**                     | Window management     |
| **lukas-reineke/indent-blankline.nvim** | Indent guides         |
| **NvChad/nvim-colorizer.lua**           | Color preview         |
| **stevearc/aerial.nvim**                | Code outline          |

### Navigation

| Plugin                            | Description               |
| --------------------------------- | ------------------------- |
| **nvim-tree/nvim-tree.lua**       | File tree                 |
| **stevearc/oil.nvim**             | File explorer (edit dirs) |
| **andyg/leap.nvim**               | Fast 2-char jumping       |
| **folke/flash.nvim**              | Motion with labels        |
| **karb94/neoscroll.nvim**         | Smooth scrolling          |
| **mrjones2014/smart-splits.nvim** | Tmux-like splits          |
| **akinsho/toggleterm.nvim**       | Terminal integration      |

### LSP & Completions

| Plugin                     | Description    |
| -------------------------- | -------------- |
| **neovim/nvim-lspconfig**  | LSP client     |
| **mason-org/mason.nvim**   | LSP installer  |
| **folke/lazydev.nvim**     | Lua LSP dev    |
| **folke/neodev.nvim**      | Neovim Lua API |
| **hrsh7th/nvim-cmp**       | Completion     |
| **L3MON4D3/LuaSnip**       | Snippets       |
| **stevearc/conform.nvim**  | Formatting     |
| **zbirenbaum/copilot.lua** | AI completion  |

### Treesitter & Parsing

| Plugin                                          | Description         |
| ----------------------------------------------- | ------------------- |
| **nvim-treesitter/nvim-treesitter**             | Syntax highlighting |
| **nvim-treesitter/nvim-treesitter-textobjects** | Text objects        |
| **kevinhwang91/nvim-ufo**                       | Better folding      |

### Git

| Plugin                        | Description         |
| ----------------------------- | ------------------- |
| **lewis6991/gitsigns.nvim**   | Git signs           |
| **sindrets/diffview.nvim**    | Diff viewer         |
| **kdheepak/lazygit.nvim**     | LazyGit integration |
| **akinsho/git-conflict.nvim** | Conflict resolution |
| **tpope/vim-rhubarb**         | GitHub integration  |
| **rhysd/git-messenger.vim**   | Inline blame        |

### Telescope

| Plugin                                       | Description     |
| -------------------------------------------- | --------------- |
| **nvim-telescope/telescope.nvim**            | Fuzzy finder    |
| **nvim-telescope/telescope-fzf-native.nvim** | FZF sorter      |
| **nvim-telescope/telescope-dap.nvim**        | DAP integration |

### Debugging

| Plugin                              | Description            |
| ----------------------------------- | ---------------------- |
| **mfussenegger/nvim-dap**           | Debug adapter protocol |
| **rcarriga/nvim-dap-ui**            | DAP UI                 |
| **theHamsta/nvim-dap-virtual-text** | Inline values          |

### Utilities

| Plugin                            | Description                        |
| --------------------------------- | ---------------------------------- |
| **echasnovski/mini.nvim**         | Mini utilities (AI, surround, etc) |
| **echasnovski/mini.icons**        | File icons                         |
| **numToStr/Comment.nvim**         | Commenting                         |
| **windwp/nvim-autopairs**         | Auto pairs                         |
| **tpope/vim-sleuth**              | Auto indent                        |
| **akinsho/bufferline.nvim**       | Tab bar                            |
| **famiu/bufdelete.nvim**          | Buffer deletion                    |
| **ThePrimeagen/harpoon**          | Quick file access                  |
| **folke/todo-comments.nvim**      | TODO highlighting                  |
| **folke/trouble.nvim**            | Diagnostics list                   |
| **kevinhwang91/nvim-bqf**         | Better quickfix                    |
| **olimorris/persisted.nvim**      | Session management                 |
| **ThePrimeagen/refactoring.nvim** | Refactoring tools                  |
| **rmagatti/goto-preview**         | Peek definitions                   |
| **mg979/vim-visual-multi**        | Multi-cursor                       |

## Key Features

- **Catppuccin Theme**: Beautiful dark theme with full integration
- **Smart LSP**: Auto-configured LSP servers with Mason
- **Fast Navigation**: Leap, Telescope, and smart splits
- **Git Integration**: Full git workflow with LazyGit, diffview, gitsigns
- **Debugging**: Full DAP support with UI
- **Productivity**: Refactoring, sessions, harpoon quick access
- **AI Assistance**: GitHub Copilot integration

## Keybindings

Press `<Space>` followed by a key to see which-key popup.

| Leader       | Description           |
| ------------ | --------------------- |
| `<Space>`    | Leader key            |
| `<leader>e`  | NvimTree toggle       |
| `<leader>ff` | Find files            |
| `<leader>fg` | Live grep             |
| `<leader>fb` | Buffers               |
| `<leader>/`  | Search in buffer      |
| `<leader>x`  | Delete buffer         |
| `<leader>uf` | Format buffer         |
| `<leader>xx` | Diagnostics           |
| `<leader>gg` | LazyGit               |
| `<leader>gd` | Diff view             |
| `<leader>dc` | DAP continue          |
| `<leader>db` | DAP breakpoint        |
| `<leader>Se` | Load session          |
| `<leader>hh` | Harpoon menu          |
| `<leader>uz` | Zen mode              |
| `<leader>?`  | Cheatsheet            |
| `<leader>ul` | Lazy (plugin manager) |
| `<leader>um` | Mason (LSP manager)   |

## LSP Servers

Auto-installed via Mason:

- lua_ls, ts_ls, rust_analyzer, gopls, pyright, clangd
- bashls, jsonls, yamlls, html, cssls, tailwindcss, marksman

## Installation

```bash
git clone https://github.com/yourname/nvim-config ~/.config/nvim
nvim
:Lazy sync
```

## Dependencies

Required:

- Neovim 0.10+
- git
- ripgrep (for Telescope)
- fd (for Telescope)

Optional:

- node/npm (for JS/TS LSPs)
- python (for pyright)
- rust (for rust-analyzer)
- go (for gopls)
- make (for building)
