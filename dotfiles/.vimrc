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
"Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
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
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'gcmt/taboo.vim'
call plug#end()


" auto reload vimrc when editing it
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:200,n~/.viminfo
augroup nvimrc
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
augroup End

augroup autocd
    autocmd BufEnter * silent! lcd %:p:h
augroup End

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
set wildignore=*/.git/*,*.o,*.class,*.pyc,*/corpus/* "ignore these files while expanding wild chars
set autoread
set cursorline
"Appearance
set background=dark
colorscheme ron
set showmatch		    " Cursor shows matching ) and }
syntax on		        " syntax highlight
highlight Pmenu term=standout  ctermfg=255  ctermbg=8
highlight PmenuSel term=standout  ctermfg=255  ctermbg=3
set winminwidth=0
"Backup
set nobackup            " no *~ backup files
"Fold
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"Timeout
set timeoutlen=500
set ttimeoutlen=0
"Diff
set diffopt+=vertical
cnoreabbrev dp diffput
augroup diffsetting
    autocmd!
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup diffsetting
"Tab
set shiftwidth=4
set tabstop=4
set expandtab
"Complete
"set completeopt=menu,noselect
"spell
augroup tex
    autocmd!
    autocmd FileType tex set spelllang=en_us
    autocmd FileType tex set spell
    autocmd FileType tex vmap j gj
    autocmd FileType tex vmap k gk
augroup End

"Terminal setting
let g:terminal_scrollback_buffer_size=100000 
nnoremap <leader>t :terminal zsh<CR>
nnoremap <M-t> <C-w>v<C-w>l:terminal zsh<CR>
"tnoremap <Esc> <C-\><C-n>:call RestoreCursor()<CR>
"tnoremap jk <C-\><C-n>:call RestoreCursor()<CR>
"tnoremap <C-a> <C-\><C-n>:call RestoreCursor()<CR><C-w>
"tnoremap <C-z> <C-v><C-z>
"tnoremap <C-h> <C-\><C-n>gT
"tnoremap <C-l> <C-\><C-n>gt
""make alt binding work in terminal
"tnoremap <A-h> h
"tnoremap <A-l> l
"tnoremap <C-k> <Up>
"tnoremap <C-j> <Down>
augroup term
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
augroup End

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
"Paste mode
"noremap <leader>p :set invpaste<CR>
"set pastetoggle=<leader>p
"Undo
noremap <leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

""" PLUGIN SETTINGS
"fzf
nnoremap <C-o> :FZF<CR>

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
let g:ultisnips_python_style = 'numpy'

"neomake
augroup NEOMAKE_CHECK
    autocmd!
    autocmd BufWritePost * Neomake
augroup End
let g:neomake_python_pep8_maker = {
    \ 'args': ['--ignore','E128, E402, E501'],
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

"vimtex
let g:vimtex_view_general_viewer = 'evince'

"vim-markdown
let g:vim_markdown_math = 1

"Rainbowparenthesis
let g:rainbow_active = 1
let g:rainbow_conf = {'ctermfgs': ['1', '2', '3', '6']}

"jedi
let g:jedi#show_call_signatures = 2

"undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
