set shiftwidth=4
" set tabstop=4

" set equalprg=pg_format

let b:ale_fixers = {'sql': ['pgformatter']}
" let b:ale_sql_pgformatter_options = '--no-extra-line'
let b:ale_fix_on_save = 1
