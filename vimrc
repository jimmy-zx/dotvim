" vimrc - Basic configuration

set nocompatible
scriptencoding utf-8
let $LANG='en'

filetype plugin indent on
syntax on

set encoding=utf-8
set fileformat=unix

" general
set autowrite
set hidden
set mouse=nv
set history=1000
set backspace=indent,eol,start
set magic
set ttyfast
set ttimeoutlen=1
set lazyredraw
set writebackup
set shortmess+=filmnrxoOtT

set ignorecase
set smartcase

set incsearch
set hlsearch

set wildmenu
set wildmode=full

set showcmd

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
set showmatch
set showmode
set number
set relativenumber
set colorcolumn=80
set cursorcolumn
set cursorline

set scrolljump=5
set scrolloff=3

set autoindent
set shiftwidth=4
set shiftround
set expandtab
set tabstop=4
set softtabstop=4
set smarttab

" terminal cursor
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" undercurl
" let &t_Cs = "\e[4:3m"
" let &t_Ce = "\e[4:0m"

" ruler and statusline
set ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) "
set laststatus=2
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=\ [%{&ff}/%Y]            " Filetype
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

set background=light

augroup DvimStartup
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
augroup END

" mappings
set pastetoggle=<F12>
let g:mapleader = "\\"
let g:maplocalleader = "`"
inoremap <C-U> <C-G>u<C-U>

" filetype: c
let g:c_syntax_for_h = 1
augroup DvimC
    autocmd!
    autocmd FileType c setlocal tabstop=2
    autocmd FileType c setlocal shiftwidth=2
    autocmd FileType c setlocal softtabstop=2
augroup END

" filetype: tex
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
augroup DvimTex
    autocmd!
    autocmd FileType tex setlocal spell
augroup END

" filetype: asm
augroup DvimAsm
    autocmd!
    autocmd FileType asm setlocal modeline
    autocmd FileType asm setlocal noexpandtab
    autocmd FileType asm setlocal tabstop=8
    autocmd FileType asm setlocal shiftwidth=8
    autocmd FileType asm setlocal softtabstop=8
    autocmd FileType gas setlocal commentstring=#%s
augroup END

" neovim support
if has('nvim')
    set viminfo=<800,'10,/50,:100,h,f0,n~/.config/nvim/viminfo
else
    set viminfo=<800,'10,/50,:100,h,f0,n~/.vim/viminfo
endif

let uname = system('uname -r')
" wsl support
if uname =~ "Microsoft"
    set t_u7=
endif

" vim: set ft=vim:
