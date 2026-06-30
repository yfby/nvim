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
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
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

-- LazyGit
vim.keymap.set("n", "<leader>gg", function()
  lazygit:toggle()
end, { desc = "Toggle LazyGit" })

-- Cycle terminal direction: float -> horizontal -> vertical -> float
local term_directions = { "float", "horizontal", "vertical" }
local current_direction_idx = 1

vim.keymap.set("n", "<leader>tC", function()
  current_direction_idx = (current_direction_idx % #term_directions) + 1
  local dir = term_directions[current_direction_idx]
  require("toggleterm").toggle(0, nil, dir)
end, { desc = "Cycle terminal direction" })

-- Multiple named terminals
local terminals = {}

local function get_or_create_term(name, cmd, dir)
  if not terminals[name] then
    terminals[name] = Terminal:new({
      cmd = cmd,
      dir = dir or "git_dir",
      direction = "float",
      float_opts = {
        border = "rounded",
        width = function() return math.floor(vim.o.columns * 0.7) end,
        height = function() return math.floor(vim.o.lines * 0.6) end,
      },
    })
  end
  return terminals[name]
end

vim.keymap.set("n", "<leader>tR", function()
  get_or_create_term("python", "python"):toggle()
end, { desc = "Toggle Python REPL" })

vim.keymap.set("n", "<leader>tN", function()
  get_or_create_term("node", "node"):toggle()
end, { desc = "Toggle Node REPL" })
