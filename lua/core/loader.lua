--- Safe module loader to prevent startup failures
-- Wraps require() in pcall so a broken module doesn't prevent Neovim from starting.
-- Returns nil on error and shows a user-facing notification with the error details.
--
-- Used by plugins/init.lua to load plugin configs in two tiers:
--   1. Critical configs (theme, lualine, etc.) — loaded immediately
--   2. Deferred configs (LSP, CMP, etc.) — loaded after VimEnter
--
-- If any config fails to load, the error is logged to notifications and
-- the remaining configs still load. This is important because a single
-- broken plugin config shouldn't prevent you from opening Neovim.
local M = {}

function M.safe_require(module_name)
  local ok, result = pcall(require, module_name)
  if not ok then
    vim.notify(
      string.format("Failed to load module '%s':\n%s", module_name, tostring(result)),
      vim.log.levels.ERROR,
      { title = "Config Loader Error" }
    )
    return nil
  end
  return result
end

return M
