autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab cuc ai
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead Berksfile set filetype=ruby
set number
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-python/python-syntax'
Plug 'Konfekt/FastFold'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Unset bell(errorbell)
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
