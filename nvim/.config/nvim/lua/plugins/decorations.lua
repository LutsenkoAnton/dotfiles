return {
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    {
        'akinsho/bufferline.nvim',
        version = "v3.*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = true
    },
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
