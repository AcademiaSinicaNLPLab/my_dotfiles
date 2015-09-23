""" VUNDLE
let iCanHazVundle=1
let vundle_readme=expand('~/.nvim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'jiangmiao/auto-pairs'
"Bundle 'Townk/vim-autoclose'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'vim-scripts/tlib'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/EasyGrep'
Bundle 'bling/vim-airline'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'mbbill/undotree'
Bundle 'kana/vim-textobj-user'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'christophermca/meta5'
"Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'
"Bundle 'gregsexton/gitv'

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
"VirtualEdit
set ve=block
"Appearance
set background=dark
colorscheme ron
set showmatch		    " Cursor shows matching ) and }
syntax on		        " syntax highlight
highlight Pmenu term=standout  ctermfg=255  ctermbg=8
highlight PmenuSel term=standout  ctermfg=255  ctermbg=3
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
    autocmd BufWritePost * if &diff == 1 | diffupdate | endif
augroup diffsetting
"Tab
set shiftwidth=4
set tabstop=4
set expandtab
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
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <C-l> <Right>
tnoremap <M-h> <Home>
tnoremap <M-l> <End>
tnoremap <C-j> <Down>
tnoremap <C-k> <Up>
tnoremap <Cr> <C-\><C-n>:call Ccd()<Cr>i<Cr>
tnoremap <C-a> <C-\><C-n><C-w>
tnoremap <C-z> <C-v><C-z>
"tnoremap <Cr> <C-\><C-n>:call Ccd()<Cr>


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
nnoremap <C-h> <Esc>:tabp<CR> 
nnoremap <C-l> <Esc>:tabn<CR> 
nnoremap j gj
nnoremap k gk
nnoremap <C-a> <C-w>
nnoremap <M-t> :tabe<CR>:tabmove 0<CR>:terminal zsh<CR>
nnoremap <leader>t <C-w>v<C-w>l:terminal zsh<CR><C-\><C-n><C-w>hi
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
"Error console
map to	:copen<Cr>
map tc	:cclose<Cr>
map tn :cn<CR>
map tp :cp<CR>
map tj <C-w>w
map tk <C-w>w
"Paste mode
noremap <leader>p :set invpaste<CR>
set pastetoggle=<leader>p
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


let g:num_buffer_kept=20
"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

"To be written into pluggin

augroup auto_close
    autocmd BufNew * call BufferGC()
augroup End

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

augroup auto_cd
    autocmd BufEnter * silent! lcd %:p:h
augroup END

fu! Ccd()
    call cursor(line('$'),0)
    let l=search('\%' . virtcol('.') . 'v\S', 'bW')
    let line = getline(l)
    let pystr = "'" . line . "'" . ".index('cd')"
    silent! let beg = pyeval(pystr)
    if beg!=0
        let dir = strpart(line, beg+3, strlen(line)-beg+3)
        echom "now" dir
        silent! lcd `=dir`
    endif
endfunction

