return {
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        'numToStr/Comment.nvim',
        event = { "BufNewFile", "BufReadPost" },
        opts = {}
    },
    {
        'rcarriga/nvim-notify',
        init = function()
            vim.o.termguicolors = true
        end,
        opts = {
            background_colour = "#000000"
        },
        config = function(_, opts)
            require('notify').setup(opts)
            vim.notify = require('notify')
        end
    },
    {
        'mbbill/undotree',
        event = 'VeryLazy',
    },
    {
        'shirk/vim-gas',
        -- 'henry-hsieh/riscv-asm-vim',
        ft = 'asm',
    },
    {
        'lambdalisue/suda.vim',
        cmd = { 'SudaWrite', 'SudaRead' },
    },
}
