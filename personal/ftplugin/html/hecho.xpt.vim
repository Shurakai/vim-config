" These snippets work only in html context of php file
if &filetype != 'php'
    finish
endif

XPTemplate priority=lang-2

" this is html-scope variable independent
if exists( 'php_noShortTags' )
    XPTvar $PHP_TAG php
else
    XPTvar $PHP_TAG
endif

XPT hecho " Echo with opening and closing php-tags.
<?php echo `value^; ?>
