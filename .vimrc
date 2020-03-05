set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-voom/V0oM'

Plugin 'w0rp/ale' " autocompletion and live linting  https://github.com/w0rp/ale

Plugin 'vim-scripts/indentpython.vim' 

Plugin 'fisadev/vim-isort' " sort python imports https://github.com/fisadev/vim-isort#installation

Plugin 'Yggdroot/indentLine' " show identation https://github.com/Yggdroot/indentLine
" All of your Plugins must be added before the following line
call vundle#end()            " required
colorscheme desert
syntax on
filetype plugin indent on    " required

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

let g:vim_isort_map = '<C-i>'
set nu
set showmatch
set ff=unix

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.gdb set filetype=gdb

" Enable spellchecking for Markdown
autocmd FileType markdown setlocal spell

" Write the old file out when switching between files.
set autowrite

set clipboard=unnamed " yank and paste with the system clipboard

filetype indent plugin on
set dictionary=/usr/share/dict/words

set ffs=unix,dos,mac " Use Unix as the standard file type

set ruler " Always show current position
set backspace=indent,eol,start " Allow backspace in insert mode
set whichwrap+=<,>,h,l

let html_use_css=1 " Use css for generated html files

" Autocomplete me when opening a file:
set wildmode=longest,list

" Comments {{{

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,javascript      let b:comment_leader = '// '
autocmd FileType sh,ruby,python,make              let b:comment_leader = '# '
autocmd FileType conf,fstab,sysctl                let b:comment_leader = '# '
autocmd FileType tex                              let b:comment_leader = '% '
autocmd FileType mail                             let b:comment_leader = '> '
autocmd FileType vim                              let b:comment_leader = '" '
noremap <F7> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <F8> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Set bracket matching and comment formats
set matchpairs+=<:>
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*
set comments+=b:\"
set comments+=n::

" }}}

" Encoding {{{

set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8
set langmap+=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ
set langmap+=αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz
set spell spelllang=en
set nospell

" }}}

" Folding {{{

set foldmethod=indent   " Fold based on indent level
set foldnestmax=10      " Max 10 depth
set foldenable          " Don't fold files by default on open
set foldlevelstart=10 " Start with fold level of 1

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd Syntax c,cpp,xml,html,xhtml setlocal foldmethod=syntax
augroup END

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" }}}

" Backups/Undo/Dirs {{{

" Keep backup of edited files
set backup
set writebackup

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
    silent !mkdir -p ~/.cache/vim_backups > /dev/null 2>&1
    set undodir=~/.cache/vim_backups
    set undofile
endif

set backupdir=~/.cache/vim_backups/

silent !mkdir -p ~/.cache/vim_backups/view/ > /dev/null 2>&1
set viewdir=~/.cache/vim_backups/view/
silent !mkdir -p ~/.cache/vim_backups/swap/ > /dev/null 2>&1
set directory=~/.cache/vim_backups/swap/


" Searching {{{

set ignorecase " Ignore case when searching
set gdefault " Add the g flag to search/replace by default
set smartcase " When searching try to be smart about cases
set hlsearch " Highlight search results
set incsearch " Makes search act like search in modern browsers
set showmatch " Show matching brackets when text indicator is over them
set mat=4 " How many tenths of a second to blink when matching brackets

" }}}


" Text, tab and indent related {{{

set expandtab " Use spaces instead of tabs
set smarttab
set copyindent
set softtabstop=4

set shiftwidth=4 " 1 tab == 4 spaces
set tabstop=4
set textwidth=120 " Maximum width of inserted text
set whichwrap=    " Wrap cursor to next/prev line. not!
set formatoptions=qrnl
set nostartofline " Don’t reset cursor to start of line when moving around.

set nowrap " Don't wrap lines
set linebreak " Wrap lines at convenient points

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set autoindent " Auto indent
set smartindent " Smart indent
set wrap " Wrap lines

" }}}

" Colorscheme selection and syntax highlighting {{{

syntax on

set synmaxcol=1000
set popt+=syntax:y
set cursorline
set t_Co=16
set t_ut= " Disable background color erase
let base16colorspace="256"


" Change Color when entering Insert Mode
autocmd InsertEnter * hi Cursor guibg=#5fd7ff ctermbg=81
" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * hi Cursor guibg=#CAE682 ctermbg=192


" }}}


" Statusline {{{

function! BufCount()
    if !exists("s:line_n_buffers")
        let s:line_n_buffers = len(filter(range(1,bufnr('$')), 'buflisted(v:val)'))
    endif
    return s:line_n_buffers
endfunction

augroup nbuf
    autocmd!
    autocmd BufAdd,BufDelete * unlet! s:line_n_buffers
augroup END

