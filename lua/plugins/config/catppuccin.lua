-- Catppuccin theme configuration
require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = false,
  show_end_of_buffer = false,
  styles = {
    bold = true,
    italic = true,
    underline = true,
  },
  integrations = {
    bufferline = true,
    cmp = true,
    gitsigns = true,
    treesitter = true,
    nvimtree = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      scope_color = "",
      colored_indent_levels = false,
    },
    telescope = {
      enabled = true,
    },
    dap = true,
    noice = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
      },
    },
    flash = true,
    mason = true,
    dashboard = true,
    lazy = true,
    markdown = true,
  },
  custom_highlights = function(colors)
    return {
      ["@comment"] = { italic = true },
      ["@keyword"] = { italic = true },
      ["@function"] = { bold = true },
      ["@method"] = { bold = true },
      ["@keyword.return"] = { bold = true },
    }
  end,
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
  term_colors = true,
})

vim.cmd.colorscheme("catppuccin")
