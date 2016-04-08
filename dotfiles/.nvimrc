" .nvimrc of ipod825 {{{
" Download vim-plug
let vim_plug_file=expand('~/.nvim/autoload/plug.vim')
if !filereadable(vim_plug_file)
    echo "Installing vim-plug.."
    echo ""
    silent !mkdir -p ~/.nvim/autoload
    silent !wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P ~/.nvim/autoload
endif
" }}}

""" PLUGINS {{{
call plug#begin('~/.nvim/bundle')
"" Coding
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'benekastah/neomake'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
"" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim', {'on': 'GV'}
"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"" Mapping
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/Mouse-Toggle'
"" Appearance
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"" Technical writing
Plug 'reedes/vim-lexical'
Plug 'vim-pandoc/vim-pandoc', {'for': ['tex', 'md']}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['tex', 'md']}
"" Completion
Plug 'Shougo/deoplete.nvim'
"" File browsing
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all', 'on': 'FZF' }
"" General utils
Plug 'mbbill/undotree'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'gcmt/taboo.vim'
Plug 'rking/ag.vim'
Plug 'kana/vim-textobj-user'
Plug 'ipod825/vim-textobj-ipod825'
Plug 'tpope/vim-repeat'
Plug 'rhysd/clever-f.vim'
Plug 'terryma/vim-expand-region'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" Install plugins for the first time
if empty(glob("~/.nvim/bundle"))
    :PlugInstall
    :UpdateRemotePlugin
endif
"}}}


" ============================================================================
" GENERAL SETTINGS
" ============================================================================
" Main Autocmd Group {{{
augroup SETTINGS
    autocmd!
    " Automatically reload vimrc when editing it
    autocmd BufWritePost *vimrc source %:p
    " Use mark for vimrc
    autocmd BufEnter *vimrc setlocal foldmethod=marker
    " Help in new tab
    autocmd BufEnter *.txt if &buftype == 'help'| wincmd T| nnoremap <buffer> q :q<cr>| endif
    " Diff setting
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
    " Enter insert mode when enter terminal
    autocmd! BufEnter * if &buftype == "terminal" | startinsert | endif
    " Automatically change directory
    autocmd BufEnter *.vim,*.html,*.py,*.sh,*.c,*.cpp,*.cc,*.csv,*rc silent! lcd %:p:h
    " Automatically restore cursor position
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Spell
    autocmd BufEnter *.tex,*.md setlocal spell
augroup END
"}}}

" Main Setting {{{
filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins
syntax on               " syntax highlight
set hidden              " Enable you to edit other buffer without saving current buffer
set mouse=              " Disable mouse (for using mouse to copy text from to system clipboard)
set copyindent          " Copy the previous indentation on autoindenting
set ignorecase          " Ignore case when searching
set smartcase           " Ignore case when searching only if searching pattern contains only lower letters
set noautoread          " Do note automatically refresh file after modified (use :e instead)
set foldmethod=indent   " Folding with indent
set foldnestmax=5       " Maximum folding
set foldtext=MyFoldText() " Show first line when folding
set viminfo='10,\"100,:200,n~/.nviminfo "Restore cursor to file position in previous editing session
set wildignore=*/.git/*,*.o,*.class,*.pyc "ignore these files while expanding wild chars
set timeoutlen=500
set ttimeoutlen=0
set diffopt+=vertical
set virtualedit=block
"}}}

" Appearance {{{
set showmatch           " Highlight matching ) and }
set background=dark
colorscheme ron
" Current line
set cursorline
highlight CursorLine term=bold cterm=bold ctermbg=236
" menu
highlight Pmenu term=standout  ctermfg=255  ctermbg=8
highlight PmenuSel term=standout  ctermfg=255  ctermbg=24

" spell
highlight SpellBad ctermbg=88

" tailing space
highlight ExtraWhitespace ctermbg=20
match ExtraWhitespace /\s\+$/
set winminwidth=0
noremap <Space> za
vnoremap <Space> zf
" tab
set shiftwidth=4
set tabstop=4
set expandtab
"" Complete
set completeopt=menu,noinsert
inoremap <expr> <CR> pumvisible() ? "\<C-S-y>" : "\<C-g>u\<CR>"
"" spell
"}}}

" ============================================================================
" KEY MAPPING
" ============================================================================
" Mode Changing {{{
nnoremap ; :
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap <Cr> <Esc>
inoremap <c-a> <esc><c-w>
"}}}

" Moving Around {{{
nnoremap j gj
nnoremap k gk
nnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-j> }
vnoremap <C-k> {
vmap <M-k> <Plug>(expand_region_expand)
vmap <M-j> <Plug>(expand_region_shrink)
"}}}

" Moving Around (home,end) {{{
onoremap <M-h> g0
onoremap <M-l> g$
onoremap jk <Esc>
vnoremap <M-h> g0
vnoremap <M-l> g$
nnoremap <M-h> g0
nnoremap <M-l> g$
inoremap <M-h> <Esc>g0i
inoremap <M-l> <Esc>g$i
tnoremap <M-h> h
tnoremap <M-l> l
"}}}

" Terminal {{{
if has('nvim')
    let g:terminal_scrollback_buffer_size=100000
    " Open a new one
    nnoremap <M-t> :tabe term://zsh<CR>
    nnoremap <M-o> <C-w>s<C-\><C-n><C-w>j<C-\><C-n>:terminal zsh<CR>
    nnoremap <M-e> <C-w>v<C-\><C-n><C-w>l<C-\><C-n>:terminal zsh<CR>
    
    " Stay at the last line when exiting terminal
    tnoremap <Esc> <C-\><C-n>:call RestoreCursor()<CR>
    tnoremap jk <C-\><C-n>:call RestoreCursor()<CR>
    tnoremap <C-a> <C-\><C-n>:call RestoreCursor()<CR><C-w>
    tnoremap <C-z> <C-v><C-z>
endif
"}}}

" Handy Mapping {{{
nnoremap <C-/> gcc " Toggle comment
" Keep in visual mode
vnoremap < <gv
vnoremap > >gv
" Tab switching
nnoremap <C-h> gT
nnoremap <C-l> gt
tnoremap <C-h> <C-\><C-n>gT
tnoremap <C-l> <C-\><C-n>gt
nnoremap <C-M-h> :tabm -1<CR>
nnoremap <C-M-l> :tabm +1<CR>
" Window switching
nnoremap <C-a> <C-w>
" Up & Down
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
"}}}

" ============================================================================
" PLUGIN SETTINGS
" ============================================================================
" Add Plugin Setting Here {{{
" fzf
nnoremap <C-o> :FZF<CR>

" yankstack
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

" nerdtree
let g:NERDTreeMapActivateNode='<Space>'
let g:NERDTreeMapChdir='<Cr>'
let g:nerdtreemaprefreshroot='r'
let NERDTreeIgnore = ['\.pyc$']

" airline
let g:airline_theme='wombat'

" ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:ultisnips_python_style = 'numpy'

" neomake
augroup NEOMAKE_CHECK
    autocmd!
    autocmd BufWritePost * Neomake
augroup End
let g:neomake_python_pep8_maker = {
    \ 'args': ['--ignore','E251, E225, E226, W291, W293, E501, E402, E731, E302, E231, E241, E261'],
    \ 'errorformat': '%f:%l:%c: %m',
    \ }
let g:neomake_python_enabled_makers = ['python', 'pep8']
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'WarningMsg',
    \ }

" vimtex
let g:vimtex_view_general_viewer = 'evince'

" Rainbowparenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {'ctermfgs': ['1', '2', '3', '6']}

" undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" ag
let g:ag_working_path_mode="r"
if executable('ag')
  set grepprg=ag
endif

" indentLine
let g:indentLine_color_term = 35

" deoplete
let g:deoplete#enable_at_startup = 1

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"}}}

" ============================================================================
" Functions
" ============================================================================
" Add Functions Here {{{
fu! RestoreCursor()
    let l=search('\%' . virtcol('.') . 'v\S', 'bW')
    call cursor(l,0)
endfunction

fu! MyFoldText()
  let nucolwidth = &fdc + &number*&numberwidth
  let winwd = winwidth(0) - nucolwidth - 5
  let foldlinecount = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
  let prefix = " _______>>> "
  let fdnfo = prefix . string(v:foldlevel) . "," . string(foldlinecount)
  let line =  strpart(getline(v:foldstart), 0 , winwd - len(fdnfo))
  let fillcharcount = winwd - len(line) - len(fdnfo)
  return line . repeat(" ",fillcharcount) . fdnfo
endfunction
