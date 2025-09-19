-- lua/plugins/oil.lua
return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {
      { "<C-p>", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
    },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        view_options = { show_hidden = true },
        columns = { "icon" },
        keymaps = {
          ["<C-p>"] = "actions.close", -- 在 oil buffer 里按 q 直接关闭
        },
      })
    end,
  },
}
