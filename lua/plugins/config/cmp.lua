-- Modern completion configuration
local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false }, -- don't auto-select first item; require explicit selection
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰆧",
        Constructor = "󰆧",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "󰠱",
        Module = "󰕳",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰒻",
        Keyword = "󰿅",
        Snippet = "󰩭",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "󰒻",
        Constant = "󰏿",
        Struct = "󰠱",
        TypeAlias = "󰕳",
        Event = "󰎁",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Table = "󰓊",
        Object = "󰅩",
        Tag = "󰓄",
        Array = "󰓊",
        Boolean = "󰨙",
        Number = "󰎠",
        Null = "󰟢",
        String = "󰉿",
        Calendar = "󰃭",
        Watch = "󰥔",
        Package = "󰏖",
        Dash = "󰓃",
        Codeium = "󰘚",
        Copilot = "󰘚",
        Rust = "󱘗",
        React = "󰔴",
      }

      vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind or "")
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      side_padding = 1,
    }),
    documentation = cmp.config.window.bordered({
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      max_height = 15,
    }),
  },
}

-- Slash cmdline completion
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer", keyword_length = 2 },
  },
})

-- Cmdline completion
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "cmdline", option = { ignore_cmdline_completion = true } },
    { name = "path" },
  },
})
