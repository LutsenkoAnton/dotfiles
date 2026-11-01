local function apply()
  local fg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).fg or "#ffffff"
  vim.api.nvim_set_hl(0, "@ghost.acsl", { fg = fg })
  vim.api.nvim_set_hl(0, "@variable.acsl", { fg = fg })
end

apply()                                                          -- after startup
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply }) -- after :colorscheme changes
