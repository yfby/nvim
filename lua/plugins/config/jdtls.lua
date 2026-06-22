-- nvim-jdtls configuration
-- Provides enhanced Java development: DAP debugging, test runner, auto-imports,
-- extract method/field, and better Maven/Gradle integration than raw jdtls.
--
-- Requirements:
--   - JDK 17+ installed and on PATH (or set JAVA_HOME)
--   - jdtls installed via Mason: :MasonInstall jdtls
--   - Debug adapter installed via Mason: :MasonInstall java-debug-adapter
--   - Test adapter installed via Mason: :MasonInstall java-test

local jdtls = require("jdtls")

-- Find Java installation
local function get_java_cmd()
  local java_home = os.getenv("JAVA_HOME")
  if java_home then
    return java_home .. "/bin/java"
  end
  return "java"
end

-- Find jdtls installation from Mason
local function get_jdtls_path()
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local jdtls_path = mason_path .. "/packages/jdtls"
  if vim.fn.isdirectory(jdtls_path) == 1 then
    return jdtls_path
  end
  return nil
end

-- Find java-debug-adapter installation
local function get_java_debug_path()
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local debug_path = mason_path .. "/packages/java-debug-adapter"
  if vim.fn.isdirectory(debug_path) == 1 then
    return debug_path
  end
  return nil
end

-- Find java-test installation
local function get_java_test_path()
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local test_path = mason_path .. "/packages/java-test"
  if vim.fn.isdirectory(test_path) == 1 then
    return test_path
  end
  return nil
end

-- Get the launcher jar path for jdtls
local function get_jdtls_launcher(jdtls_path)
  local plugins_dir = jdtls_path .. "/plugins"
  local launcher = vim.fn.glob(plugins_dir .. "/org.eclipse.equinox.launcher_*.jar")
  if launcher ~= "" then
    return launcher
  end
  return nil
end

-- Detect build tool and return the config coroutine
local function get_workspace_config()
  local cwd = vim.fn.getcwd()
  local config = {
    linux = {
      java = {
        configuration = {
          updateBuildConfiguration = "interactive",
        },
        maven = {
          downloadSources = true,
        },
        eclipse = {
          downloadSources = true,
        },
        referencesCodeLens = {
          enabled = true,
        },
        implementationCodeLens = {
          enabled = true,
        },
        inlayHints = {
          parameterNames = {
            enabled = "all",
          },
        },
        saveActions = {
          organizeImports = true,
        },
        autobuild = {
          enabled = true,
        },
        format = {
          enabled = true,
        },
      },
    },
  }
  return vim.fn.has("win32") == 1 and config.windows or config.linux
end

-- Main jdtls setup function, called per-buffer for java files
local function setup_jdtls()
  local jdtls_path = get_jdtls_path()
  if not jdtls_path then
    vim.notify("jdtls not found in Mason. Run :MasonInstall jdtls", vim.log.levels.ERROR)
    return
  end

  local launcher = get_jdtls_launcher(jdtls_path)
  if not launcher then
    vim.notify("jdtls launcher jar not found in " .. jdtls_path, vim.log.levels.ERROR)
    return
  end

  -- Workspace directory per-project (unique per root)
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

  -- Paths for jdtls bundles
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  local bundles = {}

  -- Add java-debug-adapter to bundles if installed
  local debug_path = get_java_debug_path()
  if debug_path then
    local debug_jar = vim.fn.glob(debug_path .. "/server/*.jar")
    if debug_jar ~= "" then
      table.insert(bundles, debug_jar)
    end
    -- Also add the bundles from the plugin directory
    local debug_bundles = vim.fn.glob(debug_path .. "/server/plugins/*.jar", false, true)
    for _, jar in ipairs(debug_bundles) do
      table.insert(bundles, jar)
    end
  end

  -- Add java-test to bundles if installed
  local test_path = get_java_test_path()
  if test_path then
    local test_jars = vim.fn.glob(test_path .. "/server/*.jar", false, true)
    for _, jar in ipairs(test_jars) do
      table.insert(bundles, jar)
    end
  end

  local config = {
    cmd = {
      get_java_cmd(),
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      launcher,
      "-configuration",
      jdtls_path .. "/config_" .. (vim.fn.has("mac") == 1 and "mac" or vim.fn.has("linux") == 1 and "linux" or "win"),
      "-data",
      workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({
      ".git",
      "mvnw",
      "gradlew",
      "pom.xml",
      "build.gradle",
      "build.gradle.kts",
    }),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = get_workspace_config(),
    init_options = {
      bundles = bundles,
    },
    on_attach = function(client, bufnr)
      -- Java-specific keymaps
      local keymap = vim.keymap.set
      local opts = { buffer = bufnr, silent = true }

      -- Auto-imports and organize
      keymap("n", "<leader>jo", function() jdtls.organize_imports() end,
        vim.tbl_extend("force", opts, { desc = "Java: Organize imports" }))
      keymap("n", "<leader>jv", function() jdtls.extract_variable() end,
        vim.tbl_extend("force", opts, { desc = "Java: Extract variable" }))
      keymap("n", "<leader>jm", function() jdtls.extract_method(true) end,
        vim.tbl_extend("force", opts, { desc = "Java: Extract method" }))
      keymap("n", "<leader>jf", function() jdtls.extract_field() end,
        vim.tbl_extend("force", opts, { desc = "Java: Extract field" }))
      keymap("n", "<leader>jn", function() jdtls.extract_constant() end,
        vim.tbl_extend("force", opts, { desc = "Java: Extract constant" }))

      -- Project/build
      keymap("n", "<leader>jR", function() jdtls.update_project_config() end,
        vim.tbl_extend("force", opts, { desc = "Java: Reload project config" }))
      keymap("n", "<leader>jO", function() jdtls.open_jdt_uri() end,
        vim.tbl_extend("force", opts, { desc = "Java: Open JDT URI" }))

      -- DAP keymaps (only if debug adapter is available)
      keymap("n", "<leader>dj", function() jdtls.dap_configurations() end,
        vim.tbl_extend("force", opts, { desc = "Java: Debug configurations" }))
      keymap("n", "<leader>dJ", function() jdtls.dap_main_class_config() end,
        vim.tbl_extend("force", opts, { desc = "Java: Debug main class" }))

      -- Code action shortcuts (in addition to generic <leader>ca)
      keymap("n", "<leader>ci", function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } } })
      end, vim.tbl_extend("force", opts, { desc = "Java: Organize imports (code action)" }))
      keymap("n", "<leader>cu", function()
        vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } } })
      end, vim.tbl_extend("force", opts, { desc = "Java: Fix all problems" }))

      -- Setup DAP for Java
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end,
  }

  jdtls.start_or_attach(config)
end

-- Auto-start jdtls when opening a Java file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    setup_jdtls()
  end,
  group = vim.api.nvim_create_augroup("JdtlsStart", { clear = true }),
})

return {}
