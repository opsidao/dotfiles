set colorcolumn=120

set clipboard+=unnamedplus

set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set nowrap

set number relativenumber

set foldmethod=syntax
set foldlevel=20

" let mapleader = ","

call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'brooth/far.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'slashmili/alchemist.vim'
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'

call plug#end()

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

colorscheme 1989

" Ignore node_modules when searching with ctrl_p
let g:ctrlp_custom_ignore = {
\ 'dir': '\v[\/](node_modules|vendor)$',
\ }

" Function to clear dangling white spaces from buffer
function! s:FixWhitespace(line1,line2)
  let l:save_cursor = getpos(".")
  silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
  call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" Remove trailing whitespaces on save
" autocmd BufWritePre * :FixWhitespace

" Ale options
let g:ale_linters = {'ruby': ['rubocop', 'ruby'], 'elixir': ['mix'], 'javascript': ['eslint'], '*': ['trim_whitespace', 'remove_trailing_lines']}
let g:ale_fixers = {
\   'ruby': [
\       'rubocop',
\   ],
\   'javascript': [
\       'eslint',
\       'prettier',
\   ],
\   'elixir': [
\       'mix_format',
\   ],
\   '*': [
\       'trim_whitespace',
\       'remove_trailing_lines'
\   ]
\}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 100
let g:ale_fix_on_save = 1

" Go back to last known possition when opening a buffer
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Set filetype for Jenkinsfiles
autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy

" Clear search highlight with two escapes
nmap <esc><esc> :noh<return>

let g:airline_theme='bubblegum'

" Find current file on NERDTree
nmap <leader>nf :NERDTreeFind<cr>

" Let rhubarb know about github enterprise
let g:github_enterprise_urls = ['https://source.xing.com']

" search and replace selected text
vnoremap <C-h> "hy:%s/<C-r>h//gc<left><left><left>

" Use the silver surfer for ctrl_p
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" Run deoplete on startup
let g:deoplete#enable_at_startup = 1
