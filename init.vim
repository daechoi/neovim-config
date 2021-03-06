" PLUG_UPDATE=1 nvim -c 'PlugClean | PlugUpdate'
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Enable only when flow is in PATH otherwise it causes errors with Javascript
" files
call system('which flow')
if  v:shell_error == 0 || $PLUG_UPDATE == 1
    Plug 'steelsojka/deoplete-flow'
endif

" Breaks normal vim paste
if has('nvim')
    Plug 'bfredl/nvim-miniyank'
endif

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim' " required by gist-vim
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/Rename'
Plug 'jeetsukumaran/vim-buffersaurus'
Plug 'tomtom/tcomment_vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-repeat' " makes surround work with . (repeat)
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'simnalamburt/vim-mundo' " alt https://github.com/mbbill/undotree
Plug 'vim-airline/vim-airline'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-sleuth'
call plug#end()

"" Leader mappings
let mapleader = ","


for plugin in keys(g:plugs)
    if has("win32")
        let s:plugin_config = $HOME . '/AppData/Local/nvim/plugin.d/' . plugin . '.vim'
    elseif has('nvim')
        let s:plugin_config = $HOME . '/.config/nvim/plugin.d/' . plugin . '.vim'
    else
        let s:plugin_config = $HOME . '/.vim/plugin.d/' . plugin . '.vim'
    endif

    if filereadable(s:plugin_config)
        execute 'source ' . s:plugin_config
    endif
endfor


if has('nvim')
    " Legacy 'easy paste' helper
    map <C-i> :echo 'No need'<cr>
else
    " Enter paste mode with Ctrl+i
    map <C-i> :set paste<CR>i
endif

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

" Do not toggle to netrw view
let g:netrw_altfile = 1

"" DISABLED using ctrlp for this
" Toggle with last previous buffer
" nnoremap <leader>m :b#<cr>

" Select another file from the directory of the current one
nnoremap <leader>F :execute 'edit' expand("%:p:h")<cr>

noremap <Leader>w :w<CR>

" Close current buffer
noremap <Leader>d :bd<CR>

" Make Y behave like other capitals. Yank to end of line.
map Y y$

" Use mouse only in visual mode
set mouse=v

" Turn magic off from search
nnoremap / /\V
vnoremap / /\V

" Make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" Hilight all words matching the one under the cursor
noremap <Space> *N
" Clear hilights
noremap  <Leader><Space> :noh<cr>

" Search literal strings
nnoremap <Leader>S :execute '/\V' . escape(input('/'), '\\/')<CR>
" Search literallly what was last yanked
nnoremap <Leader>s :execute '/\V' . escape(@", '\\/')<CR>
" Start search from visual selection. The let thing is to restore what was
" previously yanked to the unnamed register
vnoremap <Space> "xy:execute '/\V' . escape(@x, '\\/')<CR>:let @" = @0<CR>

" Join lines from below too. See :help J
map K kJ

" Easily resize split windows with Ctrl+hjkl
nnoremap <C-j> <C-w>+
nnoremap <C-k> <C-w>-
nnoremap <C-h> <C-w><
nnoremap <C-l> <C-w>>

" Show unsaved changes
command ShowUnsaved w !diff -u % -

" strip all trailing whitespace in the current file
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>'z

"  to reselect the text that was just pasted so I can perform commands (like
"  indentation) on it
nnoremap <leader>v V`]

" Use Q for formatting the current paragraph (or selection).
" Forces 80 character lines.
vmap Q gq
nmap Q gqap

" Move by screen lines instead of file line. Nice with long lines.
nnoremap j gj
nnoremap k gk

" Reset messed up Vim. Redraw screen, clear search hilights and balance window
" splits
map <F5> :redraw! \| :noh \| <cr><c-w>=

" Reselect visual block after indent/outdent. Allow ident/outdent multiple
" times
vnoremap < <gv
vnoremap > >gv


" Some aliases for typoists
command W w
command Q q
command WQ wq
command Wq wq
command Qa qa
command QA qa
command Wa wa
command WA wa
command E e
nnoremap ; :
vnoremap ; :
nnoremap _ :
vnoremap _ :

" and abbreviations
abbreviate lenght length
abbreviate lenghts lengths

" Open git diff window when editing a commit message
autocmd FileType gitcommit DiffGitCached | wincmd p


" Vim’s defaults are awful messy, leaving .swp files everywhere if the editor
" isn’t closed properly. This can save you a lot of time.
set nobackup
set noswapfile

" Autosave only when there is something to save. Always saving makes build
" watchers crazy
function! SaveIfUnsaved()
    if &modified
        :silent! w
    endif
endfunction
au FocusLost,BufLeave * :call SaveIfUnsaved()
" Read the file on focus/buffer enter
au FocusGained,BufEnter * :silent! !


" Assume json file type for these files
augroup json
    au!
    au BufNewFile,BufRead .eslintrc,.babelrc setlocal filetype=json
augroup END
