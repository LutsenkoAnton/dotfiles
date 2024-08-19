local icons = require('core.icons')

return {
    {
        'akinsho/bufferline.nvim',
        event = 'VeryLazy',
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { '<leader>bn', function() require('bufferline').cycle(1) end, desc = "Go to next buffer"},
            { '<leader>bp', function() require('bufferline').cycle(-1) end, desc = "Go to previous buffer"},
            { '<leader>br', function() require('bufferline').move(1) end, desc = "Move buffer to right"},
            { '<leader>bl', function() require('bufferline').move(-1) end, desc = "Move buffer to left"},
            { '<leader>bs', function() require('bufferline').move_to(1) end, desc = "Move buffer to start" },
            { '<leader>be', function() require('bufferline').move_to(-1) end, desc = "Move buffer to end" },
            { '<leader>bco', function() require('bufferline').close_others() end, desc = "Close others" },
            { '<leader>bcl', function() require('bufferline').close_in_direction('left') end, desc = "Close all to the left" },
            { '<leader>bcr', function() require('bufferline').close_in_direction('right') end, desc = "Close all to the right" },
            { '<leader>bcc', function() vim.cmd('bdelete') end, desc = "Close current buffer" },
            { '<leader>bq', function() vim.cmd('bdelete') end, desc = "Close current buffer" },
        },
        opts = {
            options = {
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(_, _, diagnostics_dict, _)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and (icons["Error"] .. " ")
                            or (e == "warning" and (icons["Warn"] .. " ") or icons["Hint"])
                        s = s .. n .. sym
                    end
                    return s
                end,
            }
        }
    }
}
