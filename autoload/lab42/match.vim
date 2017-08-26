
" Helpers {{{
function! s:make_sub(orig_str, match_start, acc, submatch_idx_pair)
  let [l:submatch, l:idx] = a:submatch_idx_pair
  if l:submatch == ''
    return a:acc
  endif
  let l:foundidx = stridx(a:orig_str, l:submatch, l:idx + a:match_start)
  call extend(a:acc, [l:submatch, 1 + l:foundidx])
  return a:acc
endfunction
function! s:match_with_submatches_at(orig_str, rgx, pos, match_start)
  let l:matches = matchlist(a:orig_str, a:rgx, a:pos)
  let l:subs    = l:matches[1:]
  let l:result  = [l:matches[0], a:match_start + 1] 
  " Need to find each sub with each index as offset
  return lab42#fn#foldl_with_index(l:subs, l:result, function('s:make_sub', [a:orig_str, a:match_start]))
endfunction

function! lab42#match#match_at(str, rgx, pos)
  let l:index = 0
  let l:rgx   = '\v' . a:rgx
  let l:max   = len(a:str)
  while l:index < l:max 
    let [l:m, l:sminus1, l:end] = matchstrpos(a:str, l:rgx, l:index)
    if l:end == -1
      return []
    endif
    if l:sminus1 < a:pos && l:end >= a:pos
      return s:match_with_submatches_at(a:str, l:rgx, l:index, l:sminus1)
    endif
    let l:index += 1
  endwhile
  return []
endfunction
" }}}
" Accessing {{{
" The vim macro to create an accessor
" mr"myiw^c$function! s:m(internal)return a:internal._mendfunction/%add accessor%yypkc$let l:methodnames += ['m']^'r 
function! s:ismatch(internal)
  return a:internal._start <= a:internal._end
endfunction
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
function! s:text_and_positions(internal)
  return [a:internal._text, a:internal._start, a:internal._end]
endfunction
" }}}

" Construction {{{
function! s:init_submatch(internal, submatch, matchpos)
  let l:submatch = call(function('lab42#match#new'), [a:submatch, a:matchpos])
  call add(a:internal._submatches, l:submatch)
endfunction
function! s:init_submatches(internal, submatches)
  call lab42#fn#mapn(a:submatches, 2, function('s:init_submatch', [a:internal]))
endfunction
function! s:init_match(internal)
  call extend(a:internal, {"_end": a:internal._start + len(a:internal._text) - 1})
endfunction
function! lab42#match#nomatch(start)
  return lab42#match#new('', a:start)
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
  let l:methodnames += ['text_and_positions']
  let l:methodnames += ['ismatch']
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
