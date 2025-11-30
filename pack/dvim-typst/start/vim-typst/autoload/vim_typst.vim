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

let g:tinymist_has_preview = v:false

function! TinymistStartPreview() abort
    if g:tinymist_has_preview
        return
    endif
    call g:LspRequestCustom(
            \ 'tinymist',
            \ 'workspace/executeCommand',
            \ {
            \   'command': 'tinymist.doStartBrowsingPreview',
            \   'arguments': [[
            \     '--task-id=default_preview',
            \     '--data-plane-host=127.0.0.1:0',
            \     '--open',
            \   ]]
            \ }
            \ )
    let g:tinymist_has_preview = v:true
endfunction

function! TinymistScrollPreview(line, col) abort
    if !g:tinymist_has_preview
        return
    endif
    call g:LspRequestCustom(
            \ 'tinymist',
            \ 'workspace/executeCommand',
            \ {
            \   'command': 'tinymist.scrollPreview',
            \   'arguments': [
            \     'default_preview',
            \     {
            \       'event': 'panelScrollTo',
            \       'filepath': expand('%:p'),
            \       'character': a:col - 1,
            \       'line': a:line,
            \     },
            \   ]
            \ }
            \ )
endfunction

let g:tinymist_last_line = -1
function! TinymistMaybeScroll() abort
    let l:cur = line('.')
    if l:cur != g:tinymist_last_line
        let g:tinymist_last_line = l:cur
        call TinymistScrollPreview(l:cur, col('.'))
    endif
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

    nnoremap <silent> <localleader>tl :call TinymistStartPreview()<CR>
    nnoremap <silent> <localleader>tv :call TinymistScrollPreview(line('.'), col('.'))<CR>
    augroup TinymistScrollPreview
        autocmd!
        autocmd CursorMoved * call TinymistMaybeScroll()
    augroup END
endfunction
