"Plug Please run if not installed: curl -fLo ~/.nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.nvim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/EasyGrep'
Plug 'benekastah/neomake'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'chrisbra/csv.vim', {'for': 'csv'}
Plug 'nelstrom/vim-visual-star-search'
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'vim-scripts/Mouse-Toggle'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'reedes/vim-lexical'
Plug 'junegunn/vim-easy-align'
Plug 'mbbill/undotree'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'gcmt/taboo.vim'
Plug 'davidhalter/jedi-vim', {'for': 'python'}

call plug#end()

augroup SETTINGS
    autocmd!
    " auto reload vimrc when editing it
    autocmd BufWritePost *vimrc source %:p
    " help in new tab
    autocmd BufEnter *.txt if &buftype == 'help'| wincmd T| nnoremap <buffer> q :q<cr>| endif
    " diff setting
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
    " enter insert mode when enter terminal
    autocmd BufWinEnter,WinEnter term://* startinsert
    " auto change directory 
    autocmd BufEnter *.html,*.py,*.sh,*.c,*.cpp,*.cc,*.csv silent! lcd %:p:h
    " autoreload vimdr
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
    autocmd BufEnter temp setlocal buftype=nofile noswapfile bufhidden=delete
    "Filetype
    autocmd FileType tex setlocal spell
    autocmd FileType tex vmap j gj
    autocmd FileType tex vmap k gk
augroup END


""" GENERAL SETTINGS
filetype on             " Enable filetype detection
filetype indent on      " Enable filetype-specific indenting
filetype plugin on      " Enable filetype-specific plugins
set hidden              " enable you to edit other buffer without saving current buffer
set mouse=
set copyindent          " copy the previous indentation on autoindenting
set noignorecase        " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,case-sensitive otherwise
set wildmenu            " wild char completion menu
set wildchar=<TAB>      " start wild expansion in the command line using <TAB>
set viminfo='10,\"100,:200,n~/.nviminfo "Restore cursor to file position in previous editing session
set wildignore=*/.git/*,*.o,*.class,*.pyc,*/corpus/* "ignore these files while expanding wild chars
set autoread
set cursorline
set virtualedit=block
"Appearance
set background=dark
colorscheme ron
set showmatch		    " Cursor shows matching ) and }
syntax on		        " syntax highlight
highlight Pmenu term=standout  ctermfg=255  ctermbg=8
highlight PmenuSel term=standout  ctermfg=255  ctermbg=3
highlight SpellBad ctermbg=88
set winminwidth=0
"Backup
set nobackup            " no *~ backup files
"Fold
set foldmethod=indent
noremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"Timeout
set timeoutlen=500
set ttimeoutlen=0
"Diff
set diffopt+=vertical
cnoreabbrev dp diffput
"Tab
set shiftwidth=4
set tabstop=4
set expandtab
"Complete
set completeopt=menu,noselect
"spell

"Terminal setting
let g:terminal_scrollback_buffer_size=100000 
nnoremap <leader>t :tabe term://zsh<CR>
nnoremap <M-t> <C-w>v<C-w>l:terminal zsh<CR>
tnoremap <Esc> <C-\><C-n>:call RestoreCursor()<CR>
tnoremap jk <C-\><C-n>:call RestoreCursor()<CR>
tnoremap <C-a> <C-\><C-n>:call RestoreCursor()<CR><C-w>
tnoremap <C-z> <C-v><C-z>
tnoremap <C-h> <C-\><C-n>gT
tnoremap <C-l> <C-\><C-n>gt
"make alt binding work in terminal
tnoremap <M-h> h
tnoremap <M-l> l
tnoremap <C-k> <Up>
tnoremap <C-j> <Down>


""" KEY MAPPING
"Mode changing
nnoremap ; :
inoremap jk <Esc>
cnoremap jk <Esc>
vnoremap <Cr> <Esc>
inoremap <c-a> <esc><c-w>
vnoremap < <gv
vnoremap > >gv
"Moving around
nnoremap <C-h> <Esc>gT
nnoremap <C-l> <Esc>gt
nnoremap j gj
nnoremap k gk
nnoremap <C-a> <C-w>
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
vnoremap <C-k> dkP<S-v>
vnoremap <C-j> djP<S-v>
"Moving around (home,end)
onoremap <M-h> g0
onoremap <M-l> g$
vnoremap <m-h> g0
vnoremap <m-l> g$
nnoremap <m-h> g0
nnoremap <m-l> g$
inoremap <M-h> <Esc>g0i
inoremap <M-l> <Esc>g$i
vnoremap <leader>p y<Esc>:tabe temp<Cr>P:setlocal mouse=<Cr>


""" PLUGIN SETTINGS
"fzf

"yankstack
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste

" EasyGrep
let g:EasyGrepInvertWholeWord = 1
let g:EasyGrepMode = 2
let g:EasyGrepReplaceWindowMode = 2

"nerdtree
let  g:NERDTreeMapActivateNode='<Space>'
let  g:NERDTreeMapChdir='<Cr>'
let NERDTreeIgnore = ['\.pyc$']

"airline
let g:airline_theme='wombat'

"ultisnips
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger = '<Tab>'

"neomake
augroup NEOMAKE_CHECK
    autocmd!
    autocmd BufWritePost * Neomake
augroup End
let g:neomake_error_sign = {
    \ 'text': 'E>',
    \ 'texthl': 'ErrorMsg',
    \ }
let g:neomake_warning_sign = {
    \ 'text': 'W>',
    \ 'texthl': 'WarningMsg',
    \ }

"vimtex
let g:vimtex_view_general_viewer = 'evince'

"Rainbowparenthesis
augroup PLUG_rainbow_parentheses
    autocmd VimEnter * RainbowParenthesesToggle
    autocmd Syntax * RainbowParenthesesLoadRound
    autocmd Syntax * RainbowParenthesesLoadSquare
    autocmd Syntax * RainbowParenthesesLoadBraces
augroup end

"undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

""" Functions
fu! RestoreCursor()
    let l=search('\%' . virtcol('.') . 'v\S', 'bW')
    call cursor(l,0)
endfunction
