vim.wo.spell = true
vim.bo.spelllang = "ru_ru,en_us"
vim.keymap.set('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u')
vim.g.tex_flavor='latex'
vim.g.vimtex_quickfix_mode = 0
vim.o.conceallevel = 2
vim.g.tex_conceal='abdmg'

require('cmp').setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                buffer = "[Buffer]",
                -- formatting for other sources
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'omni' },
        { name = 'buffer' },
        { name = 'luasnip', keyword_length = 2 },
        -- other sources
    },
}
