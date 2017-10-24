" shortcuts
function! s:c(str) " {{{{{
  return lab42#str#camelCase(a:str)
endfunction " }}}}}
function! s:u(str) " {{{{{
  return lab42#str#underscore(a:str)
endfunction " }}}}}

function! TestUnderscore() " {{{{{
  call lab42#test#assert_eq('', s:u(''))
  call lab42#test#assert_eq('_', s:u('_'))
  call lab42#test#assert_eq('_h', s:u('_h'))
  call lab42#test#assert_eq('h_', s:u('h_'))
  call lab42#test#assert_eq('h', s:u('h'))
  call lab42#test#assert_eq('hello_world', s:u('hello_world'))
  call lab42#test#assert_eq('hello_world', s:u('helloWorld'))
  call lab42#test#assert_eq('hello_world_', s:u('helloWorld_'))
  call lab42#test#assert_eq('2_d', s:u('2D'))
  call lab42#test#assert_eq('x2_d', s:u('x2D'))
  call lab42#test#assert_eq('x2_d', s:u('X2D'))
  call lab42#test#assert_eq('a2_delta3_alpha', s:u('A2Delta3Alpha'))
endfunction " }}}}}

function! TestCamelCase() " {{{{{
  call lab42#test#assert_eq('underscore', s:c('underscore'))
  call lab42#test#assert_eq('helloWorld', s:c('hello_world'))
endfunction " }}}}}
