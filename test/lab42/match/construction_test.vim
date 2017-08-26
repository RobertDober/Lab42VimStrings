function! TestMatchSimpleContruction()
  let l:match = lab42#match#new('hello', 6)
  
  call lab42#test#assert_eq('hello', l:match.text())
  call lab42#test#assert_eq(6, l:match.start())
  call lab42#test#assert_eq(10, l:match.end())

  call lab42#test#assert_eq([], l:match.submatches())
endfunction

function! TestMatchWithSubmatches()
  "                             |....+....|
  let l:match = lab42#match#new('alpha beta', 11, 'alpha', 11, 'beta', 17)

  call lab42#test#assert_eq('alpha beta', l:match.text())
  call lab42#test#assert_eq(11, l:match.start())
  call lab42#test#assert_eq(20, l:match.end())

  let l:sub1 = l:match.submatches(0)
  let l:sub2 = l:match.submatches(1)

  call lab42#test#assert_eq('alpha', l:sub1.text())
  call lab42#test#assert_eq('beta', l:sub2.text())

  call lab42#test#assert_eq(11, l:sub1.start())
  call lab42#test#assert_eq(17, l:sub2.start())

  call lab42#test#assert_eq(15, l:sub1.end())
  call lab42#test#assert_eq(20, l:sub2.end())

  call lab42#test#assert_eq([], l:sub1.submatches())
  call lab42#test#assert_eq([], l:sub2.submatches())
endfunction
