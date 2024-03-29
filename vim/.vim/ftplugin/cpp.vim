nnoremap <buffer>  <leader>r :call RunCppFile()<CR>

:function! RunCppFile()
:   write
:   silent !clear
:   silent execute ":!g++-12 -fsanitize=undefined -g -Wall -std=c++20 -o " . expand("%:p:h") . "/a.out " . expand("%:p")
:   silent !echo "\e[32mBuild completed\e[0m"
:   execute ":!" . expand("%:p:h") . "/a.out"
:   silent execute ":!rm -rf " . expand("%:p:h") . "/a.out*"
:endfunction   
