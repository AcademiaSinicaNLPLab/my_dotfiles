if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PluginInstall
endif
call plug#begin('~/.nvim/bundle')
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'vim-scripts/tlib'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/EasyGrep'
Plug 'bling/vim-airline'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'kana/vim-textobj-user'
Plug 'chrisbra/NrrwRgn'
Plug 'Shougo/unite.vim'
Plug 'godlygeek/tabular', {'on': 'Tabularize'}
Plug 'Shougo/deoplete.nvim'
""Bundle 'Shougo/deoplete.nvim'
""Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
""Bundle 'gregsexton/gitv'
call plug#end()



""" VIM
" auto reload vimrc when editing it
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
nnoremap <Leader>v :so ~/.vimrc<CR>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:200,n~/.nviminfo
augroup nvimrc
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
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
set wildignore=*/.git/*,*.o,*.class,*.pyc "ignore these files while expanding wild chars
set autoread
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
set completeopt=menu,noselect
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
tnoremap <Esc> <C-\><C-n>:call RestoreCursor()<CR>
tnoremap jk <C-\><C-n>:call RestoreCursor()<CR>
tnoremap <C-a> <C-\><C-n><C-w>
tnoremap <C-l> <Right>
tnoremap <M-h> <Home>
tnoremap <M-l> <End>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
tnoremap <C-z> <C-v><C-z>
tnoremap <C-h> <C-\><C-n>gT 
tnoremap <C-l> <C-\><C-n>gt 
tnoremap <A-h> <Home>
tnoremap <A-l> <End>
augroup term
    autocmd!
    autocmd BufEnter * if @%[0:6]=='term://' | startinsert | endif
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
"Moving around (home,end)
onoremap <M-h> g0
onoremap <M-l> g$
vnoremap <m-h> g0
vnoremap <m-l> g$
nnoremap <m-h> g0
nnoremap <m-l> g$
"Paste mode
"noremap <leader>p :set invpaste<CR>
"set pastetoggle=<leader>p
"Undo
noremap <leader>u :UndotreeShow<CR>:UndotreeFocus<CR>

""" PLUGIN SETTINGS
"Ctrlp
let g:ctrlp_map = '<c-o>'
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_working_path_mode = 'ra'
cnoreabbrev cpq CtrlPQuickfix
cnoreabbrev cpt CtrlPTag
cnoreabbrev cpb CtrlPBookmarkDir

" EasyGrep
let g:EasyGrepInvertWholeWord = 1
let g:EasyGrepMode = 2
let g:EasyGrepReplaceWindowMode = 2

" Surround
nmap <leader>0 ysiw)
nmap <leader>] ysiw]
nmap <leader>' ysiw'
nmap <leader>" ysiw"

"vim-textobj-utils
call textobj#user#plugin('comma', {
\   'comma':{
\      'pattern': '[^,]\+,',
\      'select': ['ac', 'ic'],
\},
\})

"Unite
let g:unite_source_history_yank_enable = 1
nnoremap <leader>p :Unite history/yank<CR>
"nnoremap <leader>/ :Unite grep:.<cr>
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>

"deoplete
let g:deoplete#enable_at_startup = 1

"vim-latex
"set grepprg=grep\ -nH\ $*
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_MultipleCompileFormats='dvi,pdf'
"let g:Tex_UseMakefile=0
"let g:Tex_ViewRule_pdf = 'qpdfview'
"let g:Tex_Menus=0
"let g:Tex_FoldedCommands='ctable'
" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get llist of probabilities
"highlight clear SpellBad
"highlight Spellbad term=standout ctermfg=1 term=underline cterm=underline
"highlight clear SpellCap
"highlight Spellcap term=underline cterm=underline
"highlight clear SpareRare
"highlight SpellLocale term=underline cterm=underline
"highlight clear SpareLocale
"highlight SpellLocale term=underline cterm=underline
"highlight Pmenu term=standout  ctermfg=255  ctermbg=8
"highlight PmenuSel term=standout  ctermfg=255  ctermbg=3
"

"syntastic
let g:syntastic_python_python_exec = '/usr/bin/python3'

""" Functions
fu! RestoreCursor()
    let l=search('\%' . virtcol('.') . 'v\S', 'bW')
    call cursor(l,0)
endfunction


"""To be written into pluggin

"let g:num_buffer_kept=20
"augroup auto_close
"    autocmd BufNew * call BufferGC()
"augroup End

function! BufferGC()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    let nBuffer = bufnr('$')
    for b in range(1, bufnr('$')-1)
        if nBuffer<=g:num_buffer_kept
            break
        endif
        if buflisted(b) && !getbufvar(b,"&mod") && index(tablist, b) == -1
        "bufno listed AND isn't modified AND isn't in the list of buffers open in windows and tabs
            exec 'bwipeout!' b
            let nBuffer = nBuffer-1
        endif
    endfor
endfunction

