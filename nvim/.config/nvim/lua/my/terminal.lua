vim.api.nvim_create_autocmd({"TermOpen"}, {pattern = {"*"}, command = "startinsert"})
vim.api.nvim_create_autocmd({"TermOpen"}, {pattern = {"*"}, callback = function() vim.opt_local.number = false; vim.opt_local.relativenumber = false end})
vim.api.nvim_create_autocmd({"TermEnter"}, {pattern = {"*"}, callback = function() vim.opt_local.signcolumn = "no" end})
