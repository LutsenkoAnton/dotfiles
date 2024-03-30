return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to defaults
            })
        end
    },
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'rcarriga/nvim-notify',
    'ryanoasis/vim-devicons',
    'mbbill/undotree',
    'lervag/vimtex',
    'hrsh7th/cmp-omni',
    'shirk/vim-gas',
    'lambdalisue/suda.vim',
    -- 'henry-hsieh/riscv-asm-vim',
}
