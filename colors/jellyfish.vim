
" Nome do Tema: Jellyfish
" Descrição: Esquema de cores inspirado em águas-vivas.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "jellyfish"

" Cores Base
let s:color1 = "#F079F2" " Big-Jellyfish-in-aquarium-1
let s:color2 = "#A85FD9" " Big-Jellyfish-in-aquarium-2
let s:color3 = "#1F1040" " Big-Jellyfish-in-aquarium-3
let s:color4 = "#130A26" " Big-Jellyfish-in-aquarium-4
let s:color5 = "#42378C" " Big-Jellyfish-in-aquarium-5

" Cores Complementares
let s:black = "#000000"
let s:white = "#FFFFFF"
let s:gray = "#808080"
let s:lightGray = "#D3D3D3"

" Elementos de Sintaxe
hi Comment      guifg=s:gray     guibg=s:color3
hi Constant     guifg=s:color1   guibg=NONE
hi Identifier   guifg=s:color2   guibg=NONE
hi Statement    guifg=s:color5   guibg=NONE
hi PreProc      guifg=s:color1   guibg=NONE
hi Type         guifg=s:lightGray guibg=NONE
hi Special      guifg=s:color2   guibg=NONE
hi Underlined   guifg=s:color1   guibg=NONE
hi Error        guifg=s:white    guibg=s:black
hi Todo         guifg=s:black    guibg=s:color1

" Barra de Status
hi StatusLine   guifg=s:white    guibg=s:color4
hi StatusLineNC guifg=s:gray     guibg=s:color3

" Números de Linha
hi LineNr       guifg=s:gray     guibg=s:color3
hi CursorLineNr guifg=s:white    guibg=s:color3

" Fundo e Texto Padrão
hi Normal       guifg=s:white    guibg=s:color3
hi Cursor       guifg=s:black    guibg=s:white

" Destacar Seleção Visual
hi Visual       guifg=s:black    guibg=s:color1
