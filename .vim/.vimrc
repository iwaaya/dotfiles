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
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tomasr/molokai'

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
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set shiftwidth=4
set expandtab

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る

" molokai
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=gray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=darkgray
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

" auto comment off
augroup auto_comment_off
     autocmd!
         autocmd BufEnter * setlocal formatoptions-=r
             autocmd BufEnter * setlocal formatoptions-=o
             augroup END

nnoremap <silent><C-e> :NERDTree<CR>
hi Comment ctermfg=yellow
