" Run pathogen
execute pathogen#infect()

set backspace=indent,eol,start

" Fly through buffers
nnoremap gb :ls<CR>:b<Space>
set hid

" Enable mouse
set mouse=a

" Show tabs
set list
set listchars=tab:»·

" Auto close braces, parens, brackets, quotes
inoremap { {}<left>
inoremap [ []<left>
inoremap ( ()<left>
inoremap ' ''<left>
inoremap " ""<left>

" tab = 4 spaces
"set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

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

" Allows you to remove highlighting after done with search
nnoremap <CR> :noh<CR><CR>

" Visual word wrapping
"set wm=4
"set lbr
"set wrap

" Highlight text over 80 columns wide
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%80v.*/

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
"set showcmd

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
colorscheme vice

" Make comments italic if italics enabled in term
highlight Comment cterm=italic

"----------------------------
"          Plugins
"----------------------------

" ***** vim-airline ***** "

" Customized sections of statusbar
function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode',' ','branch'])
	let g:airline_section_b = airline#section#create(['ffenc', 'hunks'])
	let g:airline_section_y = airline#section#create(['L:%l', ' ', 'C:%c'])
	let g:airline_section_z = airline#section#create_right(['%p%%'])

	" Displays ASCII value of char hovered over by cursor in hex
	"let g:airline_section_z = airline#section#create_right(['%B'])

	"let g:airline_section_b = '%{strftime("%c")}'
	"let g:airline_section_y = 'BN: %{bufnr("%")}'
endfunction
autocmd VimEnter * call AirlineInit()

set laststatus=2    " Allows statusbar to show up with one window

" Custom Seperator for statusbar
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Tabline options
let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

" Airline theme
"let g:airline_theme = 'vice'

" fugitive integration with airline (fugitive is git wrapper)
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.branch = "|"
let g:airline#extensions#branch#enabled = 1
"let g:airline#extensions#branch#empty_message = ''

" ***** Syntastic ***** "

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
