require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
  },
  fast_wrap = {
    map = "<M-e>",
  },
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]",
  enable_moveright = true,
  disable_in_macro = false,
  disable_in_visualblock = false,
  enable_afterquote = true,
  enable_before_insert = true,
  map_insert_mode = true,
  disable_filetype = { "TelescopePrompt" },
  map_bs = true,
  map_cj = false,
  enable_breaker = false,
  map_cr = true,
  map_cn = false,
})

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
