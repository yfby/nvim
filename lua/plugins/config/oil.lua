require("oil").setup({
  columns = {
    "icon",
    "permissions",
    "size",
    "modified",
  },
  skip_trailing_separator_on_line_end = true,
  use_default_keymaps = true,
  view_options = {
    show_hidden = true,
  },
  git = {
    add = function()
      return true
    end,
    mv = function()
      return true
    end,
    rm = function()
      return true
    end,
  },
  keymaps = {
    ["<leader>gh"] = "actions.git_add",
    ["<leader>gr"] = "actions.git_rm",
  },
})
