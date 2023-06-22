vim.api.nvim_set_hl(0, "CursorLine", {default=true, blend=50})
if vim.g.neovide then
    -- Enable Transparency for Neovide
    -- Helper function for transparency formatting
    local alpha = function()
        return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
    end
    -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 0.8
    -- vim.g.neovide_background_color = "#16161e" .. alpha()
    vim.g.neovide_background_color = "#000000" .. alpha()
end
