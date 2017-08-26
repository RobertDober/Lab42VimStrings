function! TestWord()
  "                          0....+....|....+.
  let l:str = lab42#istr#new('alpha beta gamma', 3)
  call lab42#test#assert_eq('alpha', l:str.word().text())

  "                          0....+....|....+.
  let l:str = lab42#istr#new('alpha beta gamma', 9)
  call lab42#test#assert_eq(['beta', 7, 10], l:str.word().text_and_positions())

  "                          0....+....|....+.
  let l:str = lab42#istr#new('alpha beta gamma', 11)
  call lab42#test#assert_eq(' ', l:str.word().text())

  "                          0....+....|....+.
  let l:str = lab42#istr#new('alpha beta gamma', 16)
  call lab42#test#assert_eq('gamma', l:str.word().text())

  "                          0....+....|....+.
  let l:str = lab42#istr#new('alpha beta gamma', 17)
  call lab42#test#assert_eq(0, l:str.word().ismatch())
  call lab42#test#assert_eq(['', 17, 16], l:str.word().text_and_positions())
endfunction
