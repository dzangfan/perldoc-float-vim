if exists("g:loaded_perldoc")
  finish
endif
let g:loaded_perldoc = 1

function! s:TermCmd(cmd)
  execute "FloatermNew --autoclose=1 " . a:cmd
endfunction

function! s:PerldocWord(word)
  if s:ClassExist(a:word)
    call s:TermCmd('perldoc ' . a:word)
  elseif s:FuncExist(a:word)
    call s:TermCmd('perldoc -f ' . a:word)
  elseif s:VarsExist(a:word)
    call s:TermCmd('perldoc -v ' . a:word)
  else
    echo 'No documentation found for "' . a:word . '".'
  end
endfunction

function! s:ClassExist(word)
  silent call system('perldoc -otext -T ' . a:word)
  if v:shell_error
    return 0
  else
    return 1
  endif
endfunction

function! s:FuncExist(word)
  silent call system('perldoc -otext -f ' . a:word)
  if v:shell_error
    return 0
  else
    return 1
  endif
endfunction

function! s:VarsExist(word)
  silent call system('perldoc -otext -v ' . shellescape(a:word))
  if v:shell_error
    return 0
  else
    return 1
  endif
endfunction

function! s:Perldoc(...)
  let word = join(a:000, ' ')
  if !strlen(word)
    let word = expand('<cword>')
  endif
  let word = substitute(word, '^\(.*[^:]\)::$', '\1', '')
  call s:PerldocWord(word)
endfunction

let s:perlpath = ''
function! s:PerldocComplete(ArgLead, CmdLine, CursorPos)
  if len(s:perlpath) == 0
    try
      let s:perlpath = system('perl -e ' . shellescape("print join(q/,/,@INC)"))
    catch /E145:/
      let s:perlpath = ".,,"
    endtry
  endif
  let ret = {}
  for p in split(s:perlpath, ',')
    for i in split(globpath(p, substitute(a:ArgLead, '::', '/', 'g').'*'), "\n")
      if isdirectory(i)
          let i .= '/'
      elseif i !~ '\.pm$'
          continue
      endif
      let i = substitute(substitute(i[len(p)+1:], '[\\/]', '::', 'g'), '\.pm$', '', 'g')
      let ret[i] = i
    endfor
  endfor
  return sort(keys(ret))
endfunction

command! -nargs=* -complete=customlist,s:PerldocComplete Perldoc :call s:Perldoc(<q-args>)
