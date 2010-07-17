" PHPDocumentor setup
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 

" PHP-specific highlighting.

" Automagically folds functions & methods
autocmd FileType php let php_folding=1

" PHP Debugging
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

" Allow PHP-Folding
let php_folding = 1

" Maps CTRL+a to re-aligning an array or several assignments
" Make sure that you're in visual mode!
vnoremap <buffer> <C-a> :call PhpAlign()<CR>
