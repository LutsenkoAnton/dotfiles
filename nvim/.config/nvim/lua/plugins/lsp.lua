return {
    'neovim/nvim-lspconfig',
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate"
    },
    'williamboman/mason-lspconfig.nvim',

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-calc',
    'rcarriga/cmp-dap',
    'saadparwaiz1/cmp_luasnip',
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    'rafamadriz/friendly-snippets',

}
