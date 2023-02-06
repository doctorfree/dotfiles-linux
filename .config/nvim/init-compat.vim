set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" Use my existing .vimrc
source ~/.vimrc
" Exit NeoVim's terminal emulator (:term) by simply pressing escape
tmap <Esc> <C-\><C-n>
" Override those configurations for each project with a local .nvimrc
set exrc
" Allow scripts to run for specific file types
:filetype plugin on

