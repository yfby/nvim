-- Modern Neovim options
local opt = vim.opt

-- Clipboard
opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true
opt.relativenumber = false
opt.numberwidth = 2

-- Tabs/indent
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
-- opt.fillchars = { eob = " " }
opt.cursorline = false
opt.showmode = false
opt.showtabline = 2
opt.splitbelow = true
opt.splitright = true
-- Only set guifont for GUI environments (not terminal)
if vim.fn.has("gui_running") == 1 then
  opt.guifont = "JetBrainsMono Nerd Font:h17"
end

-- Behavior
opt.mouse = "a"
opt.pumheight = 10
opt.timeoutlen = 1000
opt.updatetime = 300
opt.writebackup = false
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.fileencoding = "utf-8"

-- Completion
opt.completeopt = { "menuone", "noselect" }

-- Conceal (0 = disabled; set to 2 to enable treesitter conceal features)

-- Messages
opt.cmdheight = 2
opt.shortmess:append "c"

-- Whichwrap
opt.whichwrap:append("<,>,[,],h,l")

-- Keywords
opt.iskeyword:append("-")
opt.formatoptions:remove("c", "r", "o")
