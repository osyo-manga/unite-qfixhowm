scriptencoding utf-8

function! unite#sources#qfixhowm#define()
	return s:source
endfunction

let s:source = {
\	"name" : "qfixhowm",
\	"description" : "qfixhowm",
\	"action_table" : {
\		"delete" : {
\			"description" : "delete qfixmemo",
\			"is_selectable" : 1,
\			"is_invalidate_cache" : 1,
\			"is_quit" : 0
\		}
\	}
\}

function! s:source.action_table.delete.func(candidates)
	let input = input("Really force delete files? [yes/no]")
	if input == "yes" || input == "y"
		for candidate in a:candidates
			call delete(candidate.action__path)
		endfor
	endif
endfunction

function! s:source.gather_candidates(args, context)
	let tmp = get(g:, "QFixListAltOpen", 0)
	try
		let g:QFixListAltOpen = 1
		if get(a:args, 0, "") == "nocache"
			let list = qfixmemo#ListCmd("nocache")
		else
			let list = qfixmemo#ListCmd()
		endif
	finally
		let g:QFixListAltOpen = tmp
	endtry
	let new_memo = [{
\		"word" : "[ new memo ]",
\		"default_action" : "new_memo",
\		"kind" : "qfixlist_new_memo"
\	}]

	return new_memo + map(copy(list), '{
\		"word" : "(".fnamemodify(v:val.filename, ":t:r").") ".v:val.text,
\		"kind" : "file",
\		"action__path" : v:val.filename
\	}')
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

call unite#define_kind(s:kind)
unlet s:kind


if !exists("*QFixListAltOpen")
	function! QFixListAltOpen(qflist, dir)
		return a:qflist
	endfunction
endif

