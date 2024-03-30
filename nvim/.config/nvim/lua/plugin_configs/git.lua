require('gitsigns').setup {
    signs                        = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        follow_files = true
    },
    auto_attach                  = true,
    attach_to_untracked          = false,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },
    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local wk = require('which-key');

        -- Navigation
        wk.register({
            [']c'] = {
                function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end,
                "Go to next hunk"
            },
            ['[c'] = {
                function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, "Go to previous hunk"
            },
        }, { expr = true, buffer = bufnr });

        -- Actions
        wk.register({
            g = {
                name = "Git actions",
                s = { gs.stage_hunk, "Stage hunk" },
                r = { gs.reset_hunk, "Reset hunk" },
                S = { gs.stage_buffer, "Stage buffer" },
                R = { gs.reset_buffer, "Reset buffer" },
                u = { gs.undo_stage_hunk, "Undo stage hunk" },
                p = { gs.preview_hunk, "Preview hunk" },
                b = { function() gs.blame_line { full = true } end, "Blame line" },
                d = { gs.diffthis, "Git diff against index" },
                D = { function() gs.diffthis('~') end, "Git diff against last commit" },
            },
            t = {
                name = "Toggle",
                b = { gs.toggle_current_line_blame, "Toggle line blame" },
                d = { gs.toggle_deleted, "Toggle view of deleted lines" },
            }
        }, { prefix = "<leader>", buffer = bufnr });

        wk.register({
            g = {
                name = "Git actions",
                s = { function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage selected hunk" },
                r = { function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                    "Reset selected hunk" },
            }
        }, { mode = 'v', prefix = '<leader>', buffer = bufnr });

        -- Text object
        vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr });
    end
}

local wk = require('which-key')
wk.register({
    g = {
        name = "Git actions",
        c = { ":Git commit<CR>", "Git commit" },
    }
}, {prefix='<leader>'});
