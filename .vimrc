set nocompatible              " be iMproved, required
filetype off                  " required

execute pathogen#infect()

syntax on
filetype plugin indent on
"set background=dark
colorscheme gruvbox

set tabstop=4
set shiftwidth=4
set expandtab
set number

set wildmode=longest,list,full
set wildmenu

let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nmap <Leader><Leader> V
nnoremap <leader>K :<C-u>Unite ref/erlang -vertical -default-action=split<CR>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
