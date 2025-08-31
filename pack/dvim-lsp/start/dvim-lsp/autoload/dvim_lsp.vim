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
    call LspOptionsSet(#{
                    \   showDiagOnStatusLine: v:true,
                    \ })
endfunction
