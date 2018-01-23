function! s:normalizeResult(result) " {{{{{
  if type(a:result) == type("string")
    return a:result
  else
    return join(a:result, '')
  endif
endfunction " }}}}}

function! lab42#ho#filter(line, fun) " {{{{{
  let [l:prefix, l:rest] = lab42#str#split_with_prefix(a:line)
  let l:words = lab42#list#new(split(l:rest))
  return s:normalizeResult(a:fun(l:prefix, l:rest, l:words))
endfunction " }}}}}

function! lab42#ho#filter_prefixed(line, fun) " {{{{{
  let [l:prefix, l:rest] = lab42#str#split_with_prefix(a:line)
  let l:words = lab42#list#new(split(l:rest))
  return l:prefix . s:normalizeResult(a:fun(l:rest, l:words))
endfunction " }}}}}
