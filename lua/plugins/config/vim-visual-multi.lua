require("vim-visual-multi").setup({
  disable_after_cursor = true,
  enable_cursor_words = false,
  enable_gtab_navigation = false,
  stay_in_insert_mode = false,
  cursor_driven_live_filt = true,
  use_one_more = false,
  max_visual_scope = 10,
  search = {
    highlight = {
      screen_color = "CursorColumn",
    },
  },
  pair_synchro = {
    enabled = true,
    try_pairs = { "'", '"', "(", "[", "{" },
  },
  multimode = {
    enable = true,
    allow_single = false,
    disable_cmd = { "y", "d", "c", "!", "<", ">", "gq" },
    enable_default_mappings = false,
  },
  virtual_text = {
    enabled = true,
    prefix = "⊙",
  },
  default_mappings = false,
  maps = {
    ["<Esc>"] = "clear_multis",
    ["<C-n>"] = "select_next",
    ["<C-p>"] = "select_prev",
    ["<C-t>"] = "skip_region",
    ["<C-j>"] = "select_down",
    ["<C-k>"] = "select_up",
    ["<Right>"] = "expand_region",
    ["<Left>"] = "shrink_region",
    ["n"] = "next",
    ["N"] = "prev",
    ["q"] = "quit",
    ["<Plug>"] = "multicursor",
  },
})
