call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'andreshazard/vim-freemarker'
Plug 'bling/vim-bufferline'
Plug 'lervag/vimtex'
Plug 'ycm-core/YouCompleteMe'
Plug 'tibabit/vim-templates'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

syntax on
colorscheme codedark
set laststatus=2
set guifont="MesloLGS NF":h16

filetype on
filetype plugin on
filetype indent on

set number
set relativenumber
set cursorline
set nocompatible

set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start

set splitbelow
set splitright

set foldmethod=syntax
set nofoldenable

set nrformats=bin,octal,hex,alpha

let mapleader = " "

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:bufferline_echo=0
let g:airline_powerline_fonts=1

"let g:ale_cpp_cc_executable="g++-12"
"let g:ale_cpp_cc_options="-std=c++20 -Wall"
"let g:ale_linters_ignore={'cpp': ['clangd']}

let g:tmpl_search_paths = ["~/.templates/"]

let g:NERDSpaceDelims = 1

nnoremap <leader>l :set list!<CR>
nnoremap <leader>m :vert botright term<CR>
nnoremap <leader>s :!cf submit<CR>
nnoremap <leader>t :!cf test <CR>
nnoremap <leader>yf :silent w !pbcopy<CR>
nnoremap <leader>yy :silent .w !pbcopy<CR>
nnoremap <leader>v :r !pbpaste<CR>
nnoremap <leader>y "+
nnoremap <leader>f :YcmCompleter Format<CR>
nnoremap <leader>x :YcmCompleter FixIt<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

let g:vimtex_view_method = 'skim'
