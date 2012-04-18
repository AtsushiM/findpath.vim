"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/findpath.vim
"VERSION:  0.9
"LICENSE:  MIT

let s:save_cpo = &cpo
set cpo&vim

let s:findpath_ConfigNo = 0
let s:findpath_ConfigOpen = 0
let s:findpath_ListNo = 0
let s:findpath_ListOpen = 0
let s:findpath_DefaultList = g:findpath_DefaultConfigDir.g:findpath_DefaultList

function! fp#Delete(path)
    if filereadable(a:path)
        let cmd = 'rm -rf '.a:path
        call system(cmd)
        echo cmd
    else
        echo 'No File: '.a:path
    endif
endfunction

function! fp#ConfigOpen()
    exec g:findpath_ConfigWindowSize.' '.g:findpath_DefaultConfigDir.g:findpath_DefaultConfig
    let s:findpath_ConfigOpen = 1
    let s:findpath_ConfigNo = bufnr('%')
endfunction
function! fp#ConfigClose()
    let s:findpath_ConfigOpen = 0
    exec 'bw '.s:findpath_ConfigNo
    winc p
endfunction
function! fp#Config()
    if s:findpath_ConfigOpen == 0
        call fp#ConfigOpen()
    else
        call fp#ConfigClose()
    endif
endfunction

function! fp#ListOpen()
    exec g:findpath_ListWindowSize.' '.g:findpath_DefaultConfigDir.g:findpath_DefaultList
    silent sort u
    w
    let s:findpath_ListOpen = 1
    let s:findpath_ListNo = bufnr('%')
endfunction
function! fp#ListClose()
    let s:findpath_ListOpen = 0
    exec 'bw '.s:findpath_ListNo
    winc p
endfunction
function! fp#List()
    if s:findpath_ListOpen == 0
        call fp#ListOpen()
    else
        call fp#ListClose()
    endif
endfunction

function! fp#AddCore()
    if !filereadable(g:findpath_DefaultConfigFile)
        let cmd = 'cp '.g:findpath_TemplateDir.g:findpath_DefaultConfigFile.' '.g:findpath_DefaultConfigFile
        call system(cmd)
        echo cmd
        let path = matchlist(system('pwd'), '\v(.*)\n')[1]
        call system('echo -e "'.path.'" >> '.s:findpath_DefaultList)
    else
        echo 'Project file already exists.'
    endif
endfunction

function! fp#Add()
    cd %:p:h
    call fp#AddCore()
endfunction

function! fp#Open()
    let path = getline('.')
    q
    exec 'cd '.path
    call g:_FPOpen(path)
    exec 'echo "Project Open:'.path.'"'
endfunction

function! fp#ProjectFileDelete()
    let path = getline('.')
    let path = path.'/'.g:findpath_DefaultConfigFile
    echo path
    call fp#Delete(path)
endfunction

function! fp#SetBufMapProjectList()
    set cursorline
    nnoremap <buffer><silent> e :FPOpen<CR>
    nnoremap <buffer><silent> <CR> :FPOpen<CR>
    nnoremap <buffer><silent> q :call fp#ListClose()<CR>
    nnoremap <buffer><silent> dd :FPProjectFileDelete<CR>dd:w<CR>
endfunction

function! fp#SetBufMapConfig()
    nnoremap <buffer><silent> q :bw %<CR>
    nnoremap <buffer><silent> q :call fp#ConfigClose()<CR>
endfunction

let &cpo = s:save_cpo
