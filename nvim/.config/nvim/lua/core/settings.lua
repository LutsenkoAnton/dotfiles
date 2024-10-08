-- Colorscheme settings
require("core.colors")

-- Editor settings
vim.o.number = true
vim.o.relativenumber = true
-- vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.updatetime = 50

-- Indenting settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Split settings
vim.o.splitbelow = true
vim.o.splitright = true

-- Search settings
vim.o.hlsearch = false
vim.o.incsearch = true

-- Undo settings
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Neovide settings
vim.o.guifont = "Fira Code:h16"
-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1

-- Disable perl provider
vim.g.loaded_perl_provider = 0
-- vim.api.nvim_set_keymap('', '<C-V>', '+p<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('!', '<C-V>', '<C-R>+', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('t', '<C-V>', '<C-R>+', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<C-V>', '<C-R>+', { noremap = true, silent = true })
