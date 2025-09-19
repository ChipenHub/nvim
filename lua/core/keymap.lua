vim.g.mapleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 基本操作
keymap("n", "q", ":q<CR>", opts)
keymap("n", "Q", ":wq<CR>", opts)
keymap("n", "U", "<C-r>", opts)
keymap({ "n", "i", "v" }, "<C-s>", "<Esc>:wa<CR>", opts)

-- CMake / make
keymap({ "n", "i", "v" }, "<F5>", function()
  vim.cmd("!rm -rf build && mkdir build && cd build && cmake ..")
end, { noremap = true, silent = true, desc = "CMake build" })
keymap({ "n", "i", "v" }, "<F6>", function()
  vim.cmd("make -C ./build")
end, { noremap = true, silent = true, desc = "make build" })

-- Leader 和 Space 键
keymap("n", "<Space>", "<Nop>", opts)
keymap("v", "<Space>", "<Nop>", opts)
keymap("n", "<leader>o", "o<Esc>", opts)
keymap("n", "<leader>O", "O<Esc>", opts)

-- 删除到黑洞寄存器，不污染剪切板
keymap({ 'n', 'v' }, 'd', '"_d', opts)
keymap('n', 'dd', '"_dd', opts)
keymap({ 'n', 'v' }, 'D', '"_D', opts)
keymap({ 'n', 'v' }, 'x', '"_x', opts)
keymap({ 'n', 'v' }, 'X', '"_X', opts)
-- 改变操作（change）也不要进寄存器
keymap({ 'n', 'v' }, 'c', '"_c', opts)
keymap({ 'n', 'v' }, 'cc', '"_cc', opts)
keymap({ 'n', 'v' }, 'C', '"_C', opts)
-- substitutekeymap
keymap({ 'n', 'v' }, 's', '"_s', opts)
keymap({ 'n', 'v' }, 'S', '"_S', opts)

-- 进系统剪贴板
keymap({ 'n', 'v' }, '<leader>y', '"+y', opts)
keymap({ 'n', 'v' }, '<leader>d', '"+d', opts)

-- Visual 模式粘贴不污染临时寄存器
keymap('v', 'p', function()
  local reg = vim.fn.getreg('"')
  local regtype = vim.fn.getregtype('"')
  vim.cmd('normal! p')
  vim.fn.setreg('"', reg, regtype)
end, opts)

-- 插入模式快速粘贴系统剪贴板
keymap('i', '<C-k>', '<C-r>"', opts)

-- 删除行尾空格
keymap('n', '<leader>ts', [[:%s/\s\+$//<CR>]], opts)
