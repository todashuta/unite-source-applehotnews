" unite source Apple Hot News


let s:save_cpo = &cpo
set cpo&vim

function! unite#sources#applehotnews#define()
  " TODO: [s:source_hotnews, s:source_pr]
  return s:source
endfunction

function! unite#sources#applehotnews#open_url(url)
  " TODO: windows, linux
  call system('open "' . a:url . '" &')
endfunction

let s:source = {
      \   'name': 'applehotnews',
      \   'description': 'Apple Hot News',
      \ }
let s:hotnews = []

function! s:source.gather_candidates(args, context)
  if empty(s:hotnews)
    let res = webapi#feed#parseURL('https://www.apple.com/jp/main/rss/hotnews/hotnews.rss')
    for i in res
      call add(s:hotnews, {'title': i.title, 'link': i.link})
    endfor
  endif
  return map(copy(s:hotnews), '{
        \   "word": v:val["title"],
        \   "source": "applehotnews",
        \   "kind": "command",
        \   "action__command": "call unite#sources#applehotnews#open_url(''" . v:val["link"] . "'')",
        \ }')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
