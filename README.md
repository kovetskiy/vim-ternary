vim-ternary
==========

Before:
```php
$blah = $arg == '42'
    ? 'blaaa'
    : 'bloooo';
```

After:
```php
$blah = 'bloooo';
if ($arg == '42') {
    $blah = 'blaaa';
}
```

Installation
===========

```viml
Plug 'kovetskiy/vim-ternary'
```

And add binding:
```
nnoremap <Leader>t :call RemoveTernaryOperator()<CR>
```
