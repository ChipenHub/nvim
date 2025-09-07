-- plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup {
      size = 15,
      open_mapping = [[<C-u>]], -- F4 打开/关闭终端
      shade_terminals = true,
      direction = "float",     -- "float" = 悬浮终端, 还可以是 "horizontal"/"vertical"
      float_opts = {
        border = "curved",     -- 漂亮的圆角边框
      },
    }
  end
}

