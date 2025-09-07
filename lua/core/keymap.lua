vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "q", ":q<CR>", opts)
keymap("n", "Q", ":wq<CR>", opts)

keymap({ "n", "i", "v" }, "<C-s>", "<Esc>:wa<CR>", opts)

keymap({ "n", "i", "v" }, "<F5>", function()
  vim.cmd("!rm -rf build && mkdir build && cd build && cmake ..")
end, { noremap = true, silent = true, desc = "CMake build" })
