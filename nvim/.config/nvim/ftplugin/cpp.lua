function RunCppFile()
    local full_filename = vim.api.nvim_buf_get_name(0)
    local dir = vim.fs.dirname(full_filename)
    vim.cmd.write()
    vim.cmd("TermExec direction=float  dir=" .. dir .. " cmd='clear && g++-12 -fsanitize=undefined -g -Wall -std=c++20 " .. full_filename .. " ; echo \\\"\\\\e[32mBuild completed\\\\e[0m\\\" && ./a.out ; rm -rf ./a.out*'")
    -- vim.cmd("silent !clear")
    -- vim.cmd("silent !g++-12 -fsanitize=undefined -g -Wall -std=c++20 -o " .. dir .. "/a.out " .. full_filename)
    -- vim.cmd("silent !echo \"\\e[32mBuild completed\\e[0m\"")
    -- vim.cmd("!" .. dir .. "/a.out")
    -- vim.cmd("silent !rm -rf " .. dir .. "/a.out*")
end

vim.keymap.set("n", "<leader>r", RunCppFile)
