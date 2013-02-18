let s:save_cpo = &cpo
set cpo&vim

function! unite#filters#sorter_qfixhowm_updatetime#define()
	return s:sorter
endfunction

let s:sorter = {
\	"name" : "sorter_qfixhowm_updatetime",
\	"description" : "file updatetime sorter"
\}

function! s:sorter.filter(candidates, context)
	return reverse(unite#util#sort_by(a:candidates, 'has_key(v:val, "action__path") ? getftime(v:val.action__path) : 0x7fffffff'))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
