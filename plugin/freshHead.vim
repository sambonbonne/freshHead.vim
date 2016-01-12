"""
" @filename     freshHead.vim
" @author       Samuel DENIS
" @created      2012-10-03 23:53
" @modified     2013-04-05 00:46
" @description  Default values and plugin invokation
"""

if exists('g:freshHead_loaded')
    finish
endif


if !exists('g:freshHead_auto_enable')
    let g:freshHead_auto_enable=1
endif

if !exists('g:freshHead_author')
    let g:freshHead_author=$USER
endif

if !exists('g:freshHead_date_format')
    let g:freshHead_date_format='%Y-%m-%d %H:%M'
endif

if !exists('g:freshHead_prefix')
    let g:freshHead_prefix=''
endif


if g:freshHead_auto_enable
    call freshHead#enable()
endif


command AutoHeader call freshHead#make_header()
command AutoHeaderEnable call freshHead#enable()
command AutoHeaderDisable call freshHead#disable()
let g:freshHead_loaded=1.0
