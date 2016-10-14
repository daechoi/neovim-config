call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'steelsojka/deoplete-flow'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'ton/vim-bufsurf'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim' " required by gist-vim
call plug#end()

for plugin in keys(g:plugs)
    let s:plugin_config = $HOME . '/.config/nvim/plugin.d/' . plugin . '.vim'
    if filereadable(s:plugin_config)
        execute 'source ' . s:plugin_config
    endif
endfor


"" Leader mappings
let mapleader = ","


" Always disable paste mode when leaving insert mode
au InsertLeave * set nopaste

" Show trailing whitespace characters
set list
set listchars=tab:▸\ ,trail:·,extends:…,nbsp:␣
" Show soft wrapped lines as …
set showbreak=↳

" Cooler tab completion for vim commands
" http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names
set wildmode=longest,list

" By default use 4 spaces as indentation
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab

" Easier curly braces insertion
imap § {
imap ½ }
imap ° }

" Map escape key to jj -- much faster to exit insert mode
imap jj <esc>



" Write buffer (save)
noremap <Leader>w :w<CR>
imap ,w <esc>:w<CR>

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="



"" Extend navigation keys

" First non whitespace character
map ö ^

" End of line
map ä $

" Begining of line
map Ö 0

" Last non space character
map Ä g_

" Same for visual mode
vmap ö ^
vmap ä $
vmap Ö 0
vmap Ä g_

" hide buffers instead of closing them
" Allows to change buffers with unsaved changes
set hidden

" The crossair
set cursorline cursorcolumn

colorscheme molokai

" Toggle with last previous buffer
nnoremap <leader>m :b#<cr>
nnoremap <leader>b :buffer<space>

" Do toggle to netrw view
let g:netrw_altfile = 1

" Select another file from the directory of the current one
nnoremap <leader>f :execute 'edit' expand("%:p:h")<cr>

noremap <Leader>w :w<CR>

noremap <Up> :bNext<cr>
noremap <Down> :brewind<cr>


" Close current buffer
noremap <Leader>d :bd<CR>

" Make Y behave like other capitals. Yank to end of line.
map Y y$

" Use mouse only in visual mode
set mouse=v

" This turns off Vim’s crazy default regex characters and makes searches use
" normal regexes.
nnoremap / /\v
vnoremap / /\v

" * Search & Replace
" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Clear search hilights
noremap  å :noh<cr><esc>

" Word scouting
" Hilight all words matching the one under the cursor and mark the position to
" 'p'. Return to original word with <Leader><Space>
noremap <Space> mp*N
noremap  <Leader><Space> 'p \| :noh<cr>
" Same for visual mode selection too
vmap <Space> mpy/<C-r>"<cr>

" Join lines from below too. See :help J
map K kJ

" Easily resize split windows with Ctrl+hjkl
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-h> <C-w><
nnoremap <C-l> <C-w>>
