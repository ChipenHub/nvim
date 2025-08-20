return {
    "akinsho/bufferline.nvim",
    opts = {},
    keys = {
        {"<leader>h", ":BufferLineCyclePrev<CR>", silent = true},
        {"<leader>l", ":BufferLineCycleNext<CR>", silent = true},
        {"<leader>p", ":BufferLinePickCR>", silent = true},
        {"<leader>d", ":bdelete<CR>", silent = true},
    }
}
