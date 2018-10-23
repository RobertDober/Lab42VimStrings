function! s:extractSubMatch(line, rgx) " {{{{{
  let l:matches = matchlist(a:line, a:rgx)
  return l:matches[1]
endfunction " }}}}}

function! lab42#scan#rgx_w_group(line, rgx) " {{{{{
  let l:rgx = '\v' . a:rgx
  let l:rgt = 0

  let l:result = []

  let [l:str, l:lft, l:rgt] = matchstrpos(a:line, l:rgx, l:rgt)
  while l:rgt >= 0
    let l:sub = s:extractSubMatch(l:str, l:rgx)
    call add(l:result, [l:sub, l:lft, l:rgt])
    let [l:str, l:lft, l:rgt] = matchstrpos(a:line, l:rgx, l:rgt)
  endwhile

  return l:result
endfunction " }}}}}
