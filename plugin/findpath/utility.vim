"AUTHOR:   Atsushi Mizoue <asionfb@gmail.com>
"WEBSITE:  https://github.com/AtsushiM/ProjectRoot.vim
"VERSION:  0.9
"LICENSE:  MIT

command! -nargs=* -range FPPathAbs <line1>,<line2>call fputility#PathAbs(<f-args>)
command! -nargs=? FPCustomCmds call fputility#CustomCmds(<f-args>)