" pretty mode display - converts the one letter status notifiers to words
function! OpMode()
    let l:mode = mode()

    if     mode ==# "n"           | exec 'hi User8 guifg=#141413 guibg=#CAE682 ctermfg=232 ctermbg=192' | let s:opmode = "NORMAL" | return s:opmode
    elseif mode ==# "i" && &paste | exec 'hi User8 guifg=#141413 guibg=#5fffff ctermfg=232 ctermbg=87'  | let s:opmode = "INSERT[paste]" | return s:opmode
    elseif mode ==# "i"           | exec 'hi User8 guifg=#141413 guibg=#5fd7ff ctermfg=232 ctermbg=81'  | let s:opmode = "INSERT" | return s:opmode
    elseif mode ==# "R"           | exec 'hi User8 guifg=#141413 guibg=#d75f00 ctermfg=232 ctermbg=166' | let s:opmode = "REPLACE" | return s:opmode
    elseif mode ==# "v" || mode ==# "V" || mode ==# "^V" | exec 'hi User8 guifg=#141413 guibg=#5faf5f ctermfg=232 ctermbg=71'  | let s:opmode = "VISUAL" | return s:opmode
    elseif mode ==# "s" || mode ==# "S" || mode ==# "^S" | exec 'hi User8 guifg=#141413 guibg=#8787ff ctermfg=232 ctermbg=105'  | let s:opmode = "SELECT" | return s:opmode
    elseif mode ==# "c"           | exec 'hi User8 guifg=#d7ffd7 guibg=#3a3a3a ctermfg=194 ctermbg=237' | let s:opmode = "COMMAND" | return s:opmode
    elseif mode ==# "t"           | exec 'hi User8 guifg=#87afff guibg=#3a3a3a ctermfg=111 ctermbg=237' | let s:opmode = "TERMINAL" | return s:opmode
    else                          | exec 'hi User8 guifg=#141413 guibg=#CAE682 ctermfg=232 ctermbg=192' | let s:opmode = mode | return s:opmode
    endif
endfunc

" set mode once on startup
call OpMode()
" each time the mode changes unset variable so that OpMode() re-runs
au InsertEnter * unlet! s:opmode
au InsertChange * unlet! s:opmode
au InsertLeave * unlet! s:opmode

set laststatus=2
set noshowmode  " mode is handled by statusline so don't show it twice

" Colors
hi User1 guifg=#141413 guibg=#CAE682 ctermfg=232 ctermbg=192                      " yellow bg
hi User2 guifg=#141413 guibg=#5fd787 ctermfg=232 ctermbg=78                       " green bg
hi User3 guifg=#141413 guibg=#E5786D ctermfg=232 ctermbg=173                      " red bg
hi User4 guifg=#141413 guibg=#5fd7d7 ctermfg=232 ctermbg=80                       " blue bg
hi User5 guifg=#141413 guibg=#5f87d7 ctermfg=232 ctermbg=68                       " dark blue bg
hi User6 guifg=#CAE682 guibg=#32322F ctermfg=192 ctermbg=236 cterm=bold term=bold " dark bg, bold yellow fb
hi User7 guifg=#32322F guibg=#32322F ctermfg=236 ctermbg=236                      " dark bg and fg (for separator)

hi User8 guifg=#141413 guibg=#CAE682 ctermfg=232 ctermbg=192                      " yellow for normal mode

" Formatting and alignment for each item is of the form %-0{minwidth}.{maxwidth}{item}
" where - is left alignment, none is right and 0 padds numeric elements with zeros.
" Also the space character has to be escaped with \

set statusline=%8*\ %-5{exists('s:opmode')?s:opmode:OpMode()}\         " Operation mode (normal, insert etc)
set statusline+=%7*\|                                                              " |
set statusline+=%1*\ [%-.2n/%{BufCount()}]\                                        " Number of current buffer / total number of buffers
set statusline+=%7*\|                                                              " |
set statusline+=%2*\ %-2.20F\                                                      " Complete filename

set statusline+=%*%3*%m                                                            " Modified flag
set statusline+=%r                                                                 " Read only flag
set statusline+=%h                                                                 " Help file flag
set statusline+=%w                                                                 " Preview window flag
set statusline+=%7*\|                                                              " |
set statusline+=%4*\ %{strlen(&fenc)?&fenc:'none'},\ %{&ff}\                       " File, character encoding (e.g. [utf-8, unix])
set statusline+=%7*\|                                                              " |
set statusline+=%5*\ %y\                                                           " Filetype

set statusline+=%6*%=                                                              " Switch to the right side

set statusline+=%7*\|                                                              " |
set statusline+=%6*\ %{synIDattr(synID(line('.'),col('.'),1),'name')}\             " Highlight code under cursor
set statusline+=%7*\|                                                              " |
set statusline+=%5*\ A:%-3.3b\                                                     " Ascii of character under cursor
set statusline+=H:0x%-2.2B\                                                        " Hex of character under cursor
set statusline+=%7*\|                                                              " |
set statusline+=%4*\ %{FileSize()}\                                                " Show size of file
set statusline+=%7*\|                                                              " |
set statusline+=%2*\ %3l/%3L,\ %-3v\                                               " Show currentline/total lines, column
set statusline+=%7*\|                                                              " |
set statusline+=%1*\ %3p%%\ \                                                      " Show percentage in file

" }}}

" Persistent Undo {{{

" }}}




" Ask for sudo password when editing a read-only file
cmap w!! %!sudo tee > /dev/null %


function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "K"
    endif
endfunction


" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
