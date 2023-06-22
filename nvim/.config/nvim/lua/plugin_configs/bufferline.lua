local icons = require("core.icons")
require('bufferline').setup({
    options = {
        numbers = "buffer_id",
        diagnostics = "nvim_lsp",
        diagnostics_indicator=function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
                local sym = e == "error" and (icons["Error"] .. " ")
                    or (e == "warning" and (icons["Warn"] .. " ") or icons["Hint"])
                s = s .. n .. sym
            end
            return s
        end,
    }
})
