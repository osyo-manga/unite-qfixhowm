scriptencoding utf-8
if exists('g:loaded_unite_qfixhowm')
  finish
endif
let g:loaded_unite_qfixhowm = 1

let s:save_cpo = &cpo
set cpo&vim


if !exists("*QFixListAltOpen")
	function! QFixListAltOpen(qflist, dir)
		return a:qflist
	endfunction
endif


let &cpo = s:save_cpo
unlet s:save_cpo
