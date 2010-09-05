" This file configures several PHP properties and delivers some pretty cool functionality, like the PhpAlign() function
" Some of this stuff has originally been taken from Tobias Schlitt

if exists("loaded_php_vim_integration")
    finish
endif
let loaded_php_vim_integration = 1

" These configurations are supposed to match the php.vim syntax file
" which can be found in ~/.vim/syntax/php.vim
let php_sql_query         = 1 " highlight sql in strings?
let php_htmlInStrings     = 1 " highlight html in strings?
let php_noShortTags       = 1 " Do not identify <? ?> as PHP
let php_folding           = 1 " Enable folding?
let php_sync_method       = -1 " -1 mean sync by search

let PHP_autoformatcomment = 1

" We want VIM to remember for each file where our cursor had been when we left the buffer
"Automatically save view information about
" each file that is edited and restore the
" settings (persists between VIM invocations.)
au BufWinLeave *.php,*.phtml mkview
au BufWinEnter *.php,*.phtml silent loadview


" Correct indentation after opening a phpdocblock and automatic * on every
" line
setlocal formatoptions=qroct

nnoremap <silent> <plug>PIVphpDocSingle :call PhpDocSingle()<CR>
vnoremap <silent> <plug>PIVphpDocRange :call PhpDocRange()<CR>
vnoremap <silent> <plug>PIVphpAlign :call PhpAlign()<CR>
"inoremap <buffer> <leader>d :call PhpDocSingle()<CR>i

" Map ; to "add ; to the end of the line, when missing"
noremap <silent> ; :s/\([^;]\)$/\1;/<cr>:nohlsearch<cr>

" Map ,pa to align variables
map ,pa <plug>PIVphpAlign <cr>

" Map <CTRL>-H to search phpm for the function name currently under the cursor (insert mode only)
inoremap <buffer> <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" {{{ Alignment
" Allows to align variables correctly.
" This function has been taken from Tobias Schlitt's original PDV

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		" Skip comment lines
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
		" \{-\} matches ungreed *
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\S\{0,1}=\S\{0,1\}\s*.*$', '\1', "")
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile

	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"

	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s*\(.*\)$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s*\(.*\)$', '\2', "")
        let l:linevalue = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*\(\S\{0,1}=\S\{0,1\}\)\s*\(.*\)$', '\3', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc

" }}}
