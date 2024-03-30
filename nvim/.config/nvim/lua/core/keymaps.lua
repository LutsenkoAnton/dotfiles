vim.g.mapleader = " "

local wk = require("which-key")

wk.register({
    J = { ":m '>+1<yCR>gv=gv", "Move text one line down" },
    K = { ":m '<-2<CR>gv=gv",  "Move text one line up" }
}, { mode = "v" });
-- vim.keymap.set("v", "J", ":m '>+1<yCR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

wk.register({
    n = { "nzzzv", "Center text on n" },
    N = { "Nzzzv", "Center text on N" },
})

-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

wk.register({
    ["<leader>p"] = { [["_dP]] },
}, { mode = "x" });
-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- vim.keymap.set("n", "<leader>s", function() vim.cmd(":TermExec direction=float cmd='cf submit'") end)
-- vim.keymap.set("n", "<leader>t", function() vim.cmd(":TermExec direction=float cmd='cf test'") end)

vim.keymap.set("n", "<leader>y", [["+]])
wk.register({
    y = {
        name = "Yank to clipboard",
        f = { [[mzgg"+yG`z]], "Yank file" },
        y = { [["+yy]], "Yank line" },
    },
    v = { [["+p]], "Paste from clipboard" }
}, { prefix = "<leader>" });
-- vim.keymap.set("n", "<leader>yf", [[mzgg"+yG`z]])
-- vim.keymap.set("n", "<leader>yy", [["+yy]])
-- vim.keymap.set("n", "<leader>v", [["+p]])
-- vim.keymap.set("n", "<leader>y", [["+]])

wk.register({
    ["<leader>y"] = { [["+y]], "Yank selected block" },
}, { mode = "v" });
-- vim.keymap.set("v", "<leader>y", [["+y]])
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "<c-j>", function() require'luasnip'.jump(1) end, opts)
vim.keymap.set("s", "<c-j>", function() require'luasnip'.jump(1) end, opts)
vim.keymap.set("i", "<c-k>", function() require'luasnip'.jump(-1) end, opts)
vim.keymap.set("s", "<c-k>", function() require'luasnip'.jump(-1) end, opts)

