function! TestSubstrReplacement()

  let l:str = lab42#istr#new('alpha beta', 1)
  let l:sstr = lab42#substr#new('gamma', 6)

  let l:replacement = l:str.replace_substr(l:sstr)
  " l:str is immutable
  equals('alpha beta', l:str.text()) 
  equals(1, l:str.col()) 
  equals('a', l:str.char()) 
  
endfunction
