vim.g.mapleader = " "

-- Visual mode movement
vim.keymap.set("v", "J", ":m '>+1<yCR>gv=gv", { desc = "Move text one line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text one line up" })
-- Text center mappings
vim.keymap.set("n", "n", "nzzzv") -- Center text on n
vim.keymap.set("n", "N", "Nzzzv") -- Center text on N
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Replace selected" })
-- -- Codeforces mappings
-- vim.keymap.set("n", "<leader>s", function() vim.cmd(":TermExec direction=float cmd='cf submit'") end)
-- vim.keymap.set("n", "<leader>t", function() vim.cmd(":TermExec direction=float cmd='cf test'") end)
-- Clipboard mappings
vim.keymap.set("n", "<leader>y", [["+]], { desc = "Select clipboard register" })
vim.keymap.set("n", "<leader>yf", [[mzgg"+yG`z]], { desc = "Yank file" })
vim.keymap.set("n", "<leader>yy", [["+yy]], { desc = "Yank line" })
vim.keymap.set("n", "<leader>v", [["+p]], { desc = "Paste from clipbard" })
vim.keymap.set("v", "<leader>y", [["+y]], { desc = "Yank selected block" })
-- -- Luasnip mappings
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set("i", "<c-j>", function() require 'luasnip'.jump(1) end, opts)
-- vim.keymap.set("s", "<c-j>", function() require 'luasnip'.jump(1) end, opts)
-- vim.keymap.set("i", "<c-k>", function() require 'luasnip'.jump(-1) end, opts)
-- vim.keymap.set("s", "<c-k>", function() require 'luasnip'.jump(-1) end, opts)
