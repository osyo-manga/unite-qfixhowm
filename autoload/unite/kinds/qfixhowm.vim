scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! unite#kinds#qfixhowm#define()
	return s:kind
endfunction


let s:kind = {
\	"name" : "qfixhowm",
\	"default_action" : "open",
\	"action_table" : {
\		"delete" : {
\			"description" : "delete qfixmemo",
\			"is_selectable" : 1,
\			"is_invalidate_cache" : 1,
\			"is_quit" : 0
\		}
\	},
\	"parents" : ["file"],
\}

function! s:kind.action_table.delete.func(candidates)
	let input = input("Really force delete files? [yes/no]")
	if input == "yes" || input == "y"
		for candidate in a:candidates
			call delete(candidate.action__path)
		endfor
	endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
