if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal nolisp
setlocal autoindent
setlocal indentkeys=0{,0},0#,!^F,o,O,0[,0],0(,0),.
setlocal indentexpr=InkoIndent(v:lnum)

if exists("*InkoIndent")
    finish
endif

function! InkoIndent(lnum)
    let prevlnum = prevnonblank(a:lnum-1)
    if prevlnum == 0
        return 0
    endif

    " grab the previous and current line, stripping comments.
    let prevl = substitute(getline(prevlnum), '#.*$', '', '')
    let thisl = substitute(getline(a:lnum), '#.*$', '', '')
    let previ = indent(prevlnum)

    let ind = previ

    if prevl =~ '[\[({]\s*$'
        let ind += shiftwidth()
    endif

    if thisl =~ '^\s*[)}\]]'
        let ind -= shiftwidth()
    endif

    return ind
endfunction
