" Vim configuration files

" Muhammad Faran Aiki
" This is for both competitive programming and normal programming
" Latex support is supported too :)

filetype plugin indent off
syntax off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim

set nocompatible

set number

set autoindent
set autoread

set shiftwidth=4
set tabstop=4

set mouse=a

" Let's use vim 
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py'

" Relative line mixing
inoremap <expr> <C-L> &relativenumber == 1 ? '<Esc>:set number<Enter>:set norelativenumber<Enter>i' : '<Esc>:set relativenumber<Enter>:set number<Enter>i'
nnoremap <expr> <C-L> &relativenumber == 1 ? '<Esc>:set number<Enter>:set norelativenumber<Enter>' : '<Esc>:set relativenumber<Enter>:set number<Enter>'

" Set some thing
inoremap { {}<Left>
inoremap {} {}
inoremap [ []<Left>
inoremap [] []
inoremap ( ()<Left>
inoremap () ()
inoremap " ""<Left>
inoremap "" ""
inoremap ' ''<Left>
inoremap '' ''

inoremap < <><Left>
inoremap <<Space> <<Space>
inoremap << <<

inoremap {<CR> {<CR>}<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap (<CR> (<CR>)<ESC>O

inoremap <M-N> <Esc>:tabe
nnoremap <M-N> :tabe 

inoremap <C-A> <Esc>ggVG$
nnoremap <C-A> ggVG$

inoremap <C-S> <Esc>:w<Enter>i
nnoremap <C-S> :w<Enter>

inoremap <M-Left> <Esc>:tabp<Enter>i
nnoremap <M-Left> :tabp<Enter>

inoremap <M-Right> <Esc>:tabn<Enter>i
nnoremap <M-Right> :tabn<Enter>

vmap <C-V> yy"+p
vmap <C-C> "+y

" Using Vundle
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'hallettj/jslint.vim'
	Plugin 'junegunn/fzf.vim'
	Plugin 'junegunn/fzf'
	Plugin 'mattn/emmet-vim'
	Plugin 'sukima/xmledit'
	Plugin 'lervag/vimtex'
	Plugin 'pangloss/vim-javascript'
	Plugin 'Shougo/deoplete.nvim'
call vundle#end()

" Map for competitive programming and or math

au FileType cpp map <F5> :w <CR> :!g++ % && ./a.out <CR>
au FileType c map <F5> :w <CR> :!gcc % && ./a.out <CR>
au FileType python map <F5> :w <CR> :!python % & <CR>
au FileType tex map <F5> :w <CR> :!pdflatex % & <CR>

" Auto command for new file
au BufNewFile *.cpp, 0r ~/.vim/templates/competitive.cpp | 39
au BufNewFile *.c, 0r ~/.vim/templates/competitive.c | 13

au BufNewFile *.py, 0r ~/.vim/templates/python.py | 4
au BufNewFile *.html, 0r ~/.vim/templates/html.html | 8

au BufNewFile *.tex 0r ~/.vim/templates/latex.tex | 24 
au BufNewFile *.latex 0r ~/.vim/templates/latex.tex | 24 

" Last cursor position
au BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

filetype plugin indent on 
syntax on

source ~/.vim/fshort/loadall.vim

" TODO use st I guess
if !has("nvim")
	set term=kitty
endif

if has("nvim")
	let g:deoplete#enable_at_startup = 1
	call deoplete#enable()
endif
