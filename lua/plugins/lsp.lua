return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", optional = true },
      { "williamboman/mason-lspconfig.nvim", optional = true },
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- sign 配置
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

      -- on_attach
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. (desc or "") })
        end
        map("n", "gd", vim.lsp.buf.definition, "跳转定义")
        map("n", "gD", vim.lsp.buf.declaration, "跳转声明")
        map("n", "gi", vim.lsp.buf.implementation, "跳转实现")
        map("n", "gr", vim.lsp.buf.references, "查找引用")
        map("n", "K", vim.lsp.buf.hover, "悬浮文档")
        map("n", "[d", vim.diagnostic.goto_prev, "上一个诊断")
        map("n", "]d", vim.diagnostic.goto_next, "下一个诊断")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "格式化")

        map("n", "<leader>e", function() vim.diagnostic.open_float(nil, { focus = false }) end, "显示诊断信息")
        map("n", "<leader>q", vim.diagnostic.setqflist, "诊断 -> Quickfix")
        map("n", "<leader>dl", vim.diagnostic.setloclist, "诊断 -> LocList")
        map("n", "<leader>ds", vim.lsp.buf.document_symbol, "文档符号列表")
      end

      -- capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- mason
      local ok_mason, _ = pcall(require, "mason")
      local ok_mason_lsp, _ = pcall(require, "mason-lspconfig")
      if ok_mason and ok_mason_lsp then
        require("mason").setup()
        require("mason-lspconfig").setup({
          ensure_installed = {}, -- 或 { "clangd" }
          automatic_installation = false,
        })
      end

      -- clangd
      require("lspconfig").clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu"
        },
        init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
        },
      })
    end,
  },

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

