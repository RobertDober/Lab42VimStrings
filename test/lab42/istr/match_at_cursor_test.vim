function! TestMatchAtCol()
  
  let l:hashrocket = ':(\w+)\s+\=\>\s+(\w+)'
  "                          0....+....1....+.
  let l:str = lab42#istr#new(' :hello => world', 9)
  let l:match = l:str.match_at_cursor(l:hashrocket)

  call lab42#test#assert_eq(':hello => world', l:match.text())
  call lab42#test#assert_eq(2, l:match.start())
  call lab42#test#assert_eq(16, l:match.end())

  call lab42#test#assert_eq('hello', l:match.submatches(0).text())
  call lab42#test#assert_eq('hello', l:match.submatches()[0].text())
  call lab42#test#assert_eq(3, l:match.submatches(0).start())
  call lab42#test#assert_eq(7, l:match.submatches(0).end())

  call lab42#test#assert_eq(['world', 12, 16], l:match.submatches(1).text_and_positions() )
endfunction
