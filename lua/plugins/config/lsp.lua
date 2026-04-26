-- Modern LSP Configuration for Neovim 0.11+
local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Add mason bin to PATH for headless operation
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

require("mason").setup()

-- Get default capabilities from cmp and enhance them
local default_capabilities = cmp_nvim_lsp.default_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "pyright",
    "clangd",
    "bashls",
    "jsonls",
    "yamlls",
    "html",
    "cssls",
    "tailwindcss",
    "marksman",
    "volar",
    "astro",
    "emmet_language_server",
    "svelte",
    "phpactor",
    "dockerfile_language_server",
    "sqls",
    "stylelint_lint",
  },
  automatic_installation = true,
})

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded", severity_sort = true },
  underline = true,
  severity_sort = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
  callback = function(args)
    local client = args.data.client_id and vim.lsp.get_client_by_id(args.data.client_id) or args.client
    if not client then return end

    local bufnr = args.buf
    local keymap = vim.keymap.set

    keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    keymap("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover docs" })
    keymap("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
    keymap("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
    keymap("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    keymap("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
    keymap("n", "<leader>cd", vim.diagnostic.open_float, { buffer = bufnr, desc = "Line diagnostics" })
    keymap("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
    keymap("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
    keymap("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic list" })
  end,
})

-- Server configurations
local server_configs = {
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          allFeatures = true,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
  pyright = {
    settings = {
      pyright = {
        disableLanguageServices = false,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        completion = { callSnippet = "Replace" },
      },
    },
  },
  clangd = {
    settings = {
      clangd = {
        InlayHints = {
          Enabled = true,
          ParameterHints = true,
          TypeHints = true,
          ChainingHints = true,
        },
      },
    },
  },
  bashls = {
    filetypes = { "sh", "bash" },
  },
  volar = {
    settings = {
      typescript = {
        tsserver = {
          plugins = {
            { url = "typescript-plugin-css-modules" }
          }
        }
      },
      css = {
        validate = { },
        completion = {
          triggerPropertyValueCompletion = true,
          completionPropertyValue = { enable = true }
        }
      },
      tailwindCSS = {
        suggestFromUseClassAttribute = true,
        interopClassAttrDefaultName = "class"
      }
    },
  },
  svelte = {
    settings = {
      svelte = {
        check = {
          enabled = true,
          diagnostics = {
            enabled = true
          }
        }
      }
    },
  },
  astro = {
    settings = {
      typescript = {
        tsserver = {
          plugins = {
            { url = "typescript-plugin-css-modules" }
          }
        }
      }
    },
  },
  phpactor = {
    settings = {
      phpactor = {
        completion = {
          enable = true,
          caseStudy = true
        },
        diagnostic = {
          enabled = true
        }
      }
    },
  },
  dockerfile_language_server = {
    settings = {
      dockerfile = {
        linting = {
          enabled = true
        }
      }
    },
  },
  sqls = {
    settings = {
      sqls = {
        autoSave = true,
        hover = true,
        format = true
      }
    },
  },
}

-- Setup servers using the new vim.lsp.config API
local installed = mason_lspconfig.get_installed_servers()
for _, server_name in ipairs(installed) do
  local config = vim.deepcopy(server_configs[server_name] or {})
  config.capabilities = default_capabilities
  
  local ok, err = pcall(function()
    vim.lsp.config(server_name, config)
  end)
  
  if not ok then
    vim.notify(
      "Failed to setup LSP server '" .. server_name .. "':\n" .. tostring(err),
      vim.log.levels.WARN
    )
  end
end

-- Enable the configured servers
vim.lsp.enable(installed)




