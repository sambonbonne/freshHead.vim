<!--
  - @filename     README.md
  - @author       Samuel DENIS
  - @created      2012-10-04 01:10
  - @modified     2016-01-12 23:07
  - @description  Some infos about freshHead.vim
 -->

# freshHead.vim

## Quick introduction

freshHead.vim is a helper plugin which insert and update a file header comment block. I know, some plugins do it great.
But I needed/wanted something more specific.

### Why ?

At work, I need to add and update a header for each file of code. I found a [good plugin](https://github.com/shanzi/autoHEADER) for Vim to do it automatically, but I needed to edit it to follow my team's standard so I started to mofidy it and after some changes, I decided to fork it.

But not only to follow my standard, I want to create something more customizable which can be configured in a greater way.
There is a lot of work to do but I hope that at the end, I would get a practical plugin.

## How do it look like ?

Here is some examples of what it generate, with a configured prefix '@'. The header are not bloated, I think there is just what we need.

``` python
#!/usr/bin/env python

###
# @filename     some_python.py
# @author       Samuel DENIS
# @created      2016-01-11 22:33
# @modified     YYYY-MM-DD
# @description  Here you put what this file contains
###
```

```php
<?php

/**
 * @filename     some_php.php
 * @author       Samuel DENIS
 * @created      2016-01-11 22:33
 * @modified     YYYY-MM-DD
 * @description  Here you put what this file contains
 */
```

## Install

Install it as you want, personnaly I use vim-plug but your favorite plugin manager should work.
If not, tell me, I'll try it !

So for me, I just need to add `Plug 'smumu/freshHead.vim'` in my vimrc and run `:PlugInstall`

## Usage

Configure it and here you go. I know you don't want to lose your time with this, you just want to have your header generated and updated automatically.
But remember that **this plugin won't add headers to existing files**, so you should copy one of a new file you created and change the needed informations.

### Config

1. `g:freshHead_auto_enable`
    Decide whether freshHead will be auto loaded when vim launches, default is 1.
2. `g:freshHead_author`
    The author name displayed follows _author_ , the default value is your $USER environment varible.
3. `g:freshHead_date_format`
    The date format used for _created_ and _modified_ fields (passed to strftime so be carefull to respect the format)
4. `g:freshHead_prefix`
    An eventual prefix before metadata (for example, '@')

## What's next ?

I have some ideas. I don't know when I'll do it, in which order, but I think that's features which can be usefull.

  - create helptags for config variables (this is the first thing I need to do)
  - replace some hard-coded spaces in the update_modified_time function
  - configure the name of each metadata (I think this is the more important)
  - let the possibility to enable/disable some fields ?
    * this can be usefull but before, maybe a refactor of the styles/ft variable is needed ...
  - add some others usefull fields (last )
  - some other things which will come later
