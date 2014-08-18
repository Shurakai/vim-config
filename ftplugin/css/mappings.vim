" This mapping sorts the css lines within a {} block. Thanks to sjl from #vim!
map <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

function SortCss()
   for i in range(line("1"), line("$"))
       exe "/{"
       " TODO , = <leader> should be replaced...
       exe "silent! normal j,S"
   endfor
endfunction

command SortFile call SortCss()
