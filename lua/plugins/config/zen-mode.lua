-- Zen Mode configuration
require("zen-mode").setup {
  window = {
    backdrop = 0.95,
    width = 120,
    options = {
      signcolumn = "no",
      number = false,
      relativenumber = false,
      cursorline = false,
      cursorcolumn = false,
      foldcolumn = "0",
      list = false,
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
      laststatus = 0,
    },
    gitsigns = { enabled = false },
    tmux = { enabled = false },
    kitty = { enabled = false, font = "+2" },
  },
  on_leave = function()
    vim.cmd("set showtabline=2")
    vim.cmd("set laststatus=2")
  end,
}
