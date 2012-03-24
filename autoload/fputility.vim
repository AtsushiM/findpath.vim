"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/findpath.vim
"VERSION:  0.9
"LICENSE:  MIT

function! fputility#Delete(path)
    if filereadable(a:path)
        let cmd = 'rm -rf '.a:path
        call system(cmd)
        echo cmd
    else
        echo 'No File: '.a:path
    endif
endfunction

function! fputility#CustomCmds(...)
    let root = g:FPRoot()
    if root != ''
        let cmds = root.'/'.'.vimcmds'
        if a:0 != 0
            let cmds .= '_'.a:000[0]
        endif
        if filereadable(cmds)
            let org = getcwd()
            exec 'cd '.root
            exec 'source '.cmds
            exec 'cd '.org
        else
            echo 'No CommandFile.'
        endif
    endif
endfunction
