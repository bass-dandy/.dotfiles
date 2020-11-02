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
colorscheme one
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
let g:airline#extensions#tabline#enabled = 0
let g:airline_detect_crypt=0
let g:airline_detect_spell=0

" Custom statusline
function! AirlineInit()
	let g:airline_section_a = airline#section#create_left([''])
	let g:airline_section_b = airline#section#create([''])
	let g:airline_section_c = airline#section#create(['file'])
	let g:airline_section_x = airline#section#create(['%l/%L : %3c'])
	let g:airline_section_y = airline#section#create([''])
	let g:airline_section_y = airline#section#create(['branch', ' ', 'hunks'])
	let g:airline_section_z = airline#section#create_left(['mode', 'paste'])
	let g:airline_section_error = airline#section#create(['syntastic'])
	let g:airline_section_warning = airline#section#create(['whitespace'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

let g:airline_extensions = ['branch', 'hunks', 'syntastic']

" ***** NERDTree ***** "

" Open on start
""autocmd vimenter * NERDTree | wincmd p

" Open with ctrl + n
nnoremap <C-n> :NERDTreeToggle<CR>

" Close when last window is a nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" show hidden files by default
let g:NERDTreeShowHidden = 1

" ***** Syntastic ***** "

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" Local linter support

let g:syntastic_javascript_checkers = ['eslint']

function FindAndSetEslintExec(current_folder)
	let l:filepath = a:current_folder . '/node_modules/.bin/eslint'
	if filereadable(l:filepath)
		let b:syntastic_javascript_eslint_exec = l:filepath
		let b:cdinh_eslint_exec_found = 1
	endif
endfunction

function FindLocalEslint()
	let b:cdinh_eslint_exec_found = 0
	let l:current_folder = expand('%:p:h')
	while b:cdinh_eslint_exec_found == 0 && l:current_folder != '/'
		call FindAndSetEslintExec(l:current_folder)
		let l:current_folder = fnamemodify(l:current_folder, ':h')
	endwhile
endfunction

autocmd FileType javascript call FindLocalEslint()
