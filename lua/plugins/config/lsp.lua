-- Modern LSP Configuration for Neovim 0.11+
-- Uses the new vim.lsp.config + vim.lsp.enable API instead of the deprecated
-- lspconfig.setup() pattern. Server configs are defined in server_configs below
-- and applied via mason-lspconfig's installed server list.
--
-- Architecture:
--   1. mason ensures all servers are installed
--   2. Each server gets capabilities from cmp-nvim-lsp (snippet support, etc.)
--   3. Per-server settings are defined in server_configs (only non-default values)
--   4. LspAttach autocmd sets buffer-local keymaps when any LSP connects
--   5. vim.lsp.config + vim.lsp.enable applies everything

local mason_lspconfig = require("mason-lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Add mason bin to PATH so LSP servers can be found in headless/CI environments
-- (e.g., when running `nvim --headless` for formatting or linting)
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.stdpath("data") .. "/mason/bin"

require("mason").setup({
  ensure_installed = {
    "ruff",
  },
})

-- Capabilities are advertised to each server so they know what completion
-- features we support (snippets, resolve, etc.)
local default_capabilities = cmp_nvim_lsp.default_capabilities()
default_capabilities.textDocument.completion.completionItem.snippetSupport = true

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "rust_analyzer",
    "gopls",
    "basedpyright",
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

-- Diagnostic display configuration
-- virtual_text: show error text inline at end of line
-- float: rounded border popup triggered by K or <leader>cd
-- severity_sort: show errors before warnings
vim.diagnostic.config({
  virtual_text = true,
  float = { border = "rounded", severity_sort = true },
  underline = true,
  signs = true,
  severity_sort = true,
  update_in_insert = false,
})

_G.diagnostics_enabled = true
function _G.toggle_diagnostics()
  diagnostics_enabled = not diagnostics_enabled
  vim.diagnostic.config({
    virtual_text = diagnostics_enabled,
    underline = diagnostics_enabled,
    signs = diagnostics_enabled,
  })
  vim.notify(diagnostics_enabled and "Diagnostics enabled" or "Diagnostics disabled")
end

-- LSP keymaps: set buffer-local when any LSP server attaches
-- These override the base mappings only for files with active LSP.
-- Using LspAttach autocmd ensures keymaps are available regardless of
-- which server attaches or in what order.
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
    keymap("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
      { buffer = bufnr, desc = "Previous diagnostic" })
    keymap("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
      { buffer = bufnr, desc = "Next diagnostic" })
    keymap("n", "<leader>dl", vim.diagnostic.setloclist, { buffer = bufnr, desc = "Diagnostic list" })
  end,
})

-- Per-server configuration overrides
-- Only non-default settings are included here. Servers without an entry
-- use default settings with the shared capabilities.
--
-- Why these settings matter:
--   rust-analyzer: allFeatures enables #[cfg(test)] blocks and feature-gated code
--   gopls: staticcheck for extra linting, gofumpt for stricter formatting
--   basedpyright: workspace-wide analysis catches cross-file type errors
--   ts_ls: inlay hints show parameter names and return types inline
--   lua_ls: suppresses "undefined global vim" warnings, provides Neovim API completions
--   clangd: inlay hints for C/C++ parameter types and chaining hints
--   volar: CSS modules plugin for Vue SFC <style> blocks
--   jdtls: Eclipse-sourced Java tooling with Maven support
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
  basedpyright = {
    settings = {
      basedpyright = {
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
        validate = {},
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
  -- jdtls is now handled by nvim-jdtls (plugins/config/jdtls.lua)
  -- Uncomment below if you want raw jdtls without nvim-jdtls features
  -- jdtls = {
  --   settings = {
  --     java = {
  --       eclipse = {
  --         downloadSources = true,
  --       },
  --       configuration = {
  --         updateBuildConfiguration = "interactive",
  --       },
  --       maven = {
  --         downloadSources = true,
  --       },
  --       implementationsCodeLens = {
  --         enabled = false,
  --       },
  --       referencesCodeLens = {
  --         enabled = false,
  --       },
  --       inlayHints = {
  --         parameterNames = {
  --           enabled = "all",
  --         },
  --       },
  --       format = {
  --         enabled = true,
  --       },
  --     },
  --   },
  -- },
}

-- Apply configs using the new vim.lsp.config API (Neovim 0.11+)
-- This replaces the deprecated lspconfig[server].setup(config) pattern.
-- Each server gets: default_capabilities + its specific overrides from server_configs.
-- If vim.lsp.config fails for a server (e.g., not recognized), we notify and continue.
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

-- Enable all configured servers at once
-- This triggers LspAttach for each server on matching filetypes
vim.lsp.enable(installed)
