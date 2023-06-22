vim.o.termguicolors = true
require("notify").setup({
    background_colour = "#000000",
})
require("tokyonight").setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent",
        floats = "transparent",
    },
    sidebars = { "qf", "help", "terminal" },
    hide_inactive_statusline = false,
    dim_inactive = false,
})
vim.cmd.colorscheme("tokyonight-night")
vim.notify = require("notify")
