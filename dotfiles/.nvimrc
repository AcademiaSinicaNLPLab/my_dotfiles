" vundle
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

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"Git
"Bundle 'gregsexton/gitv'
Bundle 'tpope/vim-fugitive'

"Completion
"Bundle 'vim-scripts/AutoComplPop'
Bundle 'jiangmiao/auto-pairs'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'vim-scripts/tlib'
"syntax check
Bundle 'scrooloose/syntastic'
"utils
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'vim-scripts/EasyGrep'
Bundle 'bling/vim-airline'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'

"Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'

" auto reload vimrc when editing it
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.nviminfo

augroup auto_cd
    autocmd BufEnter * silent! lcd %:p:h
augroup END

augroup term_emul
    autocmd! BufNewFile term.* echo "command implemented!"
augroup END

fu! Delbuf()
    echo "sad"
endfunction 

fu! Ccd()
    let l=search('\%' . virtcol('.') . 'v\S', 'bW')
    let line = getline(l)
    let cmd=join(split(line)[2:-1],' ') "This assumses there are two space before the real command in addition to the shell prompts
    let arg0 = strpart(cmd, 0, 2)
    let arg1 = strpart(cmd,2, strlen(cmd)-2)
    if arg0=='cd'
       silent! lcd `=arg1`
    endif
endfunction

tnoremap <Cr> <C-\><C-n>:call Ccd()<Cr>i<Cr>

augroup nvimrc
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
augroup End

" General Settings

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
syntax on		" syntax highlight
set background=dark
colorscheme ron

set hidden      " enable you to edit other buffer without saving current buffer
set mouse=

set showmatch		" Cursor shows matching ) and }
set copyindent		" copy the previous indentation on autoindenting
set noignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise

"cmd completion
set wildmenu            " wild char completion menu
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildignore=*.o,*.class,*.pyc "ignore these files while expanding wild chars

"Backup
set nobackup		" no *~ backup files
set noswapfile		" no .*swo file

"Fold
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"timeout
set timeoutlen=500

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


"" Key Mapping

" mode changing
nnoremap ; :
inoremap jk <Esc>
vnoremap <Cr> <Esc>
vnoremap <M-h> g0
vnoremap <M-l> g$
inoremap <C-a> <Esc><C-w>

" moving around
nnoremap <M-h> g0
nnoremap <M-l> g$
nnoremap <C-h> <Esc>:tabp<CR> 
nnoremap <C-l> <Esc>:tabn<CR> 
nnoremap j gj
nnoremap k gk
nnoremap <C-a> <C-w>
nnoremap <M-t> :tabe<CR>:tabmove 0<CR>:terminal zsh<CR>
nnoremap <leader>t :terminal zsh<CR>

inoremap <C-j> <Esc>gji
inoremap <C-k> <Esc>gki
inoremap <C-h> <Esc>hi
inoremap <C-l> <Esc>li


onoremap <M-h> g0
onoremap <M-l> g$

cnoremap jk <Esc>

tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <C-l> <Right>
tnoremap <M-h> <Home>
tnoremap <M-l> <End>
tnoremap <C-p> <Up>
tnoremap <C-n> <Down>

"map <leader>cc :botright cope<CR> 	" open the error console
map to	:copen<Cr>
map tc	:cclose<Cr>
map tn :cn<CR>						" move to next error
map tp :cp<CR>						" move to the prev error
map tj <C-w>w
map tk <C-w>w


"toggles paste mode
noremap <leader>p :set invpaste<CR>
set pastetoggle=<leader>p

augroup tex
    autocmd!
    autocmd FileType tex set spelllang=en_us
    autocmd FileType tex set spell
    autocmd FileType tex vmap j gj
    autocmd FileType tex vmap k gk
augroup End

"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

"Ctrlp
let g:ctrlp_map = '<c-o>'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
let g:ctrlp_root_markers = ['.git']
"let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:10'
"let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_tabpage_position = 'a'
"let g:ctrlp_working_path_mode = 'r'
"let g:ctrlp_use_caching = 1
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
"let g:ctrlp_show_hidden = 1
"let g:ctrlp_open_new_file = 't'
"let g:ctrlp_default_input = 1
"let g:ctrlp_lazy_update = 0
"let g:ctrlp_prompt_mappings = { 
"    \ 'AcceptSelection("e")': ['<c-a>,<2-LeftMouse>'],
"	\'AcceptSelection("t")': ['<cr>'], }

cnoreabbrev cpq CtrlPQuickfix
cnoreabbrev cpt CtrlPTag
cnoreabbrev cpb CtrlPBookmarkDir


" --- vim-latex
set grepprg=grep\ -nH\ $*
"let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
"let g:Tex_CompileRule_ps = 'dvips -Ppdf -o $*.ps $*.dvi'
"let g:Tex_CompileRule_pdf = 'ps2pdf $*.ps'


let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
let g:Tex_UseMakefile=0
let g:Tex_ViewRule_pdf = 'qpdfview'
let g:Tex_Menus=0
let g:Tex_FoldedCommands='ctable'

" zg to add word to word list
" zw to reverse
" zug to remove word from word list
" z= to get llist of probabilities
highlight clear SpellBad
highlight Spellbad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight Spellcap term=underline cterm=underline
highlight clear SpareRare
highlight SpellLocale term=underline cterm=underline
highlight clear SpareLocale
highlight SpellLocale term=underline cterm=underline
highlight Pmenu term=standout  ctermfg=255  ctermbg=8
highlight PmenuSel term=standout  ctermfg=255  ctermbg=3

let g:ConqueTerm_FastMode = 0
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_Color = 2


" EasyGrep
let g:EasyGrepInvertWholeWord = 1
let g:EasyGrepMode = 2
let g:EasyGrepReplaceWindowMode = 2

" Surround
nmap <leader>0 ysiw)
nmap <leader>] csiw]
