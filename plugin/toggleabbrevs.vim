"" This a a vim plugin for toggling abbrevs
"
function! toggleabbrevs#save() 
    redir => abbrevs 
    silent abbreviate 
    redir END 
    let g:toggleabbrevs = map(split(abbrevs[1:], "\n"), 'substitute(v:val, "^\\([a-z]\\)", "\\0abbr", "")') 
endfunction 

function! toggleabbrevs#exec(cmd) abort
    exec a:cmd
endfunction

function! toggleabbrevs#toggle() abort
    if exists('g:toggleabbrevs')
        call map(g:toggleabbrevs, 'toggleabbrevs#exec(v:val)')
        unlet g:toggleabbrevs
    else
        call toggleabbrevs#save()
        exec 'abclear'
    endif
endfunction

command! ToggleAbbrevs call toggleabbrevs#toggle()
