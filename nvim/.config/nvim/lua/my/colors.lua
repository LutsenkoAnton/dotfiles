require("tokyonight").setup({
    style = "night",
    terminal_colors = true,
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = { "qf", "help", "terminal" },
    hide_inactive_statusline = false,
    dim_inactive = false,
})
vim.cmd.colorscheme("tokyonight-night")
vim.o.termguicolors = true
