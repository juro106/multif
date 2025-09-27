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
    for c in list
        let regex_pattern = '\C' . escape(c, '.*^$\[]~')
        let matchcol = match(a:line, regex_pattern, 1, 1)
        if matchcol > 0
            let dict[c] = matchcol
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

function multif#CheckConfig(dict)
    if type(a:dict) != v:t_dict | call s:ErrMsg('g:multif_chars', 'Only dictionary type can be used.') | return | endif
    let dict_str = split(trim(substitute(string(g:multif_chars), '], ', ']::', 'g'), '{}'), '::')
    echo 'g:multif_chars:'
    for l in dict_str
        echo l
    endfor
    for [key, list] in items(a:dict)
        if strchars(key) != 1 | call s:ErrMsg(key, 'Please set a single-character string as the dictionary key.') | return | endif
        if type(list) != v:t_list || len(filter(copy(list), 'type(v:val) != v:t_string')) > 0 | call s:ErrMsg(list, 'Dictionary values must be lists of single-character only') | return | endif
        if len(list) != strchars(join(list, '')) | call s:ErrMsg(list, 'Please set each element in the list to a single-character string.') | return | endif
    endfor
endfunction

function! s:ErrMsg(str, note) abort
    echohl ErrorMsg
    echom 'plugin multif.vim: custom key setting error.'
    echom  string(a:str) . ' ' . a:note
    echohl None
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
