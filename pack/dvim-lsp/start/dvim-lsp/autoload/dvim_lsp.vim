function! dvim_lsp#setup()
    packadd lsp
    call LspAddServer([#{name: 'pylsp',
                 \   filetype: 'python',
                 \   path: '/usr/bin/pylsp',
                 \   args: []
                 \ }])
endfunction
