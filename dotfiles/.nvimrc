" .nvimrc of ipod825 {{{
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
"" Coding utils
Plug 'tomtom/tcomment_vim'          " commenter
Plug 'benekastah/neomake'           " syntax check
Plug 'luochen1990/rainbow'          " parenthnes highighlight
Plug 'jiangmiao/auto-pairs'         " parenthnes pairing
Plug 'Shougo/neosnippet'            " snippets engine
Plug 'Shougo/neosnippet-snippets'   " snippets collection
Plug 'terryma/vim-multiple-cursors' " helpful for refactoring code
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}      " python indent
Plug 'Shougo/deoplete.nvim', {'do': (function('DoRemote'))} " auto completion
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " align code - helpful for latex table
"" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim', {'on': 'GV'}
"" Mapping
Plug 'nelstrom/vim-visual-star-search' " * in visual mode
Plug 'vim-scripts/Mouse-Toggle'
"" Appearance
Plug 'bling/vim-airline' " status line
Plug 'vim-airline/vim-airline-themes' " extra status line theme
"" File browsing
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"" technical writing
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'JamshedVesuna/vim-markdown-preview'
"" General utils
Plug 'mbbill/undotree' " unlimited undo
Plug 'maxbrunsfeld/vim-yankstack' " clipboard stack
Plug 'gcmt/taboo.vim' " reasonable tab displayed name
Plug 't9md/vim-quickhl' " manual (multiple) highlighing words
Plug 'justinmk/vim-sneak'


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
    autocmd BufEnter *.vim,*.html,*.py,*.sh,*.c,*.cpp,*.cc,*.csv,*rc,*.md,*.tex silent! lcd %:p:h
    " Automatically restore cursor position
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Spell
    autocmd BufEnter *.tex,*.md,*.adoc setlocal spell
    " Tab
    autocmd BufEnter *.snip set noexpandtab
    autocmd BufLeave *.snip set expandtab
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
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
cnoremap qq bwipeout
"}}}

" ============================================================================
" PLUGIN SETTINGS
" ============================================================================
" Add Plugin Setting Here {{{
" yankstack
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

" nerdtree
let g:NERDTreeMapActivateNode='<Space>'
let g:NERDTreeMapChdir='<Cr>'
let g:nerdtreemaprefreshroot='r'
let NERDTreeIgnore = ['__pycache__$[[dir]]', '\.pyc$']

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

fu! ToggleAutoPair()
    if !exists("s:originalPairs")
        let s:originalPairs = copy(g:AutoPairs)
    endif

    let s:technical_filetypes = ['plaintex', 'markdown', 'asciidoc']
    if (index(s:technical_filetypes, &ft)>-1)
        for [key, value] in items({"$":"$", '<':'>'})
            let g:AutoPairs[key] = value
        endfor
    else
        let g:AutoPairs = copy(s:originalPairs)
    endif
endfunction

augroup AUTOPAIRS_SETTING
    autocmd!
    autocmd BufEnter * call ToggleAutoPair()
augroup END
" neomake
augroup NEOMAKE_CHECK
    autocmd!
    autocmd BufWritePost * Neomake
augroup End
let g:neomake_python_pep8_maker = {
    \ 'args': ['--ignore','E225, E231, E226, E402, E501, E731'],
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
let g:vimtex_fold_enabled = 1
if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.tex =
    \ '\v\\%('
    \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
    \ . '|hyperref\s*\[[^]]*'
    \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|%(include%(only)?|input)\s*\{[^}]*'
    \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
    \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
    \ . ')\m'

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
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <C-o> :GFiles<Cr>
inoremap <C-o> <Esc>:GFiles<Cr>
tnoremap <C-o> <C-\><C-n>:GFiles<Cr>

nnoremap <C-M-o> :BTags<Cr>
inoremap <C-M-o> <Esc>:BTags<Cr>

let g:fzf_action = {
  \ 'space': 'tab drop',
  \ 'enter': 'drop',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" vim-sneak
let g:sneak#streak = 1

" vim-markdown-preview
" let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_github=1


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
