" System settings {{{1
" no compliance mode - gives us the full feature set of vim
" Must be at top, because other options will be changed as a
" side effect as well.
set confirm         " displays a dialog when :q, :w etc. fail
set nocompatible
set hidden          " Hidden buffers
set history=200     " Keeps more info in history. Default is 20.
set lazyredraw      " Deactivates execution of macros and thus speeds up the execution!
set showmode        " Show which mode we're in
set visualbell      " Turnoff beeping
set wildmode=list:longest,full
set wildmenu        " improves the menu when pressing "tab" in the command line
set wildignore+=*~,*.o,*.class,*.git,*.svn,*.old,*.bak  " Ignore backup files.
set wildignorecase  " Ignores capitalization

"
" Don't write the backupfiles everywhere,
" but put them into the ~/.vim/backup/ directory
" Create folders in ~/.vim/ {{{2
let undodir   = expand('~/.vim/undo/')
let backupdir = expand('~/.vim/backup/')
let swapdir   = expand('~/.vim/swap/')
let viewdir   = expand('~/.vim/view/')
if !isdirectory(undodir)
  call mkdir(undodir)
endif
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif
if !isdirectory(swapdir)
  call mkdir(swapdir)
endif
if !isdirectory(viewdir)
  call mkdir(viewdir)
endif
" }}}2

set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//
set viewdir=$HOME/.vim/view//
set noundofile " Disabled undofiles; if you like this, uncomment!

" Set the mapleader to , - we define this here because it will have effect on every occurrence of <Leader>
let mapleader = ','

" Search in parent directories for tag files. This is necessary as
" the pwd will change to the currently used buffer.
" Note the trailing semicolon (;) - this is what tells vim to go up to root!
set tags=./tags,./ctags,ctags,tags;

if has("autocmd")
    autocmd BufEnter * :lcd %:p:h " Set vim directory to dir that contains file

    "autocmd bufwritepost .vimrc source $MYVIMRC " Auto-reload vimrc on save
    " Seriously, we don't like trailing whitespaces, so we remove them just before the file gets written
    autocmd BufWritePre * :%s/\s\+$//e
endif

" Appearance {{{1
" The default colorscheme is the wombat colorscheme, but if we're running VIM inside a terminal,
" we need to make sure that we're using the 256 colors version
if !has("gui_running")
    " Set vim to 256 colors
    set t_Co=256
    colorscheme wombat256-custom
else
    " Disable menus and toolbar
    set guioptions-=t
    set guioptions-=T
    set guioptions-=m
    set guioptions+=M

    " Set colorscheme
    colorscheme wombat
endif

set relativenumber " Relative numbers
set number         " display line numbers
set ruler          " Line & column number
set laststatus=2   " Modifies the ruler. Looks nicer this way.
set cursorline     " Highlights current cursorline with a different bg
set showcmd        " shows partial commands can be found next to the ruler
" Start scrolling the window when we're 8 lines away from the border of the
" current window or 7 lines away from the side
set scrolloff    =8
set sidescrolloff=7

" Set command-line window height (invoke with q: (or : in this vimrc))
set cmdwinheight=3

" Set the status line. Includes information about the current file,
" linenumber, column number, the buffernumber of the file
set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]

" Editing & Spelling {{{1
set formatoptions-=o " While commenting, new lines (o/O) will not be commented

set expandtab        " Uses spaces instead of tabs
set tabstop=4        " Insert 4 spaces for one tab
set softtabstop=4    " Backspace can delete indent

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
set shiftwidth=2
set backspace=start,indent,eol " Allows us to use backspace on (nearly) everything

set virtualedit=block " Allows virtual block mode to select empty locations.
set gdefault  " Assumes the /g modifier is set by default. This means that ALL found matches will be replaced
set wrap      " Set wrap

set pastetoggle=<F12> " Press F8 while in insert mode will toggle paste modes

let &showbreak = '»»» ' " Equivalent to "set showbreak", but the trailing
                        " space is required.

set diffopt+=iwhite     " Ignore changes in whitespace in diffs

" smart indent when entering insert mode with i on empty lines
" http://mbuffett.com/?p=14
function! SmarterIndentation(key)
    if len(getline('.')) == 0
        return "\"_ddO"
    else
        return a:key
    endif
endfunction
nnoremap <expr> i SmarterIndentation("i")
nnoremap <expr> a SmarterIndentation("a")

" Smart indent in visualmode
" This is just a lazy hack; you could use k> to
" indent k times...
vnoremap < <gv
vnoremap > >gv

" Add the git repository branch we're currently working in. This option makes
" use of the fugitive plugin by Tim Pope
"set statusline +=\ \ \ %{fugitive#statusline()}

" Spelling {{{2
"
" You may see an error that reads "Word characters differ between spell
" files." In that case, delete all files in /usr/share/vim/vim73/spell/
" that end on *.spl. I just deleted all english files - vim will then
" prompt you to download again, which is fine. This is due to some updates
" to the files. See the DevList:
" https://groups.google.com/d/topic/vim_dev/7HTs6kIKnPQ/discussion
set spelllang=en_us,de_20 "de_20 is "only new spelling" for German. I'm German.
set nospell               "Spelling will be turned on based on filetypes

