" encoding "
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

" tab indents "
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2

" search "
set incsearch
set ignorecase
set smartcase
set hlsearch

" activate backspace "
set backspace=indent,eol,start

" hyouji "
set number
set cursorline

" command completion "
set wildmenu
set history=5000

" clip board "
set clipboard+=unnamedplus

" remap :: carsol move "
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" remap :: no HighLight "
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" remap :: SPLIT "
" s -> cl
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
" call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
" call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
" call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
" call submode#map('bufmove', 'n', '', '>', '<C-w>>')
" call submode#map('bufmove', 'n', '', '<', '<C-w><')
" call submode#map('bufmove', 'n', '', '+', '<C-w>+')
" call submode#map('bufmove', 'n', '', '-', '<C-w>-')

if !empty($TERM_PROGRAM) && $TERM_PROGRAM == 'Apple_Terminal'
  set t_SH=
endif

" dein "
"dein Scripts-----------------------------
let s:dein_cache_dir = expand('$VIM_CACHE/dein')
let s:dein_config_dir = expand('$XDG_CONFIG_HOME/nvim/dein/tomls/')
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/cde/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  " Let dein manage dein
  " Required:
  " call dein#add(s:dein_cache_dir.'/repos/github.com/Shougo/dein.vim')
  call dein#load_toml(s:dein_config_dir.'dein.toml',          {'lazy': 0})
  call dein#load_toml(s:dein_config_dir.'dein_lazy.toml',     {'lazy': 1})


  call dein#load_toml(s:dein_config_dir.'dein_clang.toml', {'lazy': 1})
  " Add or remove your plugins here like this:
  " call dein#add('cespare/vim-toml')


  " Load tomls:
  " call dein#load_toml('~/.vim/rc/dein_neo.toml',      {'lazy': 1})
  " call dein#load_toml('~/.vim/rc/dein_python.toml',   {'lazy': 1})
  " call dein#load_toml('~/.vim/rc/dein_go.toml',       {'lazy': 1})
  " call dein#load_toml('~/.vim/rc/dein_frontend.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
