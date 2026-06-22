# Neovim Configuration

A modern, feature-rich Neovim configuration built on Lua with Gruvbox theme, targeting Neovim 0.10+.

## Architecture

```
init.lua                    # Entry point: loads core + plugins
lua/
  core/                     # Core Neovim settings (no plugins)
    init.lua                # Orchestrator: loads options then mappings
    options.lua             # vim.opt settings (tabs, search, appearance, etc.)
    mappings.lua            # Base keybindings (leader, buffer nav, text movement)
    loader.lua              # safe_require() utility for resilient module loading
  plugins/                  # Plugin management layer
    init.lua                # lazy.nvim bootstrap + full plugin spec (73+ plugins)
    autocmds.lua            # Autocommands (yank highlight, ft-specific settings)
    mappings.lua            # Plugin-specific keybindings (all <leader> mappings)
    config/                 # Individual plugin configuration files (40 files)
```

### Loading Strategy

Configs are split into two tiers to optimize startup time:

1. **Critical configs** load immediately: theme, lualine, bufferline, treesitter, web-devicons
2. **Non-critical configs** defer to `VimEnter` via `safe_require()`: LSP, CMP, Telescope, DAP, and everything else
3. **Plugin keymaps** load last in a separate `VimEnter` autocmd

This prevents a broken plugin config from blocking startup. If a deferred config fails, Neovim still starts normally with a notification.

## Plugins

### Core

| Plugin                        | Description                    |
| ----------------------------- | ------------------------------ |
| **lazy.nvim**                 | Plugin manager                 |
| **ellisonleao/gruvbox.nvim**  | Gruvbox color scheme           |
| **nvim-lualine/lualine.nvim** | Status line                    |

### UI/UX

| Plugin                                  | Description                |
| --------------------------------------- | -------------------------- |
| **glepnir/dashboard-nvim**              | Start screen               |
| **folke/which-key.nvim**                | Keybinding hints           |
| **folke/noice.nvim**                    | Better cmdline UI          |
| **folke/zen-mode.nvim**                 | Distraction-free mode      |
| **folke/edgy.nvim**                     | Window management          |
| **folke/trouble.nvim**                  | Diagnostics list           |
| **lukas-reineke/indent-blankline.nvim** | Indent guides              |
| **NvChad/nvim-colorizer.lua**           | Color preview              |
| **stevearc/aerial.nvim**                | Code outline sidebar       |
| **rcarriga/nvim-notify**                | Notification UI            |
| **MunifTanjim/nui.nvim**                | UI component library       |

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

| Plugin                         | Description        |
| ------------------------------ | ------------------ |
| **neovim/nvim-lspconfig**      | LSP client         |
| **williamboman/mason.nvim**    | LSP installer      |
| **williamboman/mason-lspconfig.nvim** | Mason LSP bridge |
| **williamboman/mason-nvim-dap.nvim** | Mason DAP bridge |
| **folke/lazydev.nvim**         | Lua LSP dev        |
| **hrsh7th/nvim-cmp**           | Completion         |
| **L3MON4D3/LuaSnip**           | Snippets           |
| **stevearc/conform.nvim**      | Formatting         |
| **mfussenegger/nvim-lint**     | Linting            |
| **zbirenbaum/copilot.lua**     | AI completion      |

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
| **tpope/vim-fugitive**        | Git in vim          |
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
| **mfussenegger/nvim-dap-python**    | Python DAP adapter     |

### Testing

| Plugin                              | Description        |
| ----------------------------------- | ------------------ |
| **nvim-neotest/neotest**            | Testing framework  |
| **nvim-neotest/nvim-nio**           | Async IO library   |

### Task Runner

| Plugin                              | Description             |
| ----------------------------------- | ----------------------- |
| **stevearc/overseer.nvim**          | Task runner / build system |

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
| **kevinhwang91/nvim-bqf**         | Better quickfix                    |
| **olimorris/persisted.nvim**      | Session management                 |
| **ThePrimeagen/refactoring.nvim** | Refactoring tools                  |
| **rmagatti/goto-preview**         | Peek definitions                   |
| **mg979/vim-visual-multi**        | Multi-cursor                       |

## Keybindings

Leader key is `<Space>`. Press `<Space>` and wait for which-key popup, or open the floating cheatsheet with `<leader>?`.

### Find / File (`<leader>f`)

| Key         | Description              |
| ----------- | ------------------------ |
| `<leader>ff`| Find files               |
| `<leader>fg`| Live grep                |
| `<leader>fr`| Recent files             |
| `<leader>fb`| Find buffers             |
| `<leader>fc`| Find commands            |
| `<leader>fk`| Find keymaps             |
| `<leader>fh`| Help tags                |
| `<leader>fs`| Treesitter symbols       |
| `<leader>fl`| LSP document symbols     |
| `<leader>ft`| Find TODOs               |
| `<leader>/` | Search current buffer    |

### LSP (`<leader>c` / Defaults)

| Key         | Description              |
| ----------- | ------------------------ |
| `gd`        | Go to definition         |
| `gD`        | Go to declaration        |
| `gi`        | Go to implementation     |
| `K`         | Hover documentation      |
| `<C-k>`     | Signature help           |
| `gr`        | Find references          |
| `<leader>ca`| Code action              |
| `<leader>cr`| Rename symbol            |
| `<leader>cd`| Line diagnostics         |
| `[d` / `]d` | Prev/next diagnostic     |
| `<leader>dl`| Diagnostic list          |

### Git (`<leader>g`)

