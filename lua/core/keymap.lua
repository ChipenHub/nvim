vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "q", ":q<CR>", opts)
keymap("n", "Q", ":wq<CR>", opts)
keymap("n", "<F2>", ":wa<CR>", opts)
keymap("i", "<F2>", "<Esc>:wa<CR>", opts)
keymap("v", "<F2>", "<Esc>:wa<CR>", opts)
