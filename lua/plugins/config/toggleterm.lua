require("toggleterm").setup({
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  -- direction = "float",
  direction = "horizontal",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
  highlights = {
    Normal = {
      link = "Normal",
    },
    NormalFloat = {
      link = "NormalFloat",
    },
    FloatBorder = {
      link = "FloatBorder",
    },
  },
})

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "rounded",
    width = function()
      return math.floor(vim.o.columns * 0.8)
    end,
    height = function()
      return math.floor(vim.o.lines * 0.8)
    end,
  },
  on_open = function(term)
    vim.keymap.set("n", "q", term.close, { buffer = term.buf_id, nowait = true })
  end,
})

vim.keymap.set("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "Toggle LazyGit" })
