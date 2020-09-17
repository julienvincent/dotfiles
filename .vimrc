syntax on

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" This script will auto-install vim-plug plugin manager
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" a set of vim-plug plugins to include
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

call plug#end()

" Enable the gruvbox color scheme
autocmd vimenter * colorscheme gruvbox

