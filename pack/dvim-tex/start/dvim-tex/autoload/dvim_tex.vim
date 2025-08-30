function! dvim_tex#probe()
endfunction

function! dvim_tex#setup()
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
    let g:vimtex_compiler_latexmk_engines = {
        \'_': '-xelatex'
        \}
    let g:vimtex_compiler_latexmk = {
        \ 'options': [
        \   '-verbose',
        \   '-shell-escape',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
endfunction
