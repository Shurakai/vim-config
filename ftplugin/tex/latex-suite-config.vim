" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
" http://stackoverflow.com/questions/21648238/vim-youcompleteme-enable-tex-filetype
let g:tex_flavor='latex'

" I don't use dvi because hyperrefs are not clickable in dvi!
"let g:Tex_DefaultTargetFormat='pdf'
"let g:Tex_ViewRule_pdf='evince '
"let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
"let g:mfname = 'main.tex'
"execute "TTarget pdf"

" Recompile on every write. This is nice as
" for example "evince" as a PDF reader updates
" as soon as the .pdf file changes. This means
" that you can see your changes immediately!
"
" If you have a latex project with multiple files
" in it, you can make Latex Suite build your project
" by adding a new file main.tex.latexmain, if main.tex
" is your main file. (You can also use a makefile, check docs for that)
"au BufWritePost *.tex silent call Tex_CompileLatex()
