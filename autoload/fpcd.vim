"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/findpath.vim
"VERSION:  0.9
"LICENSE:  MIT

function! fpcd#RootPath()
    let i = 0
    let org = expand('%:p:h')
    let dir = org.'/'
    while i < g:findpath_CDLoop
        if !filereadable(dir.g:findpath_DefaultConfigFile)
            let i = i + 1
            let dir = dir.'../'
        else
            exec 'silent cd '.dir
            let dir = getcwd()
            exec 'silent cd '.org
            break
        endif
    endwhile

    if i == g:findpath_CDLoop
        return ''
    else
        return dir
    endif
endfunction
