function! HandleShowDocument(lspserver, request)
    let params = a:request.params

    let filename = substitute(params.uri, '^file://', '', '')
    let start = params.selection.start

    let current = expand('%:p')

    if fnamemodify(filename, ':p') ==# fnamemodify(expand('%:p'), ':p')
        call cursor(start.line + 1, start.character + 1)
    endif
endfunction

function! HandleDocumentOutline(lspserver, request)
endfunction

function! vim_typst#setup()
    call LspAddServer([
                \     #{
                \         name: 'tinymist',
                \         filetype: ['typst'],
                \         path: 'tinymist',
                \         args: ['lsp'],
                \         initializationOptions: #{
                \             settings: #{
                \                 exportPdf: 'onType',
                \                 outPath: '$root/target/$dir/$name',
                \             },
                \         },
                \         customRequestHandlers: {
                \             'window/showDocument': function('HandleShowDocument'),
                \         },
                \         customNotificationHandlers: {
                \             'tinymist/documentOutline': function('HandleDocumentOutline'),
                \         },
                \     }
                \ ])

    nnoremap <silent> <localleader>tl :call g:LspRequestCustom(
        \ 'tinymist',
        \ 'workspace/executeCommand',
        \ {'command': 'tinymist.startDefaultPreview'}
        \ )<CR>
endfunction
