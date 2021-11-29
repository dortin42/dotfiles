" dortin42 vimrc settings (a fork of danirod settings focussed to general purpose)
" LICENSE:
" You are free to read and study this bundle or snippets of it and to use
" it on your own vimrc settings. Feel free to tweak and adapt my vimrc to
" suit your needs and to make the changes yours. Attribution to this vimrc
" is not required although is thanked.

" vim-plug is not installed
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent !npm i -g eslint babel-eslint eslint-plugin-react tern neovim typescript javascript-typescript-langserver
    silent !gem install bundler neovim ripper-tags solargraph --no-ri --no-doc
    silent !curl -fLso ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
end

" vim-plug plugins
call plug#begin("~/.config/nvim/plugged/")

" General purpose plugins
" Plug 'gioele/vim-autoswap' " Please Vim, stop with these swap file messages. Just switch to the correct window!
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors with selection and ctrl + d
Plug 'tpope/vim-surround' " Puts ({[ etc with yss csW on normal mode, in visual mode S
Plug 'tpope/vim-repeat' " Repeat surround and other cmd plugins with .
Plug 'tpope/vim-eunuch' " Better cmd for Vim
Plug 'tpope/vim-dispatch' " background subprocess
Plug 'tpope/vim-fugitive' " Vim + Git = <3
Plug 'tpope/vim-abolish' " Better substitutions :%Subvert/facilit{y,ies}/building{,s}/g and toggle cases:
" MixedCase (crm),
" camelCase (crc),
" snake_case (crs),
" UPPER_CASE (cru),
" dash-case (cr-),
" dot.case (cr.),
" space case (cr<space>),
" Title Case (crt)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim' " Emmet Ctrl + b + , in normal or insert mode
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] } " Display a tree view for archives with , + n + t
Plug 'yegappan/greplace', { 'on': ['Gqfopen'] } " Use :Gsearch and :Greplace for search and replace in files
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)', 'GrepperRg'] } " :Grepper pattern and :Gqfopen
" Plug 'bling/vim-airline' " Status bar
Plug 'nvim-lualine/lualine.nvim'
" Plug 'romgrk/barbar.nvim'
Plug 'chentau/marks.nvim'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'SmiteshP/nvim-gps'
Plug 'jghauser/mkdir.nvim'

Plug 'Raimondi/delimitMate' " Autoclose ',(,{,[
Plug 'roxma/nvim-yarp'
Plug 'matze/vim-move' " Move a line or selection with Alt + j/k
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " TS compiler with :make
" Plug 'roxma/python-support.nvim' " auto pip install with :PythonSupportInitPython3 (not working right now)
Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] } " Undo tree, see the wiki please
Plug 'FooSoft/vim-argwrap' " wrap and unwrap hashes and arrays with ,a
Plug 'AndrewRadev/splitjoin.vim' " wrap code statements gS and gJ
Plug 'unblevable/quick-scope' " magic with f
Plug 'ggandor/lightspeed.nvim'  " magic with s
Plug 'AndrewRadev/switch.vim' " Switch and toggle a lot of things, see the wiki

" Language support
Plug 'dense-analysis/ale' " Vim syntax checker
Plug 'tpope/vim-rails' " Vim Rails productivity (I strongly recommend read the wiki)
Plug 'tpope/vim-endwise' " Autoclose keywords on ruby with 'end'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'sheerun/vim-polyglot' " text highlight
Plug 'vim-ruby/vim-ruby' " Better autocomplete and indent for Ruby
Plug 'maxmellon/vim-jsx-pretty' " JSX
Plug 'wellle/targets.vim' " Better text object handling
" Plug 'lifepillar/pgsql.vim' " PSQL
" Plug 'jalvesaq/Nvim-R', {'branch': 'stable'} " R
" Plug 'fatih/vim-go' " GO (read the wiki PLS)

