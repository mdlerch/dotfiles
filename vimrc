call pathogen#infect()
Helptags

set nocompatible
"set t_Co=256
syntax enable
filetype plugin on
syntax on
filetype indent on
" Make grep always show file name even if searching a 
" single file
set grepprg=grep\ -nH\ $*
" Set .tex files to tex not plaintex
let g:tex_flavor='latex'
set iskeyword+=:
set ts=2 sts=2 sw=2 noexpandtab

set statusline=%F%m%r%h%w\ 
set statusline+=[Line\ %l\ of\ %L]
set laststatus=2


set list
nmap <leader>l :set list!<CR>
set listchars=eol:¬,tab:▸\ 

"latex stuff
map <leader>lp :!texi2pdf % <CR>
map <leader>ld :!texi2dvi % <CR>

" buffer menu
:nnoremap <F4> :buffers!<CR>:buffer<space>

:nnoremap <F2> :NERDTreeToggle<CR>

" make pdfs
let g:Tex_DefaultTargetFormat='pdf'
let g:tex_comment_nospell=1


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
au BufNewFile,BufRead *.Rnw set textwidth=80
au BufNewFile,BufRead *.tex set textwidth=80
au BufNewFile,BufRead *.jags.txt set ft=r
au BufNewFile,BufRead *.bugs.txt set ft=r



au BufNewFile,BufRead *.txt set textwidth=80
let maplocalleader="\\\\"

"let vimrplugin_screenplugin = 0
"let vimrplugin_tmux = 0
let vimrplugin_term = "urxvt"
let vimrplugin_term_cmd = "urxvtc -sh 0 -e"
let vimrplugin_underscore = 0
let vimrplugin_rnowebchunk = 0
let vimrplugin_nosingler = 1
let vimrplugin_specialplot = 0
let vimrplugin_r_args = "--no-save --no-restore-data"
let vimrplugin_notmuxconf = 1
"let vimrplugin_term = "gnome-terminal"
"let vimrplugin_term_cmd = "gnome-terminal --hide-menubar -e"
"let vimrplugin_term_cmd = "urxvtc -e"
"let vimrplugin_routmorecolors = 1
"let vimrplugin_nosingler = 1

"colorscheme pablo
colorscheme zenburn
highlight Comment cterm=italic

au BufNewFile,BufRead *.muttrc setl ft=muttrc

filetype indent plugin on
filetype indent on

" jumplist
map <C-k> <C-i>
map <C-l> <C-o>

"map ;o :Sex <CR>
"map ;] :tabnext<CR>
"map ;[ :tabprev<CR>
"map <C-t> :tabe +"browse ."<CR>
"map <C-O> :NERDTreeToggle ~/curr/trunk/<CR>
