vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>s", function() vim.cmd(":TermExec direction=float cmd='cf submit'") end)
vim.keymap.set("n", "<leader>t", function() vim.cmd(":TermExec direction=float cmd='cf test'") end)
vim.keymap.set("n", "<leader>yf", [[mzgg"+yG`z]])
vim.keymap.set("n", "<leader>yy", [["+yy]])
vim.keymap.set("n", "<leader>v", [["+p"]])
vim.keymap.set("n", "<leader>y", [["+]])

