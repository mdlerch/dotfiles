filetype plugin on
syntax on
filetype indent on
" Make grep always show file name even if searching a 
" single file
set grepprg=grep\ -nH\ $*
" Set .tex files to tex not plaintex
let g:tex_flavor='latex'
set iskeyword+=:
set sw=2
set expandtab

" buffer menu
:nnoremap <F4> :buffers!<CR>:buffer<space>

" make pdfs
let g:Tex_DefaultTargetFormat='pdf'


au BufNewFile,BufRead *.gp set filetype=gnuplot
set ofu=syntaxcomplete#Complete
if has("autocmd")
  filetype plugin indent on
endif
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
set ignorecase
set mouse=nvi
set spell

" STUFF for vim-r-plugin
au BufNewFile,BufRead *.R set filetype=r
au BufNewFile,BufRead *.R set expandtab
au BufNewFile,BufRead *.R set shiftwidth=2
au BufNewFile,BufRead *.R set softtabstop=2
au BufNewFile,BufRead *.r set filetype=r
au BufNewFile,BufRead *.r set expandtab
au BufNewFile,BufRead *.r set shiftwidth=2
au BufNewFile,BufRead *.r set softtabstop=2
au BufNewFile,BufRead *.Rnw set expandtab
au BufNewFile,BufRead *.Rnw set shiftwidth=2
au BufNewFile,BufRead *.Rnw set softtabstop=2
au BufNewFile,BufRead *.Rnw set textwidth=100
au BufNewFile,BufRead *.tex set textwidth=120
au BufNewFile,BufRead *.jags.txt set ft=r
au BufNewFile,BufRead *.bugs.txt set ft=r

let maplocalleader="\\\\"

"let vimrplugin_term = "urxvt"
let vimrplugin_term = "gnome-terminal"
let vimrplugin_term_cmd = "gnome-terminal --hide-menubar -e"
let vimrplugin_routmorecolors = 1
let vimrplugin_underscore = 0
let vimrplugin_rnowebchunk = 0
let vimrplugin_nosingler = 1
let vimrplugin_r_args = "--no-save --no-restore-data"

colorscheme koehler

au BufNewFile,BufRead *.muttrc setl ft=muttrc

filetype indent plugin on
filetype indent on

map ;o :Sex <CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-l> <C-W>l
map <C-h> <C-W>h
map ;] :tabnext<CR>
map ;[ :tabprev<CR>
map <C-t> :tabe +"browse ."<CR>
map <C-O> :NERDTreeToggle ~/curr/trunk/<CR>
