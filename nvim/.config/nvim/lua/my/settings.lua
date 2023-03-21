-- Colorscheme settings
require("my.colors")

-- Editor settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.updatetime = 50

-- Indenting settings
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

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
