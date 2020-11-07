" Run pathogen
execute pathogen#infect()

set nocompatible
set noshowmode

set backspace=indent,eol,start

" Fly through buffers
nnoremap gb :ls<CR>:b<Space>
set hid

" Enable mouse
set mouse=a

" Show tabs
set list
set listchars=tab:»\  " ends with space

" jk = esc in insert mode
inoremap jk <esc>

" tab = 4 spaces
"set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Move through splits not stupidly
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" Enable line numbers
set number

" Turn on syntax highlighting
syntax on

" Auto-tab new lines to match previous line
set autoindent
set copyindent

" Auto read when a file is changed from the outside
set autoread

" Ignore case when searching
set ignorecase

" Try to be smart about cases when searching
set smartcase

" Highlight search results
set hlsearch

" Reduce update time for plugins
set updatetime=250

" Allows you to remove highlighting after done with search
nnoremap <CR> :noh<CR><CR>

" Wrap lines indented at sensible breakpoints rather than scrolling horizontally
set wrap
set linebreak
set breakindent

" Better command-line completion
set wildmenu

" Auto add current file suffix to gf searches
autocmd BufEnter * let &suffixesadd=expand('%:e')

"----------------------------
"     Colorscheme stuff
"----------------------------

" Set to 256 colors
set t_Co=256

" enable true color
if (has("termguicolors"))
	set termguicolors
endif

" dark
set background=dark

" Available colorschemes
"colorscheme pulumi
colorscheme novum
"colorscheme one
"colorscheme vice

" Make comments italic if italics enabled in term
highlight Comment cterm=italic

" fix background issues on tmux
set t_ut=

" highlight .js files as .jsx
autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx

"----------------------------
"          Plugins
"----------------------------

" ***** vim-airline ***** "

" Custom symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '|'
let g:airline_right_alt_sep = '|'

" Allows statusbar to show up with one window
set laststatus=2

" Toggles
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_detect_crypt=0
let g:airline_detect_spell=0

" Custom statusline
function! AirlineInit()
	let g:airline_section_a = airline#section#create([''])
	let g:airline_section_b = airline#section#create(['branch', ' ', 'hunks'])
	let g:airline_section_c = airline#section#create(['file'])
	let g:airline_section_x = airline#section#create(['%l/%L : %3c'])
	let g:airline_section_y = airline#section#create([''])
	let g:airline_section_z = airline#section#create(['mode'])
	let g:airline_section_warning = airline#section#create_right(['ale_warning_count'])
	let g:airline_section_error = airline#section#create_right(['ale_error_count'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline_extensions = ['branch', 'hunks']

" ***** NERDTree ***** "

" Open on start
""autocmd vimenter * NERDTree | wincmd p

" Open with ctrl + n
nnoremap <C-n> :NERDTreeToggle<CR>

" pressing ] inside any open file in vim will jump to the nerdtree and highlight where that file is
map ] :NERDTreeFind<CR>

" Close when last window is a nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" show hidden files by default
let g:NERDTreeShowHidden = 1

" ***** Ale ***** "

let g:ale_sign_error = ' ●'
let g:ale_sign_warning = ' ○'

" go to next error with ctrl+e
nmap <silent> <C-e> <Plug>(ale_next_wrap)

" Help YATS not shit itself (disable old regex engine)
set re=0
