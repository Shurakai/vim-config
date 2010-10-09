" This mapping sorts the css lines within a {} block. Thanks to sjl from #vim!
map <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

function SortCss()
   exe "normal gg"
   exe "/\{<CR>"
   exe "normal ,S"
   exe "normal n"
endfunction