" Colorschemes
Plug 'RRethy/nvim-base16'
" Plug 'morhetz/gruvbox'
" Plug 'dortin42/golden-vim'
call plug#end()

" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" |-----------------------------------------------------------------------------------------------|
" |--------------------------------------> settings for VIM <-------------------------------------|
" |-----------------------------------------------------------------------------------------------|
" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
colorscheme base16-gruvbox-dark-pale

" Ignore compiled files
set wildignore=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*~

" Stop acting like classic vi
set nocompatible " disable vi compatibility mode
set history=777 " increase history size
set mouse=a " Activate the mouse
set synmaxcol=200 " Some times the line is too long, is good idea disable color syntax
set splitbelow splitright " change split direction
let mapleader=","

" Modify indenting settings
set autoindent " autoindent always ON.
set expandtab " expand tabs
set shiftwidth=4 " spaces for autoindenting
set softtabstop=4 " remove a full pseudo-TAB when i press <BS>
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Some programming languages work better when only 2 spaces padding is used.
autocmd FileType html,css,sass,scss,javascript setlocal sw=2 sts=2
autocmd FileType json setlocal sw=2 sts=2
autocmd FileType ruby,eruby setlocal sw=2 sts=2
autocmd FileType yaml setlocal sw=2 sts=2
autocmd FileType markdown setlocal wrap

" Modify some other settings about files
set encoding=utf-8 " always use unicode (god damnit, windows)
set backspace=indent,eol,start " backspace always works on insert mode
set is " Instant search
set hidden

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set noswapfile

set noshowmode " always show which mode are we in
set laststatus=2 " always show statusbar
set wildmenu " enable visual wildmenu

set nowrap " don't wrap long lines
set number " show line numbers
set relativenumber " show numbers as relative by default
set showmatch " higlight matching parentheses and brackets

" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=$HOME/.local/share/nvim/undo/
    set undofile
    set undolevels = 777 "maximum number of changes that can be undone
    set undoreload = 10000 "maximum number lines to save for undo on a buffer reload
catch
endtry

" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" |-----------------------------------------------------------------------------------------------|
" |------------------------------------> settings for terminal <----------------------------------|
" |-----------------------------------------------------------------------------------------------|
" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" Are we supporting colors?
if &t_Co > 2 || has("gui_running")
   syntax on
   set colorcolumn=80
   silent! color gruvbox
   set background=dark
endif

" Extra fancyness if full pallete is supported.
if &t_Co >= 256 || has("gui_running")
    set termguicolors
    set cursorline
    set cursorcolumn
endif

" Mark trailing spaces depending on whether we have a fancy terminal or not
if &t_Co > 2 || has("gui_running")
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
else
    set listchars=trail:$
    set list
endif

" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" |-----------------------------------------------------------------------------------------------|
" |------------------------------------> settings for plugins <-----------------------------------|
" |-----------------------------------------------------------------------------------------------|
" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" Markdown
au FileType markdown set conceallevel=0

" Disable auto pip for python 2 modules
let g:python_support_python2_require = 0

" JS indenting
let g:jsx_ext_required = 1

" Ruby
let g:loaded_ruby_provider = 0
let g:ruby_indent_access_modifier_style = 'indent'
let g:ruby_indent_block_style = 'do'

"ALE
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'javascript': ['eslint'],
            \   'ruby': ['rubocop'],
            \}
let g:ale_fix_on_save = 1

" Vim Surround
autocmd FileType erb let b:surround_45 = "<% \r %>" " Key -
autocmd FileType erb let b:surround_61 = "<%= \r %>" " Key =
autocmd FileType rb let b:surround_61 = "#{\r}" " Key =

" Undotree
let g:undotree_WindowLayout = 4
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_DiffAutoOpen = 0

" NERDTree
let nerdtreequitonopen=1
let nerdtreewinsize=17

" DelimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_inside_quotes = 1

" Quick scope only with f and t
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Coc snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

