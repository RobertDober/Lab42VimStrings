
" Accessing {{{
" The vim macro to create an accessor
" mr"myiw^c$function! s:m(internal)return a:internal._mendfunction/%add accessor%yypkc$let l:methodnames += ['m']^'r 
function! s:text(internal)
  return a:internal._text
endfunction
function! s:start(internal)
  return a:internal._start
endfunction
function! s:end(internal)
  return a:internal._end
endfunction
function! s:submatches(internal, ...)
  if a:0
    return a:internal._submatches[a:1]
  else
    return a:internal._submatches
  endif
endfunction

" }}}
" Construction {{{
function! s:init_submatch(internal, submatch)
  let l:submatch = call(function('lab42#match#new'), a:submatch)
  call add(a:internal._submatches, l:submatch)
endfunction
function! s:init_submatches(internal, submatches)
  call lab42#fn#map(a:submatches, function('s:init_submatch', [a:internal]))
endfunction
function! s:init_match(internal)
  call extend(a:internal, {"_end": a:internal._start + len(a:internal._text) - 1})
endfunction
" Construct with (str, start) or
function! lab42#match#new(str, start, ...)
  let l:object  = {"_text": a:str, "_start": a:start, "_submatches": []}
  let l:wrapper = {}
  call s:init_match(l:object)
  let l:methodnames = []
  let l:methodnames += ['text']
  let l:methodnames += ['start']
  let l:methodnames += ['end']
  let l:methodnames += ['submatches']
  " %add accessor%
  " let l:methodnames = ['char', 'word', 'pretext', 'posttext', 'isonws', 'prews', 'prewordend']
  " let l:methodnames += ['prewordtext', 'postwordtext' ,'postws' ,'preword' ,'postword' ,'precontext' ,'postcontext', 'replaceWord' ,'line' ,'col', 'replacePreword', 'withCursorAtPreword', 'withCursorAtPostword', 'replacePostchar', 'replacePostword']
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  if a:0
    call s:init_submatches(l:object, copy(a:000))
  endif
  return l:wrapper
endfunction
" }}}
