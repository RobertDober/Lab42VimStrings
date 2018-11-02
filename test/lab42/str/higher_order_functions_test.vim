function! TestPrefixWith() " {{{{{

  let l:empty = ''
  call lab42#test#assert_eq('  ',call(lab42#str#prefix_with_fn('  '), [l:empty]))

  let l:something = 'something'
  call lab42#test#assert_eq(' something',call(lab42#str#prefix_with_fn(' '), [l:something]))

  let l:indented = '  indented'
  call lab42#test#assert_eq('   indented',call(lab42#str#prefix_with_fn(' '), [l:indented]))
  
endfunction " }}}}}
