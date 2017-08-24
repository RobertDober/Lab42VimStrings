" Intelligent Strings
" Initialisers {{{
function! s:init_istr(internal)
  let a:internal._pre  = strpart(a:internal._text, 0, a:internal._col - 1)
  let a:internal._char = strpart(a:internal._text, a:internal._col - 1, 1)
  let a:internal._post = strpart(a:internal._text, a:internal._col)
  
endfunction
" }}}

" Accessors {{{
function! s:col(internal)
  return a:internal._col
endfunction
function! s:text(internal)
  return a:internal._text
endfunction
function! s:char(internal)
  return a:internal._char
endfunction
function! s:post(internal)
  return a:internal._post
endfunction
function! s:pre(internal)
  return a:internal._pre
endfunction 
function! s:word(internal)
  if !has_key(a:internal, '_word')
    call s:compute_word(a:internal)
  endif
  return a:internal._word
endfunction
" }}}

" Workers {{{
function! s:compute_ws_word(internal)
  
endfunction
function! s:compute_word(internal)
  if a:internal._char == ' '
    call s:compute_ws_word(a:internal)
  else
    call s:compute_notws_word(a:internal)
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
  let l:object  = {"_text": a:line, "_col": l:col}
  let l:wrapper = {}
  call s:init_istr(l:object)
  let l:methodnames = ['col', 'text']
  let l:methodnames += ['char', 'post', 'pre']
  let l:methodnames += ['word']
  " let l:methodnames = ['char', 'word', 'pretext', 'posttext', 'isonws', 'prews', 'prewordend']
  " let l:methodnames += ['prewordtext', 'postwordtext' ,'postws' ,'preword' ,'postword' ,'precontext' ,'postcontext', 'replaceWord' ,'line' ,'col', 'replacePreword', 'withCursorAtPreword', 'withCursorAtPostword', 'replacePostchar', 'replacePostword']
  for l:funname in l:methodnames
    call extend(l:wrapper, {l:funname: funcref('s:' . l:funname, [l:object])})
  endfor
  return l:wrapper
endfunction
