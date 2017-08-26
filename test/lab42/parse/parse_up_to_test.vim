
function! TestParseUpTo()
  call lab42#test#assert_eq([1, "hello)"], lab42#parse#up_to('hello)', '', ')'))
  call lab42#test#assert_eq([0, "hello)"], lab42#parse#up_to('hello)', '', ''))
  call lab42#test#assert_eq([0, "hello()42"], lab42#parse#up_to('hello()42', '(', ')'))
endfunction

function! TestParseUpToWithMatch()
  let l:match = lab42#parse#up_to('hello)', '', ')', 12)
  call lab42#test#assert_eq(['hello)', 12, 17], l:match.text_and_positions())

  let l:match = lab42#parse#up_to('hello)', '', ')', 12)
  call lab42#test#assert_eq(["hello)", 12, 17], l:match.text_and_positions())
  let l:match = lab42#parse#up_to('hello)', '', '', 12)
  call lab42#test#assert_eq(0, l:match.ismatch())
  let l:match = lab42#parse#up_to('hello()42', '(', ')', 12)
  call lab42#test#assert_eq(0, l:match.ismatch())
  
endfunction
function! TestParseUpToIncAndDec()
  call lab42#test#assert_eq([1, "hello(42))"], lab42#parse#up_to('hello(42))43', '(', ')'))
  
  "                                ....+....1..
  let l:match = lab42#parse#up_to('hello(42))43', '(', ')', 12)
  call lab42#test#assert_eq(['hello(42))', 12, 21], l:match.text_and_positions())

endfunction
