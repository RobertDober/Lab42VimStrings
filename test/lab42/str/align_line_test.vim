function! TestAlignLine() " {{{{{
  "            0....+....1....+"
  let l:line = "Jelly = Wood"
  "                0....+....1....+"
  let l:expected = "Jelly   = Wood"
  call lab42#test#assert_eq(l:expected, lab42#str#align_line(l:line, '=', 9))
  "                0....+....1....+"
  let l:expected = "Jelly = Wood"
  call lab42#test#assert_eq(l:expected, lab42#str#align_line(l:line, '=', 7))
  call lab42#test#assert_eq(l:expected, lab42#str#align_line(l:line, '=', 6))
  call lab42#test#assert_eq(l:expected, lab42#str#align_line(l:line, '=', 0))

endfunction " }}}}}
