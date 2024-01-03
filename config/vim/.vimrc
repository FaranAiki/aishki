" Vim/NVim configuration files

" Muhammad Faran Aiki
" This is for both competitive programming and normal programming
" Latex support is supported too :)

filetype plugin indent off
syntax off

" Vundle
" if !has("nvim")
set rtp+=~/.vim/bundle/Vundle.vim
" else
" set rtp?
" endif

set nocompatible

set number

set autoindent
set autoread

set shiftwidth=4
set tabstop=4

set mouse=a

" Let's use vim 
if has("vim")
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py'
endif

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
inoremap <M-N> <Esc>:tabe

" Movement
inoremap <C-A> <Esc>ggVG$
nnoremap <C-A> ggVG$

inoremap <C-Down> <Esc>gji<Right>
inoremap <C-Up> <Esc>gki<Right>

nnoremap <C-J> gj
nnoremap <C-K> gk
nnoremap <C-Down> gj
nnoremap <C-Up> gk

" Shortcut
inoremap <C-S> <Esc>:w<Enter>i
nnoremap <C-S> <Esc>:w<Enter>

inoremap <C-Left> <Esc>:tabp<Enter>i
nnoremap <C-Left> <Esc>:tabp<Enter>

inoremap <C-Right> <Esc>:tabn<Enter>i
nnoremap <C-Right> <Esc>:tabn<Enter>

inoremap <C-Q> <Esc>:mkses!<Enter>:wqa<Enter>
nnoremap <C-Q> <Esc>:mkses!<Enter>:wqa<Enter>

inoremap <C-M-Q> <Esc>:qa!<Enter>
nnoremap <C-M-Q> <Esc>:qa!<Enter>

" Copy and paste
vmap <C-V> yy"+p
vmap <C-C> "+y

" Using Vundle, using PluginInstall
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'hallettj/jslint.vim'
	Plugin 'junegunn/fzf.vim'
	Plugin 'junegunn/fzf'
	Plugin 'mattn/emmet-vim'
	Plugin 'sukima/xmledit'
	Plugin 'lervag/vimtex'
	Plugin 'pangloss/vim-javascript'

if has("nvim")
	Plugin 'Shougo/deoplete.nvim'
	Plugin 'mattn/vim-lsp-settings'
	Plugin 'zchee/libclang-python3'
	Plugin 'lighttiger2505/deoplete-vim-lsp'	
	Plugin 'deoplete-plugins/deoplete-clang'
	Plugin 'deoplete-plugins/deoplete-jedi'
	Plugin 'deoplete-plugins/deoplete-go'
	Plugin 'sebastianmarkow/deoplete-rust'
	Plugin 'JuliaEditorSupport/deoplete-julia'	
	Plugin 'simrat39/symbols-outline.nvim'
	Plugin 'preservim/nerdtree'

	Plugin 'prabirshrestha/vim-lsp'
endif

call vundle#end()

" NerdTREE
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" LSP

" setting with vim-lsp
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
      \   lsp#utils#find_nearest_parent_file_directory(
      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \   'cache': {'directory': stdpath('cache') . '/ccls' },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" Pyls
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

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
syntax enable

" Latex setup
source ~/.vim/fshort/loadall.vim

let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:vimtex_compiler_method = 'pdftex'

" TODO use st I guess
if !has("nvim")
	set term=kitty
endif

" Nowadays, I use nvim since it is more cool
if has("nvim")
	let g:deoplete#enable_at_startup = 1
	call deoplete#enable()
endif

" GUI in Neovide

let s:guifont_size = 8
let s:guifont_name = "Source\\ Code\\ Pro"

function! AdjustFontSize(amount)
	let s:guifont_size = s:guifont_size + a:amount
	exe "set guifont=" .. s:guifont_name .. ":h" .. s:guifont_size
endfunction

if exists("g:neovide")
	call AdjustFontSize(0) 
endif

nnoremap <C-+> :call AdjustFontSize(1)<Enter>
nnoremap <C-_> :call AdjustFontSize(-1)<Enter>

