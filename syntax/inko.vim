if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
end

let b:current_syntax = "inko"

set iskeyword+=?

syn sync minlines=200

" Numbers
syn match inkoNumber "\d\+\([\._]\d\+\)*\([eE]+\d\+\)\?u\?"
syn match inkoHex "0[xX][0-9a-fA-F]\+"

" Variables/identifiers
syn match inkoInstanceVariable "@[_a-zA-Z0-9]\+"
syn match inkoIdentifier "_\?[a-z][_a-zA-Z0-9]\+?\?" nextgroup=@inkoArguments

" Constants
syn keyword inkoSpecialConstant Self Never Any
syn match inkoConstant "_\?[A-Z][_a-zA-Z0-9]*"

" Methods
syn match inkoKeyword '\<fn\s\+\(pub\s\+\)\?\(\(move\|async\(\s\+mut\)\?\|static\|mut\|extern\)\>\)\?'
    \ nextgroup=inkoMethodName skipempty skipwhite
syn match inkoMethodName "[^( -!{]\+" contained

" Message (keyword) arguments.
syn cluster inkoArguments contains=inkoMessageArguments
syn region inkoMessageArguments start="(" end=")" contained contains=TOP
syn match inkoKeywordArgument "_\?[a-z][_a-zA-Z0-9]*:[^:]" contained
    \ containedin=inkoMessageArguments

" Strings
syn region inkoDoubleString matchgroup=inkoDoubleStringDelimiter
    \ start="\"" end="\"" skip="\\\\\|\\\"" contains=inkoStringEmbed

syn region inkoSingleString matchgroup=inkoSingleStringDelimiter
    \ start="'" end="'" skip="\\\\\|\\'"

syn region inkoStringEmbed matchgroup=inkoStringEmbedDelimiter
    \ start="{" end="}" skip="\\\\\|\\{" contains=TOP contained

" Generic characters
syn match inkoDelimiters "[\[\]{}.,=_]"
syn match inkoOperators "[-+\*^%!/<>&|~]"
syn match inkoNamespaceSeparator "::"
syn match inkoReturns "->"

" Keywords
"
" We use `syn match` as keywords are also valid method names, provided an
" explicit receiver is used (e.g. `self.import` is valid).
syn match inkoKeyword '\.\@<!\<\(let\|else\|class\|import\|trait\|mut\|return\)\>'
syn match inkoKeyword '\.\@<!\<\(self\|throw\|impl\|for\|as\|static\|match\)\>'
syn match inkoKeyword '\.\@<!\<\(try!\?\|builtin\|extern\|if\|async\|nil\)\>'
syn match inkoKeyword '\.\@<!\<\(move\|ref\|while\|loop\|next\|break\|and\|or\)\>'
syn match inkoKeyword '\.\@<!\<\(pub\|true\|false\|case\|enum\|uni\|recover\)\>'

" Basic Markdown support for doc comments.
syn region inkoCommentCode start="#\s\{5\}\zs" end="$" contained oneline
syn region inkoCommentInlineCode start="`" end="`" oneline contained
syn region inkoCommentBold start="\*\*" end="\*\*" contained oneline
syn region inkoCommentItalic start="_" end="_" contained keepend oneline
syn region inkoCommentTitle start="#\s\+\zs#\+" end="$" contained oneline
syn region inkoCommentListDelimiter start="#\s*\zs\(\*\|\d.\)" end="\s" contained oneline
syn region inkoCommentInlineUrl matchgroup=inkoCommentInlineUrlDelimiter
    \ start="<" end=">" contained keepend

syn keyword inkoTodo TODO FIXME THINK HACK contained

syn cluster inkoCommentMarkup contains=inkoCommentCode,inkoCommentBold
syn cluster inkoCommentMarkup add=inkoCommentItalic,inkoCommentTitle
syn cluster inkoCommentMarkup add=inkoCommentListDelimiter,inkoCommentInlineUrl
syn cluster inkoCommentMarkup add=inkoCommentInlineCode
syn cluster inkoCommentMarkup add=inkoTodo

" Comments
syn region inkoComment start="#" end="$" contains=@Spell,@inkoCommentMarkup keepend

hi def link inkoDelimiters Operator
hi def link inkoOperators Operator
hi def link inkoNamespaceSeparator Operator
hi def link inkoKeyword Keyword
hi def link inkoComment Comment
hi def link inkoModuleDocComment Comment
hi def link inkoDocComment Comment
hi def link inkoNumber Number
hi def link inkoHex Number
hi def link inkoString String
hi def link inkoDoubleString inkoString
hi def link inkoSingleString inkoString
hi def link inkoSingleStringDelimiter inkoString
hi def link inkoDoubleStringDelimiter inkoString
hi def link inkoStringEmbedDelimiter Delimiter
hi def link inkoInstanceVariable Identifier
hi def link inkoMethodName Function
hi def link inkoIdentifier Identifier
hi def link inkoReturns Keyword
hi def link inkoYields Keyword
hi def link inkoKeywordArgument Identifier
hi def link inkoConstant Constant
hi def link inkoSpecialConstant Keyword
hi def link inkoCommentCode Comment
hi def link inkoCommentBold Comment
hi def link inkoCommentItalic Comment
hi def link inkoCommentTitle Comment
hi def link inkoCommentListDelimiter Keyword
hi def link inkoCommentInlineUrl Comment
hi def link inkoCommentInlineCode inkoCommentCode
hi def link inkoCommentInlineUrlDelimiter Comment
hi def link inkoTodo Todo
