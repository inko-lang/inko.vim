if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
end

let b:current_syntax = "inko"

set iskeyword+=?

syn keyword inkoKeyword object import trait let mut return self throw else
syn keyword inkoKeyword impl for as do lambda when static match
syn keyword inkoSpecialConstant Self Dynamic

" Variables/identifiers
syn match inkoInstanceVariable "@\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*"
syn match inkoIdentifier "\<[_[:lower:]][_[:alnum:]]*[?!=]\="
syn match inkoConstant "\%(\%(^\|[^.]\)\.\s*\)\@<!\<\u\%(\w\|[^\x00-\x7F]\)*\>\%(\s*(\)\@!"
syn match inkoKeywordArgument "\(let \|let mut \)\@<!\%(\h\|[^\x00-\x7F]\)\%(\w\|[^\x00-\x7F]\)*:[^:]"

" Numbers
syn match inkoNumber "\d\+\([\._]\d\+\)*\([eE]+\d\+\)\?"
syn match inkoHex "0[xX][0-9a-fA-F]\+"

" Strings
syn region inkoDoubleString matchgroup=inkoDoubleStringDelimiter start="\"" end="\"" skip="\\\\\|\\\""
syn region inkoSingleString matchgroup=inkoSingleStringDelimiter start="'" end="'" skip="\\\\\|\\\'"

" Method definitions
syn keyword inkoKeyword def nextgroup=inkoMethodName skipwhite skipempty
syn match inkoMethodName "[^( -!{]\+" contained nextgroup=inkoMethodArguments

" Don't highlight arguments such as `foo: Integer` in method definitions. This
" ensures that both required and optional arguments use the same colors.
syn region inkoMethodArguments start="(" end=")" contains=TOP,inkoKeywordArgument keepend

" Literals
syn match inkoDelimiters "[\[\]{}.,()=_]"
syn match inkoOperators "[-+\*^%!/<>&|?~]"

" Generic characters
syn match inkoNamespaceSeparator "::"
syn match inkoDot "\."
syn match inkoThrows "!!"
syn match inkoReturns "->"
syn match inkoTry 'try!\?'

" Basic Markdown support for doc comments.
syn region inkoCommentCode start="#\s\{5\}\zs" end="$" contained oneline keepend contains=TOP oneline
syn region inkoCommentBold start="\*\*" end="\*\*" contained oneline
syn region inkoCommentItalic start="_" end="_" contained keepend oneline
syn region inkoCommentTitle start="#\s\+\zs#\+" end="$" contained oneline
syn region inkoCommentListDelimiter start="#\s*\zs\(\*\|\d.\)" end="\s" contained oneline
syn region inkoCommentInlineUrl matchgroup=inkoCommentInlineUrlDelimiter start="<" end=">" contained keepend
syn region inkoCommentInlineCode start="`" end="`" keepend oneline contained contains=TOP

syn cluster inkoCommentMarkup contains=inkoCommentCode,inkoCommentBold
syn cluster inkoCommentMarkup add=inkoCommentItalic,inkoCommentTitle
syn cluster inkoCommentMarkup add=inkoCommentListDelimiter,inkoCommentInlineUrl
syn cluster inkoCommentMarkup add=inkoCommentInlineCode

" Comments
syn region inkoComment start="#" end="$" contains=@Spell,@inkoCommentMarkup keepend

hi def link inkoDot Normal
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
hi def link inkoTry Keyword
