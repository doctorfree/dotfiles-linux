execute pathogen#infect()
set nocompatible
set backspace=indent,eol,start
set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching
if has('mouse')
  set mouse=a
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" Using plug.vim Plugin manager from https://github.com/junegunn/vim-plug
" Commands
" PlugInstall [name ...] [#threads]  Install plugins
" PlugUpdate  [name ...] [#threads]  Install or update plugins
" PlugClean[!]  Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade   Upgrade vim-plug itself
" PlugStatus    Check the status of plugins
" PlugDiff      Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]  Generate script for restoring
"                                the current snapshot of the plugins
call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" Initialize plugin system
"
" Make your Vim/Neovim as smart as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_disable_startup_warning = 1
" Kitty config syntax highlighting for vim
Plug 'fladson/vim-kitty'
" Colorschemes
Plug 'flazz/vim-colorschemes'
Plug 'gmarik/ingretu'
" Language support
Plug 'davidhalter/jedi-vim'    " Python autocompletion
Plug 'klen/python-mode'        " Python IDE
let g:pymode = 1
let g:pymode_warnings = 1
Plug 'fatih/vim-go'            " Go language support for Vim
" Plug 'derekwyatt/vim-scala'  " Scala language support
" Plug 'tpope/vim-rails'       " Editing Ruby on Rails applications
Plug 'yuezk/vim-js'            " Syntax highlighting for JavaScript and Flow.js
Plug 'leafgarland/typescript-vim' " Typescript syntax
" To disable built-in Typescript indentation:
" let g:typescript_indent_disable = 1
Plug 'maxmellon/vim-jsx-pretty' " The React syntax highlighting and indenting
Plug 'gmarik/snipmate.vim'      " TextMate's snippets features in Vim
Plug 'gmarik/snipmate.snippets' " gmarik's custom snippet collection
Plug 'gmarik/vim-markdown'      " Markdown syntax support for Vim
Plug 'tpope/vim-git'            " Syntax, indent, and filetype for Git
" Git integration - :Git (or just :G) calls any arbitrary Git command
Plug 'tpope/vim-fugitive'       " For more information, see :help fugitive
" :GV to open commit browser
"     You can pass git log options to the command, e.g. :GV -S foobar -- plugins
" :GV! will only list commits that affected the current file
" :GV? fills the location list with the revisions of the current file
Plug 'junegunn/gv.vim'      " A git commit browser (requires vim-fugitive)
Plug 'tpope/vim-repeat'     " Remaps '.' to repeat the last plugin map as a whole
Plug 'tpope/vim-surround'   " Delete/change/add parentheses/quotes/XML-tags/more
Plug 'tpope/vim-unimpaired' " Pairs of handy bracket mappings
Plug 'AndrewRadev/splitjoin.vim'
Plug 'gmarik/github-search.vim'
Plug 'gmarik/ide-popup.vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'sjl/gundo.vim'
Plug 'mkitt/browser-refresh.vim'
Plug 'bogado/file-line'
Plug 'junegunn/vim-easy-align'
" Plug 'vim-scripts/lastpos.vim'
Plug 'Lokaltog/vim-easymotion'
" Plug 'ZoomWin'
Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
Plug 'gmarik/hlmatch.vim'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'rstacruz/sparkup.git', {'rtp': 'vim/'}
Plug 'fladson/vim-kitty'
Plug 'hrsh7th/nvim-cmp'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'godlygeek/tabular'  " needed by 'preservim/vim-markdown'
" Plug 'preservim/vim-markdown'
Plug 'epwalsh/obsidian.nvim'
call plug#end()
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
if has("gui_running")
  colorscheme ingretu
else
  colorscheme darkspectrum
endif
set guifont=Inconsolata:h18
let g:syntastic_html_checkers = []
