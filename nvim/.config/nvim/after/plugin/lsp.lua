-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Adding keybindings
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }

    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
    vim.keymap.set("n", "<leader>x", vim.lsp.buf.code_action)
end)

lsp.set_server_config({offsetEncoding = {"utf-8"}})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

vim.diagnostic.config({virtual_text = true})
