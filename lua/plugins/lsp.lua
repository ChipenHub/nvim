return {
-- 1) LSP 基础：nvim-lspconfig
{
"neovim/nvim-lspconfig",
event = { "BufReadPre", "BufNewFile" },
dependencies = {
-- 可选：如果你想用 Mason 管理 LSP，可启用下面两个插件
{ "williamboman/mason.nvim", optional = true },
{ "williamboman/mason-lspconfig.nvim", optional = true },
-- 与补全相关（能力上报）
"hrsh7th/cmp-nvim-lsp",
},
config = function()
------------------------------------------------------------------
-- 诊断外观：更清楚的 sign（可按喜好修改）
------------------------------------------------------------------
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
local hl = "DiagnosticSign" .. type
vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.diagnostic.config({
severity_sort = true,
virtual_text = { spacing = 2, prefix = "●" },
float = { border = "rounded" },
})
vim.opt.signcolumn = "yes"


------------------------------------------------------------------
-- 公共 on_attach：只在 LSP 连接到当前 buffer 时生效的快捷键
------------------------------------------------------------------
local on_attach = function(_, bufnr)
local map = function(mode, lhs, rhs, desc)
vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. (desc or "") })
end
map("n", "gd", vim.lsp.buf.definition, "跳转定义")
map("n", "gD", vim.lsp.buf.declaration, "跳转声明")
map("n", "gi", vim.lsp.buf.implementation, "跳转实现")
map("n", "gr", vim.lsp.buf.references, "查找引用")
map("n", "K", vim.lsp.buf.hover, "悬浮文档")
map("n", "<leader>rn", vim.lsp.buf.rename, "重命名符号")
map("n", "<leader>ca", vim.lsp.buf.code_action, "代码操作")
map("n", "[d", vim.diagnostic.goto_prev, "上一个诊断")
map("n", "]d", vim.diagnostic.goto_next, "下一个诊断")
map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "格式化")
end
------------------------------------------------------------------
-- capabilities：让 LSP 知道我们支持补全等能力（配合 nvim-cmp）
------------------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
-- 如果你遇到 clangd offsetEncoding 相关报错，可临时打开下面一行
-- capabilities.offsetEncoding = { "utf-16" }


------------------------------------------------------------------
-- 选择是否使用 Mason 安装/管理 clangd
------------------------------------------------------------------
local use_mason = pcall(require, "mason") and pcall(require, "mason-lspconfig")
if use_mason then
require("mason").setup()
require("mason-lspconfig").setup({
-- 如果你更想使用系统自带的 clangd，请留空；
-- 若想让 Mason 帮你装/管：改成 ensure_installed = { "clangd" }
ensure_installed = {},
automatic_installation = false,
})
end


------------------------------------------------------------------
-- 真正的 clangd 配置
------------------------------------------------------------------
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({
on_attach = on_attach,
capabilities = capabilities,
-- 使用系统中的 clangd，可在这里指定路径或参数
cmd = {
"clangd",
"--background-index",
"--clang-tidy", -- 启用 clang-tidy 诊断（需项目有相应配置）
"--completion-style=detailed",
"--header-insertion=iwyu" -- 包含头文件建议策略：iwyu/never
},
init_options = {
clangdFileStatus = true,
usePlaceholders = true,
},
})
end,
},
-- 2) 自动补全：nvim-cmp（最小可用）
{
"hrsh7th/nvim-cmp",
event = "InsertEnter",
dependencies = {
"L3MON4D3/LuaSnip",
"saadparwaiz1/cmp_luasnip",
"hrsh7th/cmp-nvim-lsp",
"hrsh7th/cmp-buffer",
"hrsh7th/cmp-path",
"rafamadriz/friendly-snippets",
},
config = function()
local cmp = require("cmp")
local luasnip = require("luasnip")
-- 预载常用代码片段
require("luasnip.loaders.from_vscode").lazy_load()


cmp.setup({
snippet = {
expand = function(args) luasnip.lsp_expand(args.body) end,
},
mapping = cmp.mapping.preset.insert({
["<CR>"] = cmp.mapping.confirm({ select = true }),
["<C-Space>"] = cmp.mapping.complete(),
["<Tab>"] = cmp.mapping(function(fallback)
if cmp.visible() then
cmp.select_next_item()
elseif luasnip.expand_or_jumpable() then
luasnip.expand_or_jump()
else
fallback()
end
end, { "i", "s" }),
["<S-Tab>"] = cmp.mapping(function(fallback)
if cmp.visible() then
cmp.select_prev_item()
elseif luasnip.jumpable(-1) then
luasnip.jump(-1)
else
fallback()
end
end, { "i", "s" }),
}),
sources = {
{ name = "nvim_lsp" },
{ name = "path" },
{ name = "buffer" },
{ name = "luasnip" },
},
window = {
completion = cmp.config.window.bordered(),
documentation = cmp.config.window.bordered(),
},
})
end,
},
}
