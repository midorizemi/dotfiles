"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.vim/dein/repos/github.com/Shougo/dein.vim
let s:dein_path = expand($HOME.'/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if dein#load_state(s:dein_path)
    " Required:
    call dein#begin(s:dein_path)
    " Let dein manage dein
    let g:config_dir  = expand(s:dein_path.'/tomls')
    let s:toml        = g:config_dir . '/dein.toml'
    let s:lazy_toml   = g:config_dir . '/dein_lazy.toml'
    " TOML 読み込み
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
" call map(dein#check_clean(), "delete(v:val, 'rf')")

"End dein Scripts-------------------------


"ColorScheme Setting----------------------
syntax enable
"colorscheme solarized
"colorscheme wombat256mod

"Molokai Settings-------------------------
"colorscheme molokai
set background=dark
"let g:molokai_original = 1
"let g:rehash256 = 1

"hybrid Settings-------------------------
set background=dark
colorscheme hybrid


if &term =~ "xterm-256color" || "screen-256color"
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c

"liteline Settings--------------------------
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'LightLineModified',
  \   'readonly': 'LightLineReadonly',
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode'
  \ }
  \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

function! LightLineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"Default Settings---------------------------
syntax on

filetype on
filetype plugin indent on

set nowrap
set autoindent

"見た目系
"ルーラー表示
set ruler
"行番号
set number
" 現在の行を強調表示
set cursorline
set list
set wildmenu
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
set shiftwidth=4
set softtabstop=4
"tab設定 スペースに置き換えるタブ４スペース
set expandtab
set tabstop=4
set smarttab
set clipboard=unnamed
" ステータスラインを常に表示
set laststatus=2
"tmux向けのカーソル変更設定
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" 検索結果のハイライトをEsc連打でクリアする
nnoremap <ESC><ESC> :nohlsearch<CR>

"日本語入力を無効化
"set imdisable

" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" エスケープシーケンスの表示 tab eol
set list
set listchars=tab:▸\ ,eol:¬

" 全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        "ZenkakuSpace をカラーファイルで設定するなら、
        "次の行をコメントアウト
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"記号表示
set ambiwidth=double  "Display double-width symbols properly

"viとの互換性を無効にする(INSERT中にカーソルキーが有効になる)
set nocompatible

"カーソルを行頭，行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]

"BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

"Backup,Swapファイルの保存ディレクトリ----
"バックアップファイルのディレクトリを指定する
set backupdir=$HOME/.vim/backup
"スワップファイル用のディレクトリを指定する
set directory=$HOME/.vim/tmp

" マウスホイールを有効化
set mouse=a
set ttymouse=xterm2

"" Mapleader <Space> + key
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
nmap <Leader><Tab> <C-w>w
nnoremap <Leader>dt o<ESC>:.!date +\%H:\%M<CR>kJ
inoremap <silent> jj <ESC><CR>

"NerdTree Settings------------------------
let NERDTreeShowHidden=1

"Vim-Nerdtree-Tabs Settings---------------
if argc() == 0
    let g:nerdtree_tabs_open_on_console_startup = 1
end

