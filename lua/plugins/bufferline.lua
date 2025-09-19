return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
        { "<Tab>",  "<cmd>BufferLineCyclePrev<CR>", silent = true, noremap = true, desc = "Prev Buffer" },
        { "<leader><Tab>", "<cmd>BufferLineCycleNext<CR>", silent = true, noremap = true, desc = "Next Buffer" },
        { "gp",    "<cmd>BufferLinePick<CR>",      silent = true, noremap = true, desc = "Pick Buffer" },
        -- 关闭当前 buffer
        { "<C-\\>", "<cmd>bdelete<CR>",             silent = true, noremap = true, desc = "Close Buffer" },
    }
}

