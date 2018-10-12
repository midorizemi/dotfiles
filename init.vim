" encoding "
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

" tab indents "
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4

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

" dein "
let s:dein_dir = expand('$CACHE/dein')
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml('~/.vim/rc/dein.toml',          {'lazy': 0})

    " call dein#load_toml('~/.vim/rc/dein_lazy.toml',     {'lazy': 1})
    " call dein#load_toml('~/.vim/rc/dein_neo.toml',      {'lazy': 1})
    " call dein#load_toml('~/.vim/rc/dein_python.toml',   {'lazy': 1})
    " call dein#load_toml('~/.vim/rc/dein_go.toml',       {'lazy': 1})
    " call dein#load_toml('~/.vim/rc/dein_frontend.toml', {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif
