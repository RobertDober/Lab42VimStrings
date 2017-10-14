function! TestMatchAt()
  "                              ....+....
  let l:match = lab42#match#match_at('barbapapa', 'a.*a', 5) 
  call lab42#test#assert_eq(['arbapapa', 2], l:match) 

  "                              ....+....
  let l:match = lab42#match#match_at('barbapapa', 'a(.*)a', 5) 
  call lab42#test#assert_eq(['arbapapa', 2, 'rbapap', 3], l:match) 

  "                              ....+....
  let l:match = lab42#match#match_at('barbapapa', '(.)a', 5) 
  call lab42#test#assert_eq(['ba', 4, 'b', 4], l:match) 

  "                                   ....+....
  let l:match = lab42#match#match_at('barbapapa', '(.)a', 5) 
  call lab42#test#assert_eq(['ba', 4, 'b', 4], l:match) 
endfunction

function! TestRepeatedSubmatches()
  let l:match = lab42#match#match_at('aaaa', '(.*)a', 3) 
  call lab42#test#assert_eq(['aaaa', 1, 'aaa', 1], l:match) 
endfunction

function! TestMatchAtNegativeCase()
  call lab42#test#assert_eq([], lab42#match#match_at('barabapapa', 'papa', 5))
  call lab42#test#assert_eq([], lab42#match#match_at('', '.', 5))
endfunction
