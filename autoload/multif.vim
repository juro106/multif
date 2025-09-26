let s:save_cpo = &cpo
set cpo&vim

function! multif#Forward(key) abort
    let list = s:GetTargetList(a:key)
    return a:key . s:SetForwardChar(list)
endfunction

function! multif#Backward(key) abort
    let list = s:GetTargetList(a:key)
    return a:key . s:SetBackwardChar(list)
endfunction

function! s:GetTargetList(key) abort
    let ch = s:InputChar()
    return has_key(g:multif_chars, ch) ? g:multif_chars[ch] : [ch]
endfunction

function! s:InputChar() abort
    let c = getchar(-1, #{cursor: 'keep'})
    return type(c) == type(0) ? nr2char(c) : c
endfunction

" f, t: select the character to use for forward search
function! s:SetForwardChar(list) abort
    let line = getline('.')[col('.')-1:]
    return s:SetClosestChar(line, a:list)
endfunction

" F, T: select the character to user for backward search
function! s:SetBackwardChar(list) abort
    let line = reverse(getline('.')[:col('.')-1])
    return s:SetClosestChar(line, a:list)
endfunction

" select the closest character in the current line
function! s:SetClosestChar(line, list) abort
    let dict = {}
    for c in a:list
        let regex_pattern = '\C' . escape(c, '.*^$\[]~')
        let matchcol = match(a:line, regex_pattern, 1, 1)
        if matchcol > 0
            let dict[c] = matchcol
        endif
    endfor

    if empty(dict)
        return a:list[0]
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
    echo g:multif_chars
    for [key, value] in items(a:dict)
        if s:IsOneChar(key) == 0
            call s:ErrMsg(key, 'Please set a single-character string as the dictionary key.')
            return
        endif
        if s:ListCheck(value) == 0
            call s:ErrMsg(value, 'Please set each element in the list to a single-character string.')
            return
        endif
    endfor
endfunction

function! s:IsOneChar(str) abort
    return strchars(a:str) != 1 ? 0 : 1
endfunction

function! s:ListCheck(list) abort
    return len(a:list) != strchars(join(a:list, '')) ? 0 : 1
endfunction

function! s:ErrMsg(str, note) abort
    echohl ErrorMsg
    echom 'plugin multif.vim: custom key setting error.'
    echom  string(a:str) . ' ' . a:note
    echohl None
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
