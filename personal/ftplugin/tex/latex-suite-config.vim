" Set PDF as the default output.
" I don't use dvi because hyperrefs are not clickable in dvi!
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince '
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
execute "TTarget pdf"

" Recompile on every write. This is nice as
" for example "evince" as a PDF reader updates
" as soon as the .pdf file changes. This means
" that you can see your changes immediately!
au BufWritePost *.tex silent call Tex_CompileLatex()
