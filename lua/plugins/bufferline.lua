return {
    "akinsho/bufferline.nvim",
    opts = {},
    keys = {
        {"<F9>", ":BufferLineCyclePrev<CR>", silent = true},
        {"<F10>", ":BufferLineCycleNext<CR>", silent = true},
        {"<leader>p", ":BufferLinePick<CR>", silent = true},
        {"<C+w>", ":bdelete<CR>", silent = true},
    }
}
