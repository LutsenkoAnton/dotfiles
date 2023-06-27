require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
})

-- Setup keybindings
local on_attach = function(_, _)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end)
    vim.keymap.set({ "v", "n" }, "<leader>ca", function() vim.lsp.buf.code_action { apply = true } end)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    vim.keymap.set('n', "<leader>D", vim.lsp.buf.type_definition)
    vim.keymap.set('n', "<leader>rn", vim.lsp.buf.rename)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
end

-- Setup language servers
require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup { on_attach = on_attach }
    end,
    ["lua_ls"] = function()
        require('lspconfig').lua_ls.setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }
    end
}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- Load LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()

-- Load custom icons
local icons = require('core.icons')

-- Setup icons on the edge of the screen
vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = icons["Error"], numhl = "" })
vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = icons["Warn"], numhl = "" })
vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = icons["Hint"], numhl = "" })
vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = icons["Info"], numhl = "" })


-- Enables description of error in the same line
vim.diagnostic.config({
    severity_sort = true,
    float = { border = 'rounded' },
    virtual_text = { prefix = "●" }
})

-- Creates round border around hover screen
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = 'rounded',
    }
)

local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Completion for DAP
require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
        { name = "dap" },
    },
})

-- Setup completion
cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'calc' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
    end

})

--------------------------- DAP ---------------------------

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

require("mason-nvim-dap").setup({
    ensure_installed = { 'codelldb' },
    -- ensure_installed = { 'cppdbg' },
    handlers = {
        function(config)
            -- all sources with no handler get passed here

            -- Keep original functionality
            require('mason-nvim-dap').default_setup(config)
        end,
        codelldb = function(config)
            for i, _ in pairs(config.configurations) do
                config.configurations[i].program = function()
                    print(vim.api.nvim_buf_get_name(0))
                    local choice = vim.fn.input(
                    "Compile the file / Run compiled executable / Another executable? [c]/r/a: ")
                    if choice == "a" then
                        return coroutine.create(function(coro)
                            local opts = {}
                            pickers.new(opts, {
                                prompt_title = "Path to executable",
                                finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                                sorter = conf.generic_sorter(opts),
                                attach_mappings = function(buffer_number)
                                    actions.select_default:replace(function()
                                        actions.close(buffer_number)
                                        coroutine.resume(coro, action_state.get_selected_entry()[1])
                                    end)
                                    return true
                                end,
                            }):find()
                        end)
                    elseif choice == 'r' then
                        return vim.fn.expand("%:p:r")
                    else
                        vim.notify(vim.fn.expand("%:p:r"))
                        os.execute("clang++ -g -std=c++20 -o " .. vim.fn.expand("%:p:r") .. " " .. vim.fn.expand("%:p"))
                        return vim.fn.expand("%:p:r")
                    end
                end
                -- For some reason codelldb has some troubles with case sensitivity
                -- If you have your breakpoints missed, try uncommenting these lines
                -- config.configurations[i].sourceMap = {
                -- [os.getenv("HOME") .. "/documents"] = (os.getenv("HOME") .. "/Documents"),
                -- }
            end
            require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,
        -- cppdbg = function(config)
        --     for i, _ in pairs(config.configurations) do
        --         config.configurations[i].setupCommands = {
        --             {
        --                 text = '-enable-pretty-printing',
        --                 description = 'enable pretty printing',
        --                 ignoreFailures = false
        --             },
        --             {
        --                 text = '-gdb-set disassembly-flavor intel',
        --                 ignoreFailures = true
        --             },
        --         }
        --     end
        --     require('mason-nvim-dap').default_setup(config) -- don't forget this!
        -- end,
    },
})
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

-- DAP inline text
require("nvim-dap-virtual-text").setup {
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
    all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
    clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
    --- A callback that determines how a variable is displayed or whether it should be omitted
    --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
    --- @param buf number
    --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
    --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
    --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
    --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
    display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
        else
            return variable.name .. ' = ' .. variable.value
        end
    end,
    -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
    virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

    -- experimental features:
    all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

-- DAP icons
vim.fn.sign_define("DapBreakpoint", { text = '●', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define("DapBreakpointCondition", { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define("DapLogPoint", { text = '', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define("DapStopped", { text = '→', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define("DapBreakpointRejected", { text = '', texthl = '', linehl = '', numhl = 'DiagnosticSignError' })

-- DAP mappings
vim.keymap.set('n', '<Leader>dc', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>do', function() require('dap').step_over() end)
vim.keymap.set('n', '<Leader>di', function() require('dap').step_into() end)
vim.keymap.set('n', '<Leader>du', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>bl',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>bc',
    function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '), nil, nil) end)
vim.keymap.set('n', '<leader>bcl',
    function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '), nil,
            vim.fn.input("Log point message: "))
    end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
