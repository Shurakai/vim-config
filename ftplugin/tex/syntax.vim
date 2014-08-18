" Contains some syntax help for vim.
"
" Spelling. These commands are specific to my tex thesis layout {{{1
syn region texZone start="\\citeauthor{" end="}" contains=@NoSpell
syn region texZone start="\\citenum{" end="}" contains=@NoSpell
syn region texZone start="\\mnote{" end="}" contains=@NoSpell
