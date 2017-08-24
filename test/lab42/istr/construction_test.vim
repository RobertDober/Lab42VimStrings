function! TestConstruct()
  let l:str = lab42#istr#new('alpha', 3)
  call lab42#test#assert_eq('al', l:str.pre())
  call lab42#test#assert_eq('ha', l:str.post())
  call lab42#test#assert_eq('p', l:str.char())
  call lab42#test#assert_eq(3, l:str.col())
  call lab42#test#assert_eq('alpha', l:str.text())
  let l:str = lab42#istr#new('alpha', [0, 0, 5, 0])
  call lab42#test#assert_eq('alph', l:str.pre())
  call lab42#test#assert_eq('', l:str.post())
  call lab42#test#assert_eq('a', l:str.char())
  call lab42#test#assert_eq(5, l:str.col())
  call lab42#test#assert_eq('alpha', l:str.text())
endfunction

" function! TestWord()
"   "                          0....+....|....+.
"   let l:str = lab42#istr#new('alpha beta gamma', 3)
"   call lab42#test#assert_eq('alpha', l:str.word())

"   "                          0....+....|....+.
"   let l:str = lab42#istr#new('alpha beta gamma', 9)
"   call lab42#test#assert_eq('beta', l:str.word())

"   "                          0....+....|....+.
"   let l:str = lab42#istr#new('alpha beta gamma', 11)
"   call lab42#test#assert_eq(' ', l:str.word())

"   "                          0....+....|....+.
"   let l:str = lab42#istr#new('alpha beta gamma', 16)
"   call lab42#test#assert_eq('gamma', l:str.word())

"   "                          0....+....|....+.
"   let l:str = lab42#istr#new('alpha beta gamma', 17)
"   call lab42#test#assert_eq('', l:str.word())
  
" endfunction