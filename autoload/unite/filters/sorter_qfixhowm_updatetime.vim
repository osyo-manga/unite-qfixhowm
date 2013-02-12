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
	return [get(a:candidates, 0, {})] + reverse(unite#util#sort_by(a:candidates[1:], 'getftime(v:val.action__path)'))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
