function! dvim#probe()
endfunction

function! dvim#setup()
    if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
        runtime! macros/matchit.vim
    endif

    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
endfunction
