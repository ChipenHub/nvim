vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "q", ":q<CR>", opts)
keymap("n", "Q", ":wq<CR>", opts)


