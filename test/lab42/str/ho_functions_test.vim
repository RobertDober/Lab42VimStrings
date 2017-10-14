function! TestSubstring() " {{{{{
              " 0....+....1....+....2
  let l:input = 'Hello Good Old World'

  let l:Subs  = lab42#str#substring_fn(5, 7)
  call lab42#test#assert_eq('o G', l:Subs(l:input))

  let l:Subs  = lab42#str#substring_fn(5, 5)
  call lab42#test#assert_eq('o', l:Subs(l:input))

  let l:Subs  = lab42#str#substring_fn(5, 4)
  call lab42#test#assert_eq('', l:Subs(l:input))
endfunction " }}}}}

function! TestSubstringWithDefaultPadding() " {{{{{
              " 0....+....1....+....2
  let l:input = 'Hello Good Old World'

  let l:Subs  = lab42#str#substring_fn(16, 23)
  call lab42#test#assert_eq('World   ', l:Subs(l:input))
endfunction " }}}}}

function! TestSubstringWithExplicitPadding() " {{{{{
              " 0....+....1....+....2
  let l:input = 'Hello Good Old World'

  let l:Subs  = lab42#str#substring_fn(16, 23, '.+')
  call lab42#test#assert_eq('World.+.', l:Subs(l:input))
  
endfunction " }}}}}
