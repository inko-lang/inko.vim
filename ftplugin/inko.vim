if exists("b:did_ftplugin")
    finish
endif

let b:did_ftplugin = 1

augroup inko.vim
    autocmd!

    setlocal sts=2 sw=2 ts=2
    setlocal matchpairs-=<:>
    setlocal comments=:#
    setlocal commentstring=#\ %s
    setlocal formatoptions=jcroql

    if get(g:, "inko_folding", 0)
      setlocal foldmethod=expr
      setlocal foldexpr=inko#Fold()
    endif
augroup END

setlocal sw=2 sts=2 ts=2 expandtab
