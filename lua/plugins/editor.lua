-- lua/plugins/editor.lua
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",       -- 进入插入模式时加载
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,         -- 如果你装了 treesitter, 支持更智能匹配
        fast_wrap = {},          -- 快速环绕功能
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    main = "ibl",                -- 新版 indent-blankline.nvim 导出了 ibl
    config = function()
      require("ibl").setup({
        indent = { char = "│" }, -- 可以改成 "┊" "┆" "¦" 等
        scope = { enabled = true },
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",    -- noice.nvim 必需
      "rcarriga/nvim-notify",    -- 建议用 notify 来显示消息
    },
    config = function()
      require("noice").setup({
        lsp = {
          progress = { enabled = true },
          signature = { enabled = true },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
        },
      })
    end,
  },
}

