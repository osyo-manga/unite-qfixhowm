scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#qfixlist_new_memo#define()
	return s:kind
endfunction


let s:kind = {
\	"name" : "qfixlist_new_memo",
\	"default_action" : "new_memo",
\	"action_table" : {
\		"new_memo" : {
\			"is_selectable" : 0,
\		}
\	}
\}

function! s:kind.action_table.new_memo.func(candidates)
	tabnew
	call qfixmemo#EditNew()
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
