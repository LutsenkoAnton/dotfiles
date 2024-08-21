vim.api.nvim_set_hl(0, "CursorLine", {default=true, blend=50})
vim.cmd.colorscheme("tokyonight-night")
vim.g.neovide_scale_factor=0.5
if vim.g.neovide then
    -- Enable Transparency for Neovide
    -- Helper function for transparency formatting
    vim.g.neovide_transparency = 0.8
    vim.o.winblend = 70
    vim.o.pumblend = 70
end
