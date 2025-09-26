if exists('g:loaded_multif')
	finish
endif
let g:loaded_multif = 1

let g:multi_chars = get(g:, 'multif_chars', {})

noremap <silent><expr><Plug>(multif-f) multif#Forward("f")
noremap <silent><expr><Plug>(multif-t) multif#Forward("t")
noremap <silent><expr><Plug>(multif-F) multif#Backward("F")
noremap <silent><expr><Plug>(multif-T) multif#Backward("T")

command! -nargs=0 MultifCheckConfig call multif#CheckConfig(g:multif_chars)

let s:user_keys = get(g:, 'multif_keys', {})
let s:default_keys = {'f': 'f', 't': 't', 'F': 'F', 'T': 'T'}

for [s:k, s:plug] in [['f','multif-f'], ['t','multif-t'], ['F','multif-F'], ['T','multif-T']]
    let s:key = get(s:user_keys, s:k, s:default_keys[s:k])
    execute 'nmap ' . s:key . ' <Plug>(' . s:plug . ')'
    execute 'xmap ' . s:key . ' <Plug>(' . s:plug . ')'
    execute 'omap ' . s:key . ' <Plug>(' . s:plug . ')'
endfor
