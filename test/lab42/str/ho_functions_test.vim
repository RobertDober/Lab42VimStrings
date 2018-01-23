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

function! s:swapWords(_p, _t, words) " {{{{{
  return [a:words.second(), a:words.first()]
endfunction " }}}}}

function! s:swapWordsForPrefixed(_t, words) " {{{{{
  return [a:words.second(), a:words.first()]
endfunction " }}}}}

function! TestFilter() " {{{{{
  let l:line = '  first second'
  let l:result = lab42#ho#filter(l:line, funcref('s:swapWords'))
  call lab42#test#assert_eq('secondfirst', l:result )
endfunction

function! TestFilterPrefixed()
  let l:line = '  first second'
  let l:result = lab42#ho#filter_prefixed(l:line, funcref('s:swapWordsForPrefixed'))
  call lab42#test#assert_eq('  secondfirst', l:result )
endfunction " }}}}}
