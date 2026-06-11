require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "dashboard", "alpha", "starter" },
      winbar = { "NvimTree", "oil", "toggleterm" },
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = "E",
          warn = "W",
          info = "I",
          hint = "H",
        },
      },
      { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      { "filename", path = 1, symbols = { modified = " ●", readonly = "", unnamed = "" } },
    },
    lualine_x = {
      {
        function()
          local msg = "No LSP"
          local clients = vim.lsp.get_clients()
          if next(clients) ~= nil then
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            msg = table.concat(names, ", ")
          end
          return msg
        end,
        icon = " LSP:",
      },
      "encoding",
      "fileformat",
    },
    lualine_y = {
      { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
      { "location", padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function()
        return " " .. os.date("%R")
      end,
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "oil", "toggleterm", "quickfix" },
})
