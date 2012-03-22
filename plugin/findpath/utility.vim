"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/ProjectRoot.vim
"VERSION:  0.9
"LICENSE:  MIT

command! PRBrowse call prutility#BrowseURI()
command! -nargs=* -range PRPathAbs <line1>,<line2>call prutility#PathAbs(<f-args>)
command! -nargs=? PRCustomCmds call prutility#CustomCmds(<f-args>)
