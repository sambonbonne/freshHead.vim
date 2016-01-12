"""
" @filename     freshHead.vim
" @author       Samuel DENIS
" @created      2012-10-03 23:53
" @modified     2016-01-12 22:28
" @description  Manage a little header comment block
"""



let s:style_list = [
            \    { 'style': ['/**', ' *', ' */'], 'ft': ['c', 'java', 'cpp', 'javascript', 'go', 'php', 'jsp'] ,
            \      'prefix': {
            \                 'php': '<?php',
            \                 'jsp': '<%',
            \                },
            \      'appendix': {
            \                   'jsp' : '%>',
            \                  }},
            \    { 'style': ['###', '#', '###'], 'ft': ['python', 'python.django', 'ruby', 'perl', 'sh', 'coffee'],
            \      'prefix': {
            \                 'python': '#!/usr/bin/env python',
            \                 'ruby':   '#!/usr/bin/env ruby',
            \                 'perl':   '#!/usr/bin/env perl',
            \                 'sh':     '#!/bin/sh',
            \                }},
            \    { 'style': ['"""', '"', '"""'],         'ft': ['vim', 'tex'] },
            \    { 'style': ['<!--', '  -', ' -->'],   'ft': ['html', 'md'] },
            \    { 'style': ['---[[', '', '---]]'], 'ft': ['lua']},
            \]


fun! s:insert_header_with_ft(ft)
    for styledict in s:style_list
        let ftlist = get(styledict,'ft')
        let indexofft = index(ftlist, a:ft)
        if indexofft >= 0
            let style = get(styledict,'style')
            let prefix = get(styledict,'prefix')
            let appendix = get(styledict,'appendix')
            let start_char = style[1]
            let start_line = 0
            let message_spacing = 0

            let messages=[['filename',    s:filename],
                        \ ['auhor',       g:freshHead_author],
                        \ ['description', '[NO DESCRIPTION]'],
                        \ ['created',     strftime(g:freshHead_date_format)],
                        \ ['modified',    '[NO MODIFICATION]'],]

            for message in messages
                let size=strlen(message[0])

                if size>message_spacing
                    let message_spacing=size
                endif
            endfor
            let g:freshHead_message_spacing=message_spacing

            if type(prefix) == type({})
                let prefix_by_ft = get(prefix,a:ft)
                if  type(prefix_by_ft)==type('') && len(prefix_by_ft)>0
                    call append(0 , prefix_by_ft)
                    let start_line += 2
                endif
            endif

            " start of comment block
            call append(start_line, style[0])
            let start_line += 1

            " core of comment block
            for message in messages
                " @TODO replace the %-12s with the max length of message[0]
                call append(start_line, start_char . ' ' . printf("%s%-" . message_spacing . "s  %s", g:freshHead_prefix, get(message,0), get(message,1)))
                let start_line += 1
            endfor

            " save cursor pos
            let endline = start_line

            " end of comment block
            call append(start_line, style[2])
            let start_line += 1

            " appendix
            if type(appendix)==type({})
                let appendix_by_ft = get(appendix,a:ft)
                if type(appendix_by_ft)==type('') && len(appendix_by_ft)
                    call append(start_line,appendix_by_ft)
                endif
            endif

            call append(start_line+1,'')

            " restore line
            call cursor(endline,0)
            exe "normal $"
            return 1
        endif
    endfor
    return 0
endfun


fun! freshHead#make_header()
    let s:filename=expand('%')
    call s:insert_header_with_ft(&ft)
endfun

fun! freshHead#enable()
    augroup freshHead
        autocmd!
        autocmd BufNewFile *.* call freshHead#make_header()
        autocmd Bufwritepre,filewritepre *.* call freshHead#update_modified_time()
    augroup END
endfun

fun! freshHead#disable()
    augroup freshHead
        autocmd!
    augroup END
endfun


fun! freshHead#update_modified_time()
    let cursor_pos = getpos('.')
    silent! exe "1," . 10 . "g/" . g:freshHead_prefix . "modified.*/s/" . g:freshHead_prefix . "modified.*/" . g:freshHead_prefix . "modified     " . strftime(g:freshHead_date_format)
    call setpos('.',cursor_pos)
endfun
