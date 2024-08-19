local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
    {
        'hrsh7th/nvim-cmp',
        name = 'cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            -- 'hrsh7th/cmp-calc',
            'hrsh7th/cmp-omni',
            {
                'saadparwaiz1/cmp_luasnip',
                dependencies = {
                    {
                        "L3MON4D3/LuaSnip",
                        -- follow latest release.
                        -- install jsregexp (optional!).
                        build = "make install_jsregexp",
                        dependencies = { "rafamadriz/friendly-snippets" },
                        config = function()
                            require('luasnip.loaders.from_vscode').lazy_load()
                        end
                    },
                }
            },
        },
        opts = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            return {
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'buffer',  keyword_length = 3 },
                    { name = 'luasnip', keyword_length = 2 },
                },
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }
            }
        end,
    },
    -- 'hrsh7th/nvim-cmp'
}
