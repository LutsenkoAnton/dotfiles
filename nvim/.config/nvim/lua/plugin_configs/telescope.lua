local builtin = require('telescope.builtin')
local wk = require("which-key")
wk.register({
    f = {
        name = "Find",
        f = { builtin.find_files, "Find files in current directory" },
        r = { builtin.oldfiles, "Find files in history" },
        g = { builtin.live_grep, "Live grep" },
        b = { builtin.buffers, "Find in open buffers" },
        h = { builtin.help_tags, "Find in help" },
    }
}, { prefix = '<leader>' });
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fr', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