| Key          | Description             |
| ------------ | ----------------------- |
| `<leader>gg` | LazyGit                 |
| `<leader>gL` | LazyGit (current file)  |
| `<leader>gd` | Open diff view          |
| `<leader>gD` | Close diff view         |
| `<leader>gm` | Git messenger           |
| `<leader>gh` | GitHub browse           |
| `<leader>gfc`| Git commit              |
| `<leader>gfa`| Git amend               |
| `<leader>gfp`| Git push                |
| `<leader>gfu`| Git pull                |
| `<leader>gfr`| Git rebase              |
| `<leader>gfl`| Git log                 |
| `<leader>gfd`| Git diff split          |
| `<leader>gfs`| Git status              |

### Git Conflict (`<leader>gc`)

| Key           | Description          |
| ------------- | -------------------- |
| `<leader>gco` | Choose ours          |
| `<leader>gct` | Choose theirs        |
| `<leader>gcb` | Choose both          |
| `<leader>gcn` | Choose none          |
| `<leader>gca` | Accept current       |
| `<leader>gcc` | Choose all           |

### Debug (`<leader>d`)

| Key          | Description                  |
| ------------ | ---------------------------- |
| `<leader>dc` | Continue                     |
| `<leader>db` | Toggle breakpoint            |
| `<leader>dB` | Conditional breakpoint       |
| `<leader>di` | Step into                    |
| `<leader>do` | Step over                    |
| `<leader>du` | Step out                     |
| `<leader>dp` | Pause                        |
| `<leader>dr` | Open REPL                    |
| `<leader>dd` | DAP breakpoints (Telescope)  |
| `<leader>dv` | DAP variables (Telescope)    |
| `<leader>df` | DAP frames (Telescope)       |

### File Operations

| Key         | Description              |
| ----------- | ------------------------ |
| `<leader>e` | Toggle NvimTree          |
| `-`         | Open parent directory (Oil) |
| `<leader>x` | Delete buffer            |

### Formatting & Linting

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>uf` | Format buffer            |
| `<leader>ul` | Lint buffer              |

### Trouble / Diagnostics (`<leader>x`)

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>xx` | Diagnostics              |
| `<leader>xX` | Buffer diagnostics       |
| `<leader>xs` | Symbols                  |
| `<leader>xl` | LSP references           |
| `<leader>xq` | Quickfix                 |
| `<leader>xt` | TODOs                    |
| `<leader>xT` | Buffer TODOs             |

### Sessions (`<leader>S`)

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>Se` | Load session             |
| `<leader>Ss` | Save session             |
| `<leader>St` | Toggle session           |

### Harpoon (`<leader>h`)

| Key         | Description              |
| ----------- | ------------------------ |
| `<leader>ha`| Add file                 |
| `<leader>hh`| Toggle menu              |
| `<leader>h1`-`<leader>h4` | Jump to file 1-4  |

### Flash

| Key         | Description                      |
| ----------- | -------------------------------- |
| `<leader>s` | Flash jump                       |
| `<leader>ss`| Flash Treesitter                 |
| `<leader>r` | Flash remote (operator-pending)  |
| `<leader>R` | Flash remote treesitter          |

### Windows / UI

| Key            | Description              |
| -------------- | ------------------------ |
| `<C-h/j/k/l>` | Navigate splits          |
| `<C-w><</>>`  | Resize left/right        |
| `<C-w>+/-`    | Resize down/up           |
| `<leader>uz`  | Zen mode                 |
| `<leader>a`   | Aerial outline           |
| `<C-\>`       | Toggle terminal          |
| `<leader>m`   | Dashboard                |
| `<leader>?`   | Cheatsheet               |

### Refactor (`<leader>r`, visual mode)

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>rev`| Extract variable         |
| `<leader>ref`| Extract function         |
| `<leader>reb`| Extract block            |
| `<leader>ri` | Inline variable          |

### Neovim

| Key          | Description              |
| ------------ | ------------------------ |
| `<leader>up` | Lazy (plugin manager)    |
| `<leader>um` | Mason (LSP manager)      |
| `<leader>ui` | LSP info                 |
| `<leader>ua` | Treesitter update        |
| `<leader>uw` | WhichKey all             |

### Base Mappings

| Key          | Description              |
| ------------ | ------------------------ |
| `jk`         | Exit insert mode         |
| `<S-l>`      | Next buffer              |
| `<S-h>`      | Previous buffer          |
| `<A-j/k>`    | Move line down/up        |
| `gc` / `gb`  | Comment line/block       |
| `gcc`        | Comment current line     |

## LSP Servers

Auto-installed via Mason:

| Server                    | Notes                                         |
| ------------------------- | --------------------------------------------- |
| **lua_ls**                | Lua language server (LuaJIT runtime)          |
| **ts_ls**                 | TypeScript/JavaScript with inlay hints        |
| **rust_analyzer**         | Rust with all features enabled                |
| **gopls**                 | Go with staticcheck + gofumpt                 |
| **pyright**               | Python with workspace-wide analysis           |
| **clangd**                | C/C++ with inlay hints                        |
| **bashls**                | Bash/Shell                                    |
| **jsonls** / **yamlls**   | JSON/YAML                                     |
| **html** / **cssls**      | HTML/CSS                                      |
| **tailwindcss**           | Tailwind CSS                                  |
| **volar**                 | Vue.js with CSS modules plugin                |
| **svelte**                | Svelte with type checking                     |
| **astro**                 | Astro with CSS modules                        |
| **emmet_language_server** | Emmet abbreviations                           |
| **phpactor**              | PHP                                           |
| **dockerfile_language_server** | Dockerfile                               |
| **sqls**                  | SQL                                           |
| **jdtls**                 | Java with Eclipse settings                    |
| **marksman**              | Markdown                                      |
| **stylelint_lint**        | CSS/SCSS linting                              |

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

- node/npm (for JS/TS LSPs and Copilot)
- python (for pyright and DAP)
- rust (for rust-analyzer)
- go (for gopls)
- make (for building telescope-fzf-native)
