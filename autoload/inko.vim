function! inko#Fold()
    let l:line = getline(v:lnum)

    if l:line =~? '\v^\s*$'
        return '-1'
    endif

    if line =~? '^\s*#.*$'
        return '1'
    endif

    return '0'
endfunction
