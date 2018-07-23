if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'pangloss/vim-javascript'
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'luochen1990/rainbow'
Plug 'wesq3/vim-windowswap'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme'
Plug 'skielbasa/vim-material-monokai'
Plug 'jiangmiao/auto-pairs',
Plug 'hashivim/vim-terraform'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'

call plug#end()

set nocompatible
set hlsearch
set encoding=utf8
set number
set title
set updatetime=100
set mouse=a
filetype plugin on

" Folding
set foldmethod=syntax   
set nofoldenable

" ALE
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier', 'eslint']
let g:ale_fixers['typescript'] = ['prettier', 'tslint']
let g:ale_javascript_prettier_use_local_config = 1

" Invert where vim open new split
set splitbelow
set splitright

"mes raccourcis comme dans notepad++ pour bouger des lignes
"bouger la ligne vers le bas
nnoremap <silent> <C-Down> :.m+<CR>
"bouger la ligne vers le haut
nnoremap <silent> <C-Up> :-m.<CR>k

set wildignore+=.git
set wildignore+=node_modules

" indenting http://tedlogan.com/techblog3.html
set autoindent
set expandtab "hitting tab insert spaces instead of <Tab>
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline_theme='materialmonokai'
let g:materialmonokai_subtle_airline=1

" Display
set background=dark
set termguicolors
colorscheme material-monokai
syntax on
let g:materialmonokai_italic=1
let g:materialmonokai_subtle_spell=1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1

" Terraform Plugin
let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

" NERDTree plugin
map <C-n> :NERDTreeToggle<CR>

" Function to show diff between current file and saved one
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

"Highlight trailing whitespaces
autocmd Syntax * syn match TrailingWhitespace /\s\+$/
autocmd Syntax * highlight def link TrailingWhitespace Error
"Remove trailing whitespaces for certain files when saving
autocmd FileType c,cpp,java,javascript,php,groovy,tf autocmd BufWritePre <buffer> %s/\s\+$//e

" Highlight current line in current buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
