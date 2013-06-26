scriptencoding utf-8

function! unite#sources#qfixhowm#define()
	return [s:source, s:source_new]
endfunction

let s:source = {
\	"name" : "qfixhowm",
\	"description" : "qfixhowm",
\	"action_table" : {"qfixhowm" : {} }
\}

let s:source.action_table["qfixhowm"].preview = {
\	"description" : "preview qfixhowm text",
\	"is_quit" : 0,
\}


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

	return map(copy(list), '{
\		"word" : "(".fnamemodify(v:val.filename, ":t:r").") ".v:val.text,
\		"kind" : "qfixhowm",
\		"action__path" : v:val.filename
\	}')
endfunction

function! s:source.action_table["qfixhowm"].preview.func(candidate)
	if filereadable(a:candidate.action__path)
		call unite#util#smart_execute_command('pedit', a:candidate.action__path)
	endif
endfunction


if !exists("*QFixListAltOpen")
	function! QFixListAltOpen(qflist, dir)
		return a:qflist
	endfunction
endif


let s:source_new = {
\	"name" : "qfixhowm/new",
\	"description" : "qfixhowm new",
\}


function! s:source_new.gather_candidates(args, context)
	return [{
\		"word" : "[ new memo ]",
\		"default_action" : "new_memo",
\		"kind" : "qfixlist_new_memo"
\	}]
endfunction



let g:unite_qfixhowm_new_memo_cmd = get(g:, "unite_qfixhowm_new_memo_cmd", "")



