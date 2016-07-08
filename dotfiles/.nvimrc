" .nvimrc of ipod825 {{{
silent! source ~/.nvim_site.vim
" Download vim-plug
let vim_plug_file=expand('~/.nvim/autoload/plug.vim')
if !filereadable(vim_plug_file)
    echo "Installing vim-plug.."
    echo ""
    silent !mkdir -p ~/.nvim/autoload
    silent !wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -P ~/.nvim/autoload
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
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
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
"" Git
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim', {'on': 'GV'}
"" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
"" Mapping
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/Mouse-Toggle'
"" Appearance
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"" Completion
Plug 'Shougo/deoplete.nvim', {'do': (function('DoRemote'))}
"" File browsing
Plug 'scrooloose/nerdtree'
"" General utils
Plug 'mbbill/undotree'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'gcmt/taboo.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 't9md/vim-quickhl'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Install plugins for the first time
if empty(glob("~/.nvim/bundle"))
    echo "No plugins installed. Please run ':PlugInstall'"
endif
"}}}


" ============================================================================
" GENERAL SETTINGS
" ============================================================================
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
set noautoread          " Do not automatically refresh file after modified (use :e instead)
set foldmethod=indent   " Folding with indent
set foldnestmax=5       " Maximum folding
set foldtext=MyFoldText() " Show first line when folding
set viminfo='10,\"100,:200,n~/.nviminfo "Restore cursor to file position in previous editing session
set wildignore=*/.git/*,*.o,*.class,*.pyc "ignore these files while expanding wild chars
set timeoutlen=500
set ttimeoutlen=0
set diffopt+=vertical
set virtualedit=block,onemore
set spellfile="~/.nvim/spell/texmath.utf-8.add"
if has('unix')
    set t_Co=256
endif
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
highlight TabLineSel ctermbg=24

" spell
highlight SpellBad cterm=underline ctermbg=8

" diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

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
"}}}
"
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
    " Automatically change directory (enumerate filetypes to avoid conflict conflict with vim-fugitive)
    autocmd BufEnter *.vim,*.html,*.py,*.sh,*.c,*.cpp,*.cc,*.csv,*rc,*.md silent! lcd %:p:h
    " Automatically restore cursor position
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Spell
    autocmd BufEnter *.tex,*.md,*.adoc setlocal spell
    " Tab
    autocmd BufEnter *.snip set noexpandtab
    autocmd BufLeave *.snip set expandtab
augroup END
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
nnoremap L ;
nnoremap H ,
vnoremap <C-j> }
vnoremap <C-k> {
inoremap <C-h> <Left>
inoremap <C-l> <Right>
tnoremap <C-M-h> <Left>
tnoremap <C-M-l> <Right>
"}}}

" Moving Around (home,end) {{{
onoremap <M-h> g^
onoremap <M-l> g_
onoremap jk <Esc>
vnoremap <M-h> g^
vnoremap <M-l> g_
nnoremap <M-h> g^
nnoremap <M-l> g_
inoremap <M-h> <Esc>g^i
inoremap <M-l> <Esc>g_i
tnoremap <M-h> <Home>
tnoremap <M-l> <End>
"}}}

" Terminal {{{
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
"}}}

" Handy Mapping {{{
noremap <C-/> <Plug>NERDCommenterToggle
" Keep in visual mode
vnoremap < <gv
vnoremap > >gv
" Tab switching
nnoremap <C-h> gT
nnoremap <C-l> gt
tnoremap <C-h> <C-\><C-n>gT
tnoremap <C-l> <C-\><C-n>gt
nnoremap <C-m-h> :tabm -1<CR>
nnoremap <C-m-l> :tabm +1<CR>
" Window switching
nnoremap <C-a> <C-w>
" Up & Down
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
" handy mappings
nnoremap <leader>n :set nonumber!<CR>
tnoremap <F5> <C-\><C-n>:call PudbMode()<CR>i
nnoremap <F5> <C-\><C-n>:call PudbMode()<CR>
"}}}

" ============================================================================
" PLUGIN SETTINGS
" ============================================================================
" Add Plugin Setting Here {{{
" yankstack
if exists("yankstack#setup")
    let g:yankstack_map_keys = 0
    call yankstack#setup()
    nmap <c-p> <Plug>yankstack_substitute_older_paste
    nmap <c-n> <Plug>yankstack_substitute_newer_paste
endif

" nerdtree
let g:NERDTreeMapActivateNode='<Space>'
let g:NERDTreeMapChdir='<Cr>'
let g:nerdtreemaprefreshroot='r'
let NERDTreeIgnore = ['\.pyc$']

" airline
let g:airline_theme='wombat'

" neosnippet
let g:neosnippet#snippets_directory='~/.nvim/snippets'
cnoreabbrev NeoSnippetEdit NeoSnippetEdit -split -vertical
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"

vmap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"


" auto-pairs
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsMapCh = 0
let g:AutoPairsMapCR = 0
let g:AutoPairsCenterLine = 0
let g:AutoPairsMapSpace = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairs= {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', "$":"$", '<':'>'}
let g:AutoPairsParens = {'(':')', '[':']', '{':'}', '<':'>'}
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
let g:vimtex_indent_enabled = 0

" Rainbowparenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {'ctermfgs': ['1', '2', '3', '6']}

" undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 0

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-mutiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" quickhl
nmap <leader>h <Plug>(quickhl-manual-this)

" fzf
let g:fzf_buffers_jump = 1
function! s:find_root()
  for vcs in ['.git']
    let dir = finddir(vcs.'/..', ';')
    if !empty(dir)
      execute 'FZF' dir
      return
    endif
  endfor
  FZF
endfunction

command! FZFR call s:find_root()
nnoremap <C-o> :FZFR<Cr>
inoremap <C-o> <Esc>:FZFR<Cr>
tnoremap <C-o> <C-\><C-n>:FZFR<Cr>

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


fu! PudbMode()
    if !exists("s:enterpudb")
        let s:enterpudb = 0
    endif
    if s:enterpudb==0
        let s:enterpudb=1
        echomsg "Entering pudb mode"
        set timeoutlen=10
    else
        let s:enterpudb=0
        echomsg "Exiting pudb mode"
        set timeoutlen=500
    endif
endfunction
