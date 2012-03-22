"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/findpath.vim
"VERSION:  0.9
"LICENSE:  MIT

let g:findpath_PluginDir = expand('<sfile>:p:h:h').'/'
let g:findpath_TemplateDir = g:findpath_PluginDir.'template/'
let g:findpath_TemplateBeforePath = ''

if !exists("g:findpath_DefaultConfigDir")
    let g:findpath_DefaultConfigDir = $HOME.'/.projectroot/'
endif
if !exists("g:findpath_DefaultConfigFile")
    let g:findpath_DefaultConfigFile = '.projectroot'
endif
if !exists("g:findpath_DefaultList")
    let g:findpath_DefaultList = '~ProjectRoot-List~'
endif
if !exists("g:findpath_DefaultConfig")
    let g:findpath_DefaultConfig = '~config.vim'
endif

" config
let s:findpath_DefaultConfig = g:findpath_DefaultConfigDir.g:findpath_DefaultConfig
if !filereadable(s:findpath_DefaultConfig)
    call system('cp '.g:findpath_TemplateDir.g:findpath_DefaultConfig.' '.s:findpath_DefaultConfig)
endif
exec 'source '.s:findpath_DefaultConfig

if !exists("g:findpath_UseUnite")
    let g:findpath_UseUnite = 0
endif
if !exists("g:findpath_ListWindowSize")
    let g:findpath_ListWindowSize = 'topleft 15sp'
endif
if !exists("g:findpath_ConfigWindowSize")
    let g:findpath_ConfigWindowSize = 'topleft vs'
endif

" config
let s:findpath_DefaultList = g:findpath_DefaultConfigDir.g:findpath_DefaultList
if !isdirectory(g:findpath_DefaultConfigDir)
    call mkdir(g:findpath_DefaultConfigDir)
endif
if !filereadable(s:findpath_DefaultList)
    call system('cp '.g:findpath_TemplateDir.g:findpath_DefaultList.' '.s:findpath_DefaultList)
endif

if !exists('g:_FPOpen')
    function g:_FPOpen(path)
        if g:findpath_UseUnite == 0
            e .
        else
            exec 'Unite -input='.a:path.'/ file'
        endif
    endfunction
endif

command! FPAdd call fp#Add()
command! FPInit call fp#Init()
command! FPList call fp#List()
command! FPConfig call fp#Config()
command! FPOpen call fp#Open()
command! FPProjectFileDelete call fp#ProjectFileDelete()

exec 'au BufRead '.g:findpath_DefaultList.' call fp#SetBufMapProjectList()'
exec 'au BufWinLeave '.g:findpath_DefaultList.' call fp#ListClose()'
exec 'au BufRead '.g:findpath_DefaultConfig.' call fp#SetBufMapConfig()'
exec 'au BufWinLeave '.g:findpath_DefaultConfig.' call fp#ConfigClose()'

if g:findpath_UseUnite == 1
    let s:unite_source = {
    \   'name': 'project',
    \ }
    function! s:unite_source.gather_candidates(args, context)
      let lines = readfile(g:findpath_DefaultConfigDir.g:findpath_DefaultList)
      return map(lines, '{
      \   "word": v:val,
      \   "source": "project",
      \   "kind": "command",
      \   "action__command": "cd ".v:val."|Unite -input=".v:val."/ file",
      \ }')
    endfunction
    call unite#define_source(s:unite_source)
    unlet s:unite_source
endif
