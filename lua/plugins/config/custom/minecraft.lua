-- Minecraft Fabric modding support
-- Provides keymaps to browse decompiled Minecraft source (Yarn mappings)
-- Source location: ~/minecraft-src (extracted via Fabric Loom genSources)

local keymap = vim.keymap.set
local mc_src = vim.fn.expand("~/minecraft-src")

keymap("n", "<leader>`f", function()
  require("telescope.builtin").find_files({ cwd = mc_src, prompt_title = "Minecraft Source" })
end, { desc = "Find Minecraft source file" })

keymap("n", "<leader>`g", function()
  require("telescope.builtin").live_grep({ cwd = mc_src, prompt_title = "Grep Minecraft Source" })
end, { desc = "Grep Minecraft source" })

keymap("n", "<leader>`o", function()
  require("telescope.builtin").live_grep({
    cwd = mc_src,
    prompt_title = "Minecraft: Find Block/Item/Entity",
    default_text = "class ",
    glob_pattern = "*.java",
  })
end, { desc = "Minecraft class search" })

-- "~/minecraft-src/" set up command: mkdir -p /home/yfby/minecraft-src && cd /home/yfby/minecraft-src && unzip -o "/home/yfby/minecraft-modding/fabric-example-mod/.gradle/loom-cache/minecraftMaven/net/minecraft/minecraft-common-043a8b3edf/26.1.2/minecraft-common-043a8b3edf-26.1.2-sources.jar" 2>&1 | tail -5
