function! TestSubstrReplacementBeginning()

  "                            ....+....1
  let l:str  = lab42#istr#new('alpha beta', 3)
  let l:sstr = l:str.match_at_cursor('\w+')

  let l:replacement = l:str.replace_match(l:sstr, 'gamma')
  " l:str is immutable
  call lab42#test#assert_eq('alpha beta', l:str.text()) 
  call lab42#test#assert_eq(3, l:str.col()) 
  call lab42#test#assert_eq('p', l:str.char()) 

  " replacement contains cursor 
  call lab42#test#assert_eq('gamma beta', l:replacement.text() )
  call lab42#test#assert_eq(3, l:replacement.col() )

  " replace does not contain cursor
  let l:replacement = l:str.replace_match(l:sstr, 'g')
  call lab42#test#assert_eq('g beta', l:replacement.text() )
  call lab42#test#assert_eq(1, l:replacement.col() )
  
endfunction

function! TestReplacementMiddle()
  "                            ....+....1....+..
  let l:str  = lab42#istr#new('alpha beta  gamma', 9)
  let l:sstr = l:str.match_at_cursor('\w+')

  let l:r    = l:str.replace_match(l:sstr, '')
  call lab42#test#assert_eq(['alpha   gamma', 6], l:r.get_data())

  let l:r    = l:str.replace_match(l:sstr, 'B')
  call lab42#test#assert_eq(['alpha B  gamma', 7], l:r.get_data())

  let l:r    = l:str.replace_match(l:sstr, 'BERTA')
  call lab42#test#assert_eq(['alpha BERTA  gamma', 9], l:r.get_data())
endfunction

function! TestReplaceWS()
  "                            ....+....1....+..
  let l:str  = lab42#istr#new('alpha beta  gamma', 12)
  let l:sstr = l:str.match_at_cursor('\s+')

  let l:r    = l:str.replace_match(l:sstr, '*')
  "                           ....+....1....+.
  call lab42#test#assert_eq(['alpha beta*gamma', 11], l:r.get_data())
  " same with word
  let l:r    = l:str.replace_match(l:str.word(), '*')
  call lab42#test#assert_eq(['alpha beta*gamma', 11], l:r.get_data())
  " use short form
  let l:r    = l:str.replace_word('**')
  call lab42#test#assert_eq(['alpha beta**gamma', 12], l:r.get_data())
endfunction

function! TestReplaceEnd()
  "                            ....+....1....+..
  let l:str  = lab42#istr#new('alpha beta  gamma', 15)
  let l:sstr = l:str.match_at_cursor('\w+')

  let l:r    = l:str.replace_match(l:sstr, '')
  call lab42#test#assert_eq(['alpha beta  ', 12], l:r.get_data())
  
  let l:r    = l:str.replace_match(l:sstr, '***')
  call lab42#test#assert_eq(['alpha beta  ***', 15], l:r.get_data())
endfunction

function! TestReplaceNoMatch()
  "                            ....+....1
  let l:str  = lab42#istr#new('alpha beta', 3)
  let l:sstr = l:str.match_at_cursor('\d+')

  call lab42#test#assert_eq(0, l:sstr.ismatch())
  let l:r    = l:str.replace_match(l:sstr, 'REPLACEMENT')
  call lab42#test#assert_eq(['alpha beta', 3], l:r.get_data())


endfunction
