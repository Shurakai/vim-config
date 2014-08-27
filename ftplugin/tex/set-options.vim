set spell " See :h spell for more details. z= gives a neat suggestion list!

" Don't complete filenames with these extensions.
set wildignore+=*.ics,*.aux,*.blg,*.bst,*.dvi,*.idx,*.ilg,*.ind,*.ist,*.lof,*.log,*.lot,*.nlo,*.nls,*.out,*.pdf,*.sty,*.toc

let NERDTreeIgnore=['\.ics','\.aux$','\.bbl','\.blg','\.bst','\.dvi','\.idx','\.ilg','\.ind','\.ist','\.latexmain','\.lof','\.log','\.lot','\.nlo','\.nls','\.out','\.pdf','\.sty','\.toc']

if !exists("g:loaded_filetype_latex_plugin_settings")
    :NERDTreeFocus
    :exec "normal ". NERDTreeMapRefreshRoot
    :wincmd p " Move to last accessed window, i.e. the window that was just opened
endif
let g:loaded_filetype_latex_plugin_settings = 1
