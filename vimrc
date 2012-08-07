call pathogen#infect()
Helptags
" don't forget about gg=G
" I don't know what this does
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set nocompatible
syntax enable
filetype plugin on
filetype indent on

set iskeyword+=:
set ts=4 sts=4 sw=4 noexpandtab

au BufNewFile,BufRead *.jags.txt set ft=r
au BufNewFile,BufRead *.bugs.txt set ft=r

set statusline=%f%m\ 
set statusline+=[Line\ %l\ of\ %L]
set statusline+=\ [Col\ %c]
set laststatus=2

let g:tex_flavor = "latex"

set nu

" paste on newline
nnoremap P :pu<CR>

set list
nmap <leader>l :set list!<CR>
set listchars=eol:¬,tab:▸\ 

set lazyredraw

vmap rt = :retab!<cr>

nnoremap <c-j> /<++><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<++><cr>c/+>/e<cr>

"re-format (wrapping)
nmap fr gq
nmap frh gw
vmap fr gq

"latex stuff
map <leader>lp <ESC>:w<ESC>:!texi2pdf % <CR>
map <leader>ld <ESC>:w<ESC>:!texi2dvi % <CR>
map <leader>lb <ESC>:w<ESC>:!bibtex %:r <CR>


" buffer menu
:nnoremap <F4> :buffers!<CR>:buffer<space>

:nnoremap <F2> :NERDTreeToggle<CR>

" set working directory
:cabbr setwd :cd %:p:h<CR>:pwd<CR>

set scrolloff=6

:cabbr mytemp !echo -e mytemp: & ls ~/.vim/templates/ 
:cabbr mytemphw 0r ~/.vim/templates/hw.tex
:cabbr mytemphwknitr 0r ~/.vim/templates/hwknitr.tex
:cabbr mytemphwreport 0r ~/.vim/templates/hwreport.tex
:cabbr mytemphwsweave 0r ~/.vim/templates/hwsweave.tex


set ignorecase
set mouse=nvi
set spell



au BufNewFile,BufRead *.txt set textwidth=80
colorscheme zenburn
highlight Comment cterm=italic

vnoremap . :normal . <CR>


" jumplist
map <C-k> <C-i>
map <C-l> <C-o>
