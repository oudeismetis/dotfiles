" this must be first. compatible is for users who want to use Vim like Vi
set nocompatible

" Temporarily turn off filetype detection. Turns back on further down.
filetype off

" plugins
set rtp+=~/.vim/bundle/Vundle.vim " requires git clone of vundle
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'chriskempson/base16-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" file management
set hidden " hide buffers instead of closing them on new file open
set wildmenu " enable menu at bottom of vim window
set wildmode=list:longest,full " auto-complete on tab settings

" appearance / misc
set ruler
set encoding=utf-8
set fileencoding=utf-8
set showmode
set t_Co=256
syntax on
set number

" colorscheme Tomorrow-Night-Blue
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-tomorrow
set background=dark
if exists('+colorcolumn')
  set colorcolumn=80
endif

" search
set ignorecase " case-insensitive for all-lower patterns
set smartcase " case-sensitive only for patterns with uppercase
set incsearch " highlight next match while you type
set hlsearch " highlight all matches found

" tabs / indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab  " use spaces instead of tab
set autoindent " copy previous line's indentation

" recoveries
silent !mkdir -p ~/.vim/{backup,swp}/
set backupdir=~/.vim/backup/
set directory=~/.vim/swp/

" backspace
set backspace=indent,eol,start

" Turns filetype back on to apply indenting
filetype plugin indent on

au FileType ruby set ts=2 sw=2 tw=79 et sts=2 autoindent
au FileType yaml set ts=2 sw=2 et
au FileType javascript,python set ts=4 sw=4 tw=79 et sts=4 autoindent
au FileType html,perl,c,cpp set tw=79 autoindent
au FileType mail set tw=68 et
au BufRead,BufNewFile /usr/local/etc/nginx/* set ft=nginx

" remove all trailing whitespace
autocmd FileType html,py,scss autocmd BufWritePre <buffer> :%s/\s\+$//e

" Abbreviations and key remaps

" quit with just q
map q :q<CR>
" use hlsearch while typing /
nmap <silent><leader>/ :set hlsearch! hlsearch?<CR>
" easier split navigating
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" disable arrow keys to force good homerow habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" search mappings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" syntax highlighting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic config
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['pylama'] " pip install pylama 

" Send things to clipboard
set clipboard=unnamed

" nerdtree
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeShowHidden=1
