require("nvim-tree").setup({
  view = {
    width = 35,
    side = "right",
    number = false,
    relativenumber = false,
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    dotfiles = false,
    git_clean = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})
