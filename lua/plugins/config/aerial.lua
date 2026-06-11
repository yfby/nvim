local ok, aerial = pcall(require, "aerial")
if not ok then
  return
end

aerial.setup({
  backends = { "treesitter", "lsp", "markdown" },
  link_tree_to_filetree = false,
  ignore = { ".git" },
  highlight = {
    enable = true,
    disable = function(_, buf)
      return vim.b[buf].aerial_large_file
    end,
  },
  max_width = 40,
  min_width = 20,
  default_sign = "▎",
  autojump = true,
  icons = {
    File = "󰈔",
    Module = "󰕳",
    Class = "󰠱",
    Method = "󰆧",
    Function = "󰆧",
    Property = "󰜢",
    Variable = "󰀫",
    Constant = "󰏿",
    Field = "󰜢",
    Enum = "󰒻",
    Unit = "󰑭",
    String = "󰉿",
    Number = "󰎠",
    Boolean = "󰨙",
    Array = "󰓊",
    Object = "󰅩",
    Key = "󰌆",
    Null = "󰟢",
    Package = "󰏖",
    Namespace = "󰕳",
  },
  filters = {
    dot = true,
  },
})
