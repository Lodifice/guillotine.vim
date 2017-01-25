if exists("g:loaded_guillotine")
    finish
endif

let g:loaded_guillotine = 1

function! s:guillotine()
    let filename = fnamemodify(expand("%"), ":t")
    let extension = fnamemodify(filename, ":e")
    let target = fnamemodify(filename, ":r")

    if extension[0] == "c"
        let target .= ".h"
    elseif extension[0] == "h"
        let target .= ".c"
    else
        echoerr "Tried to toggle between header and source in invalid file."
        return
    endif

    let targets = getcompletion(target, "file_in_path")
    if len(targets) < 1
        echoerr "Corresponding file " . target . " not found."
        return
    endif
    echo target
    execute "find" targets[0]
endfunction

augroup cfamily_guillotine
    autocmd!
    autocmd FileType c,cpp command! ToggleHeaderSource call <SID>guillotine()
augroup END
