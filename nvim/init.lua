-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- History/backup files
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

-- Spacing options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search options
vim.opt.showmatch = true

-- Interface options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

function run_remedy()
    os.execute('remedybg.exe start-debugging')
end

-- Other
vim.g.c_syntax_for_h = 1
vim.g.mapleader = " "
vim.keymap.set("n", "<C-b>", vim.cmd.make, {})
vim.keymap.set("n", "<F5>", run_remedy, {})

function add_copyright_header(args)
    vim.fn.setline(1, "/*")
    vim.fn.setline(2, " * Copyright (C) " .. os.date("%Y") .. " Jordan West - all rights reserved.")
    vim.fn.setline(3, " */")
end

local copyright_group = vim.api.nvim_create_augroup("c_header", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
    group = copyright_group,
    pattern = { "*.c", "*.h" },
    callback = add_copyright_header,
    once = true,
})

-- Plugins
vim.cmd.packadd("packer.nvim")

require("packer").startup(function(use)
    -- Plugin manager
    use("wbthomason/packer.nvim")
    -- Colorscheme
    use({ "catppuccin/nvim", as = "catppuccin" })
    -- Telescope
    use("nvim-lua/plenary.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.1" })
    -- LSP
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
end)

-- Colorscheme
vim.cmd.colorscheme("catppuccin")

-- Treesitter
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})

-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ follow = true }) end, {})
vim.keymap.set("n", "<leader>fg", function() builtin.live_grep({ additional_args = { "--follow" } }) end, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})

-- LSP
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", builtin.lsp_document_symbols, opts)

    vim.diagnostic.disable()
end

local on_attach_rust = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", builtin.lsp_document_symbols, opts)
end

local on_attach_go = function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", builtin.lsp_document_symbols, opts)
end

local cmp = require("cmp")
local types = require("cmp.types")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
    },
    completion = {
        autocomplete = false,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-3),
        ["<C-f>"] = cmp.mapping.scroll_docs(3),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm(),
    },
})

cmp.setup.filetype("go", {
    completion = {
        autocomplete = {
            types.cmp.TriggerEvent.TextChanged,
        },
    },
})

vim.keymap.set("i", "<C-x><C-o>", cmp.complete, {})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

capabilities.textDocument.completion.completionItem.snippetSupport = false

lspconfig.clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
    on_attach = on_attach_rust,
    capabilities = capabilities,
})

lspconfig.gopls.setup({
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            staticcheck = true,
        },
    },
    on_attach = on_attach_go,
    capabilities = capabilities,
})
