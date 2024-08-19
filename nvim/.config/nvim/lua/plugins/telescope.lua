return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-tree/nvim-web-devicons',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            }
        },
        keys = {
            { '<leader>ff', require('telescope.builtin').find_files, desc = "Find files" },
            { '<leader>fr', require('telescope.builtin').oldfiles,   desc = "Find recently used files" },
            { '<leader>fg', require('telescope.builtin').live_grep,  desc = "Live grep" },
            { '<leader>fb', require('telescope.builtin').buffers,    desc = "Find buffers" },
            { '<leader>fh', require('telescope.builtin').help_tags,  desc = "Find help" },
        },
        cmd = 'Telescope',
        opts = {
            defaults = {
                winblend = 70,
            },
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        -- even more opts
                    })
                },
                fzf = {

                }
            }

        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('ui-select')
            require('telescope').load_extension('fzf')
        end
    },
}
