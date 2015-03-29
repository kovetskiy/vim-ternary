function! Strip(input_string)
    return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! RemoveTernaryOperator()
    let lineNr = line('.')
    let startLineNr = lineNr

    let line = getline(lineNr)
    let content = line 
    while line !~ ";"
        let lineNr = lineNr + 1
        let line = getline(lineNr)

        let content = content . " " . line
    endwhile

    let content = substitute(content, '\(.*\) = \(.*\) ? \(.*\) : \(.*\);',
\ '\= Strip(submatch(1)) . " = " . Strip(submatch(4)) . ";\n" . '
\ . '"if (" . Strip(submatch(2)) . ") {\n" . Strip(submatch(1)) . " = " . Strip(submatch(3)) . ";" . '
\ . '"\n}"', "g")

    let ddcount = lineNr - startLineNr + 1
    execute "normal" . ddcount . "dd"

    set paste
    execute "normal O" . content
    set nopaste

    let curLineNr = line('.')
    let pcount = curLineNr - startLineNr

    echo pcount
    execute "normal " . startLineNr . "gg"
    execute "normal V" . pcount . "j="
endfunction!
