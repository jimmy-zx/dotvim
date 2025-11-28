function! dvim_lsp#probe()
endfunction

function! dvim_lsp#setup()
    packadd lsp
    call LspAddServer([#{name: 'pylsp',
                 \      filetype: 'python',
                 \      path: 'pylsp',
                 \      args: [],
                 \      initializationOptions: #{
                 \          pylsp: #{
                 \              plugins: #{
                 \                  pycodestyle: #{enabled: v:false},
                 \                  mccabe: #{enabled: v:false},
                 \                  pyflakes: #{enabled: v:false},
                 \                  flake8: #{enabled: v:true},
                 \              },
                 \          },
                 \      },
                 \ }])
    call LspAddServer([#{name: 'clangd',
                     \   filetype: ['c', 'cpp'],
                     \   path: 'clangd',
                     \   args: ['--background-index', '--clang-tidy']
                     \ }])
    call LspAddServer([#{name: 'solidity',
                     \   filetype: ['solidity'],
                     \   path: 'npx',
                     \   args: ["nomicfoundation-solidity-language-server", "--stdio"]
                     \ }])
    call LspAddServer([
                \     #{
                \         name: 'tinymist',
                \         filetype: ['typst'],
                \         path: 'tinymist',
                \         args: ["lsp"],
                \         initializationOptions: #{
                \             settings: #{
                \                 exportPdf: 'onType',
                \                 outPath: '$root/target/$dir/$name',
                \             },
                \         },
                \     }
                \ ])

    call LspOptionsSet(#{
                    \   showDiagOnStatusLine: v:true,
                    \ })
    nnoremap <silent> <localleader>tl :call g:LspRequestCustom(
        \ 'tinymist',
        \ 'workspace/executeCommand',
        \ {'command': 'tinymist.startDefaultPreview'}
        \ )<CR>
endfunction
