return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
        })

        -- F3 开关文件树
        vim.keymap.set("n", "<F3>", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true, desc = "Toggle File Tree" })
    end
}

