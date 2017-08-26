" Intelligent Strings
" Initialisers {{{
function! s:init_istr(internal)
  let a:internal._pre  = strpart(a:internal._text, 0, a:internal._col - 1)
  let a:internal._char = strpart(a:internal._text, a:internal._col - 1, 1)
  let a:internal._post = strpart(a:internal._text, a:internal._col)
  
endfunction
" }}}

" mr"myiw^c$function! s:m(internal)return a:internal._mendfunction/%add accessor%yypkc$let l:methodnames += ['m']^'r 
" Accessors {{{
function! s:col(internal)
  return a:internal._col
endfunction
function! s:char(internal)
  return a:internal._char
endfunction
function! s:get_data(internal)
  return [a:internal._text, a:internal._col]
endfunction
function! s:post(internal)
  return a:internal._post
endfunction
function! s:pre(internal)
  return a:internal._pre
endfunction 
function! s:replace_match(internal, match, replacement)
  if ! a:match.ismatch()
    return a:internal.__wrapper
  endif
  let l:start          = a:match.start()
  let l:replaced_match = strpart(a:internal._text, 0, l:start-1) . a:replacement . strpart(a:internal._text, a:match.end())
  let l:col_offset     = a:internal._col - l:start
  let l:rlen           = len(a:replacement)
  let l:col            = a:internal._col
  if l:col_offset >= l:rlen
    let l:col = l:start + l:rlen - 1
  endif
  return lab42#istr#new(l:replaced_match, l:col)
endfunction
function! s:replace_word(internal, replacement)
  return a:internal.__wrapper.replace_match(a:internal.__wrapper.word(), a:replacement)
endfunction
function! s:text(internal)
  return a:internal._text
endfunction
function! s:word(internal)
  if !has_key(a:internal, '_word')
    call s:compute_word(a:internal)
  endif
  return a:internal._word
endfunction
function! s:match_at_cursor(internal, rgx)
  let l:matches = lab42#match#match_at(a:internal._text, a:rgx, a:internal._col)
  if empty(l:matches)
    return lab42#match#nomatch(a:internal._col)
  endif
  return call('lab42#match#new', l:matches)
endfunction
" }}}

" Workers {{{
function! s:compute_word(internal)
  let l:match = a:internal.__wrapper.match_at_cursor('\S+')
  if l:match.ismatch()
    let a:internal._word = l:match
    return
  endif
  let a:internal._word = a:internal.__wrapper.match_at_cursor('\s+')
endfunction
" }}}

" Construct with (str, colnb) or
"                (str, getpos(...))
function! lab42#istr#new(line, col)
  let l:col = a:col
  if type(l:col) == type([])
    " constructed with getpos(...)
    let l:col = l:col[2]
  endif
  let l:wrapper = {}
  let l:object  = {"_text": a:line, "_col": l:col, "__wrapper": l:wrapper}
  call s:init_istr(l:object)
  let l:methodnames = ['col', 'text']
  let l:methodnames += ['char', 'post', 'pre']
  let l:methodnames += ['word']
  let l:methodnames += ['match_at_cursor']
  let l:methodnames += ['replace_match']
  let l:methodnames += ['get_data']
  let l:methodnames += ['replace_word']
  " %add accessor%
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction
