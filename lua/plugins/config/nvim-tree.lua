require("nvim-tree").setup({
  view = {
    number = false,
    relativenumber = false,
    width = 35,
    side = "right",
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
