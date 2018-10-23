function! TestVariables() " {{{{{
  
  "             0....+....1....+.
  let l:line = "a ${b} a${a}${b}"

  let l:result = lab42#scan#rgx_w_group(l:line, '\$\{([^\}]+)\}')

  call lab42#test#assert_eq([['b', 2, 6], ['a', 8, 12], ['b', 12, 16]], l:result)

endfunction " }}}}}
