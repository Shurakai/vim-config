" no compliance mode - gives us the full feature set of vim
" Must be at top, because other options will be changed as a
" side effect as well.
set nocompatible

" Set the mapleader to , - we define this here because it will have effect on every occurrence of <Leader>
let mapleader = ','

" The default colorscheme is the wombat colorscheme, but if we're running VIM inside a terminal,
" we need to make sure that we're using the 256 colors version
if !has("gui_running")
    " Set vim to 256 colors
    set t_Co=256
    colorscheme wombat256-custom
else
    colorscheme wombat
endif

" display line numbers
set nu

" shows partial commands, i.e. commands that have not yet been executed
" via pressing the enter key. can be found next to the ruler
set showcmd

" Line & column number
set ruler

" Modifies the ruler. Looks nicer this way.
set laststatus=2

" Set the status line. Includes information about the current file,
" linenumber, column number, the buffernumber of the file
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" Add the git repository branch we're currently working in. This option makes
" use of the fugitive plugin by Tim Pope
set statusline +=\ \ \ %{fugitive#statusline()}

" Set the vim current directory to be the directory
" that the file in the current buffer is in.
autocmd BufEnter * :lcd %:p:h

" Insert 4 spaces for one tab
set tabstop=4

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
set shiftwidth=4

" Uses spaces instead of tabs
set expandtab

" Allows us to use backspace on (nearly) everything
set backspace=start,indent,eol

set incsearch " Starts searching as soon as you start typing
set hlsearch  " Highlights search results
set gdefault  " Assumes the /g modifier is set by default. This means that ALL found matches will be replaced

" When searching, we want to start again from the beginning of the file if EOF is hit. Default is true,
" but we still specify it here.
set wrapscan

set ignorecase " Use case insensitive search...
set smartcase  " ... except when there are capital letters contained in the search string

" improves the menu when pressing "tab" in the command line
set wildmenu
set wildignore=*~           " Ignore backup files.

" Keeps more info in history. Default is 20.
set history=1000

" While commenting, new lines will not be commented
set formatoptions-=o

" These commands open folds
"set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
"set foldmethod=indent       " Folds will be calculated on indentation
"set foldnestmax=3           " Don't fold deeper than 3 levels

" Start scrolling the window when we're 8 lines away from the border of the
" current window or 7 lines away from the side
set scrolloff    =8
set sidescrolloff=7

set lazyredraw " Deactivates the redrawing during execution of macros and thus speeds up the execution!"

" Activates filetype plugins. This is necessary e.g. for a proper
" PHP-Integration to work correctly. Also required by lots of plugins
filetype on
""filetype indent on " Indent, but be aware to the language we're currently working in
filetype plugin on

" Don't write the backupfiles everywhere, but put them into the ~/.vim/backup/ directory
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup

" Allows us to change buffers before they were saved. This is okay because VIM
" will force us to use something like :qa! to quit VIM if there is an unsaved
" buffer
set hidden

" Seriously, we don't like trailing whitespaces, so we remove them just before the file gets written
autocmd BufWritePre * :%s/\s\+$//e

"
" This section is used for window navigation. I didn't write it myself but
" took it from
" http://www.derekwyatt.org/vim/the-vimrc-file/walking-around-your-windows/ :)
"

" Move the cursor to the window left of the current one
noremap <silent> ,h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> ,j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> ,k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> ,l :wincmd l<cr>

" Close the window below this one
noremap <silent> ,cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> ,ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> ,ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> ,cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> ,cc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> ,ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> ,mk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> ,mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> ,mj <C-W>J

" Cycle between buffers easily
noremap <silent> ,bn <C-I>
noremap <silent> ,bp <C-O>

" AutoCompletion, depending on the filetype.
" Using the omnifunc (insertmode -> <CTRL>-X <CTRL>-O ) allows to auto-
" complete things like classnames, variables etc.
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Mappings
"
" Map <CTRL-n> to NerdTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks = 1 " We really want to see bookmarks in NERDTree!

" Sparkup must be remapped (defaults to CTRL+n)
let g:sparkupNextMapping = '<c-y>'

" Map the TlistToggle Command to CTRL+l
nmap <C-l> :TlistToggle<CR>

" Maps shortcuts for sessions. We want to save and load sessions easily,
" because they're very helpful with quickly re-initializing projects.
map <Home> :source ~/.vim/mysessions/
map <End> :wa<Bar>exec ":mksession! " v:this_session <CR>

" After doing a search with hlsearch turned on, all results are still being
" highlighted. Thats really messy, so we want to disable it quickly.
nnoremap <silent> <C-H> :nohls<CR><C-H>
inoremap <silent> <C-H> <C-0>:nohls<CR>

" Swap current word with next word (gw) or with previous word (gl)
" This version will work across newlines:
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Swap current word with the next, but make cursor stay on current position
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>

" Configure XPTemplates
" Disable spaces between brackets. Results in () instead of (  ).
" See http://code.google.com/p/xptemplate/wiki/FAQ#Do_NOT_like_spaces_in_auto-completed_brackets/braces
let g:xptemplate_vars = "SParg="
let g:xptemplate_vars = g:xptemplate_vars . "&$author=Christian Heinrich"
let g:xptemplate_vars = g:xptemplate_vars . "&$email=christian.heinrich@livando.com"

" Configuration for the indexer plugin.
" This plugin indexes files automatically with ctags.
let g:indexer_indexerListFilename = $HOME.'/.vim/personal/.indexer_files'
let g:indexer_tagsDirname         = $HOME.'/.vim/mytags'

" Configuration for the taglist plugin
let Tlist_Use_Right_Window = 1           " Moves window to the right
let Tlist_Exit_OnlyWindow = 1            " Closes window when the file edited gets closed
let Tlist_GainFocus_On_ToggleOpen = 1    " Set focus to the taglist window when its opened
let Tlist_File_Fold_Auto_Close = 1
