if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
end

let b:current_syntax = "inko"

set iskeyword+=?,!

syn keyword inkoKeyword object import trait let mut return self throw else
syn keyword inkoKeyword impl for as when static match do lambda local try try!
syn keyword inkoSpecialConstant Self Never

" Numbers
syn match inkoNumber "\d\+\([\._]\d\+\)*\([eE]+\d\+\)\?"
syn match inkoHex "0[xX][0-9a-fA-F]\+"

" Variables/identifiers
syn match inkoInstanceVariable "@[_a-zA-Z0-9]\+"
syn match inkoIdentifier "_\?[a-z][_a-zA-Z0-9]\+?\?" nextgroup=@inkoArguments

" Constants
syn match inkoConstant "_\?[A-Z][_a-zA-Z0-9]*" nextgroup=inkoTypeArguments
syn region inkoTypeArguments start="!(" end=")"
    \ contains=inkoConstant,inkoSpecialConstant,inkoTypeArguments,inkoComma,
    \          inkoThrows,inkoReturns,inkoKeyword
    \ contained

" Methods
syn keyword inkoKeyword def nextgroup=inkoMethodName skipwhite skipempty
syn match inkoMethodName "[^( -!{]\+" contained

" Message (keyword) arguments.
syn cluster inkoArguments contains=inkoTypeArguments,inkoMessageArguments
syn region inkoMessageArguments start="(" end=")" contained contains=TOP
syn match inkoKeywordArgument "_\?[a-z][_a-zA-Z0-9]*:" contained
    \ containedin=inkoMessageArguments

" Strings
syn region inkoDoubleString matchgroup=inkoDoubleStringDelimiter
    \ start="\"" end="\"" skip="\\\\\|\\\""
syn region inkoSingleString matchgroup=inkoSingleStringDelimiter
    \ start="'" end="'" skip="\\\\\|\\\'"

" Generic characters
syn match inkoDelimiters "[\[\]{}.,=_]"
syn match inkoOperators "[-+\*^%!/<>&|~]"
syn match inkoNamespaceSeparator "::"
syn match inkoThrows "!!"
syn match inkoReturns "->"

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

hi def link inkoDelimiters Normal
hi def link inkoOperators Normal
hi def link inkoNamespaceSeparator Normal
hi def link inkoKeyword Keyword
hi def link inkoComment Comment
hi def link inkoModuleDocComment Comment
hi def link inkoDocComment Comment
hi def link inkoNumber Number
hi def link inkoHex Number
hi def link inkoString String
hi def link inkoDoubleString inkoString
hi def link inkoSingleString inkoString
hi def link inkoInstanceVariable Identifier
hi def link inkoMethodName Function
hi def link inkoIdentifier Identifier
hi def link inkoThrows Keyword
hi def link inkoReturns Keyword
hi def link inkoKeywordArgument Normal
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