" FZF RG
function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg -g '!design/' -g '!dist/' -g '!pnpm-lock.yaml' -g '!.git' -g '!node_modules' --column --line-number --no-heading --color=always --smart-case -- %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Windows copypaste
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.regname=='+' | call system('echo '.shellescape(join(v:event.regcontents)).' | '.s:clip) | endif
    augroup END
endif

lua << EOF
require('gitsigns').setup()
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  indent = { enable = false },
  autotag = { enable = true }
}
require('marks').setup({
default_mappings = true
})
require("nvim-gps").setup()
local gps = require("nvim-gps")
require('lualine').setup({
options = {
    icons_enabled = false,
    theme = 'gruvbox-material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    },
sections = {
    lualine_a = {'mode'},
    lualine_b = {{'filename', path=1}},
    lualine_c = {{gps.get_location, cond=gps.is_available}},
    lualine_x = {'branch', 'diff', {'diagnostics', sources={'nvim_lsp', 'coc'}}},
    lualine_y = {'encoding'},
    lualine_z = {'location'}
    },
inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
    },
extensions = {'nerdtree', 'fugitive', 'fzf'},
tabline = {
    lualine_a = {{'buffers', show_filename_only=false, mode=2}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
    }
})
EOF

" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" |-----------------------------------------------------------------------------------------------|
" |-------------------------------------> personalized keys <-------------------------------------|
" |-----------------------------------------------------------------------------------------------|
" |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
" Find files
nnoremap <C-t> :FZF<CR>
nnoremap <Leader>g :RG<Space>
nnoremap <C-B> :Buffers<CR>
" Insert a space in normal mode
nnoremap <space> i<space><esc>

" Insert an Enter in normal mode
nnoremap <A-+> i<CR><esc>h
nnoremap + 0i<CR><esc>h

" Find word under cursor
nnoremap # #n

" Make window navigation less painful.
nmap <BS> <C-W>h
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <C-q> <C-^>

" Mapping for multiple-cursors
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>' " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>' " replace visual C-n

" Working with buffers is cool.
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap <C-f> :bfirst<CR>
nnoremap <C-g> :blast<CR>

" Working with tabs is cool.
nnoremap <Leader>l :tablast<CR>
nnoremap <Leader>f :tabfirst<CR>
nnoremap <Leader>n :tabNext<CR>
nnoremap <Leader>p :tabprevious<CR>

" Copy/paste from system clipboard
nnoremap  Y "+y
vnoremap  Y "+y

" Force update file
nnoremap <F5> :e!<CR>

" Relative numbering is pretty useful for motions (3j, 5k...). however i'd
" prefer to have a way for switching relative numbers with a single map.
nmap <F6> :set invrelativenumber<CR>
imap <F6><esc> :set invrelativenumber<CR>a

" Undo tree
nnoremap <F7> :UndotreeToggle<CR>

" NERDtree
map <f2> :NERDTreeToggle<CR>
nmap <Leader>r :NERDTreeFind<CR>

" Close the current buffer
command! BW :bn|:bd#
nnoremap <Leader>q :BW<CR>

" Delete current buffer
nnoremap <Leader>d :Unlink<CR>:BW<CR>

" Save and restore sessions
" Quick write session with F3
nnoremap <F3> :mksession! ~/.vim/session <cr>
" And load session with F4
nnoremap <F4> :source ~/.vim/session <cr>

" Save with Ctrl + s
nnoremap <C-s> :update<CR>
inoremap <C-s> <Esc>:update<CR>a

" Wrap arrays and hashes
nnoremap <silent> <Leader>a :ArgWrap<CR>

" Switch
let g:switch_mapping = "-"

" Grepper
let g:grepper = {}
let g:grepper.tools = ['rg']
nnoremap <Leader>t :GrepperRg<Space>
nnoremap <Leader>T :Grepper -tool rg -buffers<CR>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" Copy file path
nmap <Leader>y :let @+ = expand("%")<CR>
nnoremap <C-c> <ESC>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
