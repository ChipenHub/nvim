vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "q", ":q<CR>", opts)
keymap("n", "Q", ":wq<CR>", opts)
keymap("n", "U", "<C-r>", opts)

keymap({ "n", "i", "v" }, "<C-s>", "<Esc>:wa<CR>", opts)

keymap({ "n", "i", "v" }, "<F5>", function()
  vim.cmd("!rm -rf build && mkdir build && cd build && cmake ..")
end, { noremap = true, silent = true, desc = "CMake build" })

keymap({ "n", "i", "v" }, "<F6>", function()
  vim.cmd("make -C ./build")
end, { noremap = true, silent = true, desc = "make build" })

keymap("n", "<Space>", "<Nop>", opts)
keymap("v", "<Space>", "<Nop>", opts)

-- some keymap about <leader> (leader -> Space)
keymap("n", "<leader>o", "o<Esc>", opts)
keymap("n", "<leader>O", "O<Esc>", opts)

-- 删除到黑洞寄存器，不污染剪切板
keymap({ 'n', 'v' }, 'd', '"_d', opts)
keymap({ 'n', 'v' }, 'dd', '"_dd', opts)
keymap({ 'n', 'v' }, 'D', '"_D', opts)

keymap({ 'n', 'v' }, 'x', '"_x', opts)
keymap({ 'n', 'v' }, 'X', '"_X', opts)

-- 改变操作（change）也不要进寄存器
keymap({ 'n', 'v' }, 'c', '"_c', opts)
keymap({ 'n', 'v' }, 'cc', '"_cc', opts)
keymap({ 'n', 'v' }, 'C', '"_C', opts)

-- substitute
keymap({ 'n', 'v' }, 's', '"_s', opts)
keymap({ 'n', 'v' }, 'S', '"_S', opts)

-- 把 Y/D 改成剪切选区/整行到系统剪切板
keymap({ 'n', 'v' }, 'Y', '"+d', { desc = 'Cut to system clipboard' })
keymap({ 'n', 'v' }, 'D', '"+dd', { desc = 'Cut all line to system clipboard' })

-- fase paste
keymap("i", "<C-k>", "<Esc>pa", opts)
