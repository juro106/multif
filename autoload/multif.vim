let s:save_cpo = &cpo
set cpo&vim

function! multif#Forward(key) abort
    let line = getline('.')[col('.')-1:]
    return a:key . s:SetClosestChar(line)
endfunction

function! multif#Backward(key) abort
    let line = reverse(getline('.')[:col('.')-1])
    return a:key . s:SetClosestChar(line)
endfunction

function! s:SetClosestChar(line) abort
    let n = getchar(-1, #{cursor: 'keep'})
    let c = type(n) == type(0) ? nr2char(n) : n

    let list = has_key(g:multif_chars, c) ? g:multif_chars[c] : [c]
    let dict = {}
    for t in list
        let regex_pattern = '\C' . escape(t, '.*^$\[]~')
        let matchcol = match(a:line, regex_pattern, 1, 1)
        if matchcol > 0
            let dict[t] = matchcol
        endif
    endfor

    if empty(dict)
        return list[0]
    endif

    let min_key = ''
    let min_val = -1
    for [key, value] in items(dict)
        if min_val == -1 || value < min_val
            let min_val = value
            let min_key = key
        endif
    endfor
    return min_key
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