" Search {{{1
set wrapscan   " Search from the beginning if EOF is hit
set incsearch  " Starts searching as soon as you start typing
set hlsearch   " Highlights search results
set ignorecase " Use case insensitive search...
set nosmartcase  " ... except when there are capital letters contained in the search string
                 " ... I actually disabled it because it confused me :)

set showmatch  " Show briefly matching brackets. Type a char to jump back!

" Folds {{{1
" These commands open folds
"set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo
set foldmethod=marker
"set foldmethod=indent       " Folds will be calculated on indentation
"set foldnestmax=3           " Don't fold deeper than 3 levels

" We want to have the default completion features including the syntax
" completion (k)
set complete=.,w,b,u,t,i,k

" Shows a marker if the line is longer than 80 columns
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" This shows special characters for trailing whitespaces and tabs.
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Mappings {{{1
" Basic mappings (movements etc.) {{{2
" It seems much more natural for me to move to the next actual word.
" However, in the future, this might be set depending on filetypes.
nnoremap w W
nnoremap W w
nnoremap b B
nnoremap B b

" Mappings for hlsearch {{{2

" Mappings for editing {{{2
nnoremap Q gqip " Formats the current paragraph
nnoremap S i<CR><ESC><left> " Splits lines. Opposite of J

" Transpose current word with next word (tn) or with previous word (tp)
" This version will work across newlines:
nnoremap <silent> <leader>tn "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
nnoremap <silent> <leader>tp "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>

" Swap current word with the next, but make cursor stay on current position
nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>


" Maps ' to ` and the other way round, since I think it's nicer to jump
" to the precise location of a marker rather than just the line that contains
" it.
noremap ' `
noremap ` '
" Maps shortcuts for sessions. We want to save and load sessions easily,
" because they're very helpful with quickly re-initializing projects.
map <Home> :source ~/.vim/mysessions/
map <End> :wa<Bar>exec ":mksession! " v:this_session <CR>

" After doing a search with hlsearch turned on, all results are still being
" highlighted. Thats really messy, so we want to disable it quickly.
nnoremap <silent> <C-H> :nohls<CR>
"inoremap <silent> <C-H> :nohls<CR>

" This prevents 'x' from overwriting the register that we can use for pasting.
" "_ selects the register that does not store anything, (named '_').
" See
" http://stackoverflow.com/questions/1497958/how-to-use-vim-registers/7019060#7019060
nnoremap x "_x
xnoremap x "_x

" Mappings for vim {{{2
inoremap jj <ESC><Right>" Quit insert mode quickly!
cnoremap jj <C-C>" Quit command mode quickly!
" Map : to q: to use the command-line window by default
nnoremap : q:i
nnoremap q: :

" Load vimrc in new tab with <Leader>-v
noremap <leader>ve :tabedit $MYVIMRC<CR>
" 'sudo' save
cmap w!! w !sudo tee % > /dev/null

" Window mappings {{{2
" This section is used for window navigation. I didn't write it myself but
" took it from
" http://www.derekwyatt.org/vim/the-vimrc-file/walking-around-your-windows/ :)

" Move the cursor to the window left of the current one
noremap <silent> <leader>h :wincmd h<cr>

" Move the cursor to the window below the current one
noremap <silent> <leader>j :wincmd j<cr>

" Move the cursor to the window above the current one
noremap <silent> <leader>k :wincmd k<cr>

" Move the cursor to the window right of the current one
noremap <silent> <leader>l :wincmd l<cr>

" Close the window below this one
noremap <silent> <leader>cj :wincmd j<cr>:close<cr>

" Close the window above this one
noremap <silent> <leader>ck :wincmd k<cr>:close<cr>

" Close the window to the left of this one
noremap <silent> <leader>ch :wincmd h<cr>:close<cr>

" Close the window to the right of this one
noremap <silent> <leader>cl :wincmd l<cr>:close<cr>

" Close the current window
noremap <silent> <leader>cc :close<cr>

" Move the current window to the right of the main Vim window
noremap <silent> <leader>ml <C-W>L

" Move the current window to the top of the main Vim window
noremap <silent> <leader>mk <C-W>K

" Move the current window to the left of the main Vim window
noremap <silent> <leader>mh <C-W>H

" Move the current window to the bottom of the main Vim window
noremap <silent> <leader>mj <C-W>J

" Cycle between buffers easily
noremap <silent> <leader>bn :bn<cr>
noremap <silent> <leader>bp :bp<cr>

"Delete current buffer
noremap <silent> <leader>bd :bd<cr>

" vim-plug Configuration {{{1
" Activates filetype plugins. This is necessary e.g. for a proper
" PHP-Integration to work correctly. Also required by lots of plugins
filetype off

call plug#begin('~/.vim/bundle')

Plug 'valloric/YouCompleteMe', { 'do': './install.sh' }

" NerdTree is really useful and absolutely needed
"Plug 'scrooloose/nerdtree.git', { 'on':  'NERDTreeToggle' }

" The VIM Latex-Suite plugin is very useful - the version
" I use here is NOT the original version, though.
Plug 'gerw/vim-latex-suite', { 'for': 'latex' }

Plug 'vim-scripts/Align'

Plug 'scrooloose/nerdcommenter'

Plug 'drmingdrmer/xptemplate-dist'

Plug 'bingaman/vim-sparkup', { 'for': 'html' }

Plug 'tpope/vim-surround'

Plug 'tpope/vim-repeat'

" This is an awesome plugin that allows you to easily jump to any
" location. Make sure you read the documentation at
" https://github.com/Lokaltog/vim-easymotion
"
" Default binding: <Leader><Leader>s ("search"), but you can use
" f (search-forward) or F, w etc. as well! (Even multi-letter
" bindings are possible, see docs)
Plug 'Lokaltog/vim-easymotion'

" This is a syntax checker. For supported languages
" and which binaries are expected for syntastic to work,
" visit https://github.com/scrooloose/syntastic
Plug 'scrooloose/syntastic'

" Use % to go to next match, for instance on HTML tags or to jump
" to the next else if ...
" Use g% to go back up.
Plug 'vim-scripts/matchit.zip'

" Provides a thesaurus.
" Standard binding: <leader>K
" Can be changed by binding :OnlineThesaurusCurrentWord
Plug 'beloglazov/vim-online-thesaurus'

" Provides graphical undo trees.
" To read more about vims (non-graphical) undo trees,
" see :h undo-redo
Plug 'https://github.com/sjl/gundo.vim'

Plug 'wincent/command-t'

Plug 'jceb/vim-orgmode', { 'for': 'org'}

" If you set a mark, this plugin will visualise
" where that mark is.
Plug 'kshenoy/vim-signature'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

call plug#end()

""filetype indent on " Indent, but be aware of the language we're currently working in
filetype plugin indent on

" Dragvisuals Plugin {{{2
" This is the dragvisuals plugin from Damian Conway, presented at OSCON 2013
" http://youtu.be/aHm36-na4-4
" I did not find any 'official' repository, so I'm sourcing it manually.
" The plugin allows to select a virtual block (or lines) and move them around
" using the arrow keys.
runtime plugin/dragvisuals.vim


" Plugin Mappings and Settings {{{1
" NERDTree {{{2
"map <C-n> :NERDTreeToggle<CR>
"let NERDTreeShowBookmarks = 1 " We really want to see bookmarks in NERDTree!

" CommandT {{{2
map <C-n> :CommandT<CR>
nnoremap gb :CommandTBuffer<CR>

" Sparkup {{{2
let g:sparkupNextMapping = '<c-y>' " Sparkup must be remapped (defaults to CTRL+n)

" ArgumentRewrap {{{2
nnoremap <silent> <leader>r :call argumentrewrap#RewrapArguments()<CR>

" XPTemplates {{{2
" Configure XPTemplates
" Disable spaces between brackets. Results in () instead of (  ).
" See http://code.google.com/p/xptemplate/wiki/FAQ#Do_NOT_like_spaces_in_auto-completed_brackets/braces
let g:xptemplate_vars = "SParg="
let g:xptemplate_vars = g:xptemplate_vars . "&$author=Christian Heinrich"
let g:xptemplate_vars = g:xptemplate_vars . "&$email=christian.heinrich@livando.com"

" Configuration for the indexer plugin.
" This plugin indexes files automatically with ctags.
"let g:indexer_indexerListFilename = $HOME.'/.vim/personal/.indexer_files'
"let g:indexer_tagsDirname         = $HOME.'/.vim/tags'

" Taglist {{{2
" Configuration for the taglist plugin
let Tlist_Use_Right_Window = 1           " Moves window to the right
let Tlist_Exit_OnlyWindow = 1            " Closes window when the file edited gets closed
let Tlist_GainFocus_On_ToggleOpen = 1    " Set focus to the taglist window when its opened
let Tlist_File_Fold_Auto_Close = 1
nmap <C-l> :TlistToggle<CR>              " Map the TlistToggle Command to CTRL+l

" YouCompleteMe {{{2
let g:ycm_collect_identifiers_from_tags_files       = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_extra_conf_globlist = ['~/workspace/*','!~/*']
" Dragvisuals Plugin {{{2
vmap  <expr>  <LEFT>   DVB_Drag('left')
vmap  <expr>  <RIGHT>  DVB_Drag('right')
vmap  <expr>  <DOWN>   DVB_Drag('down')
vmap  <expr>  <UP>     DVB_Drag('up')
vmap  <expr>  D        DVB_Duplicate()

" Remove any introduced trailing whitespace after moving...
let g:DVB_TrimWS = 1

" org-mode {{{2
let g:org_export_emacs="/usr/local/bin/emacs"
let g:org_export_init_script="~/.emacs.d/init.el"

" Filetype Settings {{{1
" Never open files with ft=plaintex (= vanilla TeX), but LaTeX!
let g:tex_flavor = "latex"

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

let localleader="\\"
