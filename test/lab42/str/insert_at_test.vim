function! TestInsertInMiddle() " {{{{{
               " 0....+
  let l:origin = 'alpha'

  let l:result = lab42#str#insert(l:origin, '*', 1)
  " undestructive
  call lab42#test#assert_eq('alpha', l:origin)
  call lab42#test#assert_eq('a*lpha', l:result )

  let l:result = lab42#str#insert(l:origin, '', 1)
  call lab42#test#assert_eq('alpha', l:result )


  let l:result = lab42#str#insert(l:origin, '--', 4)
  call lab42#test#assert_eq('alph--a', l:result )
endfunction " }}}}}

function! TestInsertAtEdges() " {{{{{
               " 0....+
  let l:origin = 'alpha'
  
  let l:result = lab42#str#insert(l:origin, '', 0)
  call lab42#test#assert_eq('alpha', l:result )

  let l:result = lab42#str#insert(l:origin, '--', 0)
  call lab42#test#assert_eq('--alpha', l:result )
  
  let l:result = lab42#str#insert(l:origin, '', 5)
  call lab42#test#assert_eq('alpha', l:result )

  let l:result = lab42#str#insert(l:origin, '--', 5)
  call lab42#test#assert_eq('alpha--', l:result )
endfunction " }}}}}

function! TestInsertOutOfBoundsPadsWithSpaces() " {{{{{
               " 0....+
  let l:origin = 'alpha'
  
  let l:result = lab42#str#insert(l:origin, '', 7)
  call lab42#test#assert_eq('alpha  ', l:result )

  let l:result = lab42#str#insert(l:origin, '--', 7)
  call lab42#test#assert_eq('alpha  --', l:result )
endfunction " }}}}}

function! TestInsertOutOfBoundsWithPadding() " {{{{{
               " 0....+
  let l:origin = 'alpha'
  
  let l:result = lab42#str#insert(l:origin, '', 7, '*')
  call lab42#test#assert_eq('alpha**', l:result )

  let l:result = lab42#str#insert(l:origin, '--', 7, '+')
  call lab42#test#assert_eq('alpha++--', l:result )
endfunction
  
function! TestInsertOutOfBoundsWithLongPadding() " {{{{{
               " 0....+
  let l:origin = 'alpha'
  
  let l:result = lab42#str#insert(l:origin, '', 10, 'be')
  call lab42#test#assert_eq('alphabebeb', l:result )

  let l:result = lab42#str#insert(l:origin, '--', 10, 'be')
  call lab42#test#assert_eq('alphabebeb--', l:result )
endfunction " }}}}}
