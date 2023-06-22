vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<yCR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>s", function() vim.cmd(":TermExec direction=float cmd='cf submit'") end)
vim.keymap.set("n", "<leader>t", function() vim.cmd(":TermExec direction=float cmd='cf test'") end)
vim.keymap.set("n", "<leader>yf", [[mzgg"+yG`z]])
vim.keymap.set("n", "<leader>yy", [["+yy]])
vim.keymap.set("n", "<leader>v", [["+p]])
vim.keymap.set("n", "<leader>y", [["+]])
vim.keymap.set("v", "<leader>y", [["+y]])
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "<c-j>", function() require'luasnip'.jump(1) end, opts)
vim.keymap.set("s", "<c-j>", function() require'luasnip'.jump(1) end, opts)
vim.keymap.set("i", "<c-k>", function() require'luasnip'.jump(-1) end, opts)
vim.keymap.set("s", "<c-k>", function() require'luasnip'.jump(-1) end, opts)

