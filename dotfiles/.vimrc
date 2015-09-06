" vundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
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
Bundle 'vim-scripts/AutoComplPop'
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
"Bundle 'vim-scripts/LaTeX-Suite-aka-Vim-LaTeX'

" auto reload vimrc when editing it
augroup myvimrc
	au!
	au BufWritePost .nvimrc,.vimrc,so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" General Settings

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
syntax on		" syntax highlight

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set showcmd		"show command
set ruler		" show the cursor position all the time
set hidden      " enable you to edit other buffer without saving current buffer
set wildignore=*.swp,*.bak,*.pyc,*.class
set hlsearch		" search highlighting

set clipboard=unnamedplus	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set autoindent		" auto indentation
set copyindent		" copy the previous indentation on autoindenting
set noignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set noerrorbells "disable sound on errors
set novisualbell
set t_vb=
set tm=500

"cmd completion
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu
set wildignore=*.o,*.class,*.pyc "ignore these files while expanding wild chars

"Backup
set autoread		" auto read when file is changed from outside
set incsearch		" incremental search
set nobackup		" no *~ backup files
set noswapfile		" no .*swo file

"Fold
set foldmethod=indent
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"Diff
set diffopt+=vertical
cnoreabbrev dp diffput
autocmd BufWritePost * if &diff == 1 | diffupdate | endif

"Tab
set smarttab		" insert tabs on the start of a line according to context
set shiftwidth=4
set tabstop=4
set expandtab

"Appearance
colorscheme ron
set laststatus=2
set statusline=%{HasPaste()}%m%f\ /\ Dir:%{getcwd()} "left part
set statusline+=%=%c,%l/%L  "right part

"Encoding
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"" Key Mapping

" mode changing
nnoremap ; :
imap jk <Esc>
vmap <Cr> <Esc>
inoremap <C-a> <Esc><C-w>

" moving around
set winaltkeys=no
noremap h g0
noremap l g$
nnoremap j gj
nnoremap k gk
inoremap <C-j> <Esc>gji
inoremap <C-k> <Esc>gki
inoremap <C-h> <Esc>hi
inoremap <C-l> <Esc>li
nnoremap <C-h> <Esc>:tabp<CR> 
nnoremap <C-l> <Esc>:tabn<CR> 

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

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

"" Funcitions

" Show if paste mode is on
function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction


"" C/C++ specific settings
autocm FileType tex set spelllang=en_us
autocmd FileType tex set spell
autocmd FileType tex vmap j gj
autocmd FileType tex vmap k gk


"" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif

set cot-=preview "disable doc preview in omnicomplete


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
"let g:ctrlp_tabpage_position = 'ac'
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
