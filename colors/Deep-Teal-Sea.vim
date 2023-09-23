" Vim color file
"
" Color Scheme: Deep-Teal-Sea
"
hi clear
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
set background=dark
hi Normal       guifg=Deep-Teal-Sea-5 guibg=Deep-Teal-Sea-10
hi Comment      guifg=Deep-Teal-Sea-1
hi Constant     guifg=Deep-Teal-Sea-7
hi Identifier   guifg=Deep-Teal-Sea-4
hi Statement    guifg=Deep-Teal-Sea-6
hi PreProc      guifg=Deep-Teal-Sea-8
hi Type         guifg=Deep-Teal-Sea-9
hi Special      guifg=Deep-Teal-Sea-3
hi Underlined   guifg=Deep-Teal-Sea-2
hi Error        guifg=Deep-Teal-Sea-7 guibg=Deep-Teal-Sea-10
hi Todo         guifg=Deep-Teal-Sea-6 guibg=Deep-Teal-Sea-10