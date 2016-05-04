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

autocmd BufRead,BufNewFile *.txt setlocal spell wrap linebreak nolist

let mapleader="\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nmap <Leader><Leader> V
nnoremap <leader>K :<C-u>Unite ref/erlang -vertical -default-action=split<CR>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"Haskell stuff
"ghc-mod
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
