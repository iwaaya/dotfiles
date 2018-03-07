" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
		set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'fatih/vim-go'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'NLKNguyen/papercolor-theme'
NeoBundle 'simeji/winresizer'
NeoBundle 'tcnksm/gotests', { 'rtp': 'editor/vim' }

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"#####表示設定#####
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=4
set autoindent "オートインデント
set shiftwidth=4
set expandtab

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

" 背景色をterminalの色と揃える
" autocmd ColorScheme * highlight Normal ctermbg=none
" autocmd ColorScheme * highlight LineNr ctermbg=none

" colorscheme
set t_Co=256
colorscheme PaperColor
set background=light

" auto comment off
augroup auto_comment_off
     autocmd!
         autocmd BufEnter * setlocal formatoptions-=r
             autocmd BufEnter * setlocal formatoptions-=o
             augroup END

nnoremap <silent><C-e> :NERDTree<CR>
hi Comment ctermfg=darkred

" for winresizer
let g:winresizer_start_key = '<C-T>'
