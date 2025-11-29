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
                \         args: ['lsp', '--mirror', 'stdout'],
                \         initializationOptions: #{
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
        \ {
        \   'command': 'tinymist.doStartBrowsingPreview',
        \   'arguments': [[
        \       "--task-id=default_preview",
        \       "--data-plane-host=127.0.0.1:0",
        \       "--open",
        \   ]]
        \ }
        \ )<CR>
    nnoremap <silent> <localleader>tv :call g:LspRequestCustom(
        \ 'tinymist',
        \ 'workspace/executeCommand',
        \ {
        \   'command': 'tinymist.scrollPreview',
        \   'arguments': [
        \       'default_preview',
        \       {
        \           "event": "panelScrollTo",
        \           "filepath": expand("%:p"),
        \           "character": col("."),
        \           "line": line("."),
        \       },
        \   ]
        \ },
        \ )<CR>
endfunction
