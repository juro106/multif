# vim-multif 

vim-multif slightly extends the functionality of [`ftFT`](https://github.com/vim/vim/blob/0d76683e094c6cac2e879601aff3acf1163cbe0b/runtime/doc/motion.txt#L254-L262).

Targets multiple characters—including multibyte ones—with a single key, moving to the nearest match. 

It eliminates the need to press `Shift` or `AltGr`, switch `IMEs`, or enter digraphs using `Ctrl+k`.

To avoid altering the default experience when using ftFT, this plugin does not support searches across multiple lines or provide a rich UI that highlights all candidates at once.

## Install

```
Plug 'juro106/vim-multif'
```

## Example Settings 

### Setting Target Characters

```
let g:multif_chars = { 
  'key1': ['char1', 'char2', ...],
  'key2': ['char1', 'char2', ...],
  ...
}
```

In the dictionary, both the keys (the keys you press) and the target characters (the characters each key maps to) must be single characters.

Nothing is set by default. Configure your `vimrc` as follows:

```
let g:multif_chars = {
  / '.': ['.', '。', '．'],
  / ',': [',', '、', '，'],
  / '"': ['"', '“', '”'],
  / 'a': ['a', 'á', 'à', 'â', 'ã', 'ä', 'å', 'æ', 'å'],
  / 'c': ['c', 'ç', '©'],
  / 'e': ['e', 'é', 'è', 'ê', 'ë'],
  / 'i': ['i', 'í', 'ì', 'î', 'ï'],
  / 'n': ['n', 'ñ'],
  / 'o': ['o', 'ó', 'ò', 'ô', 'ö', 'õ', 'ø'],
  / 's': ['s', 'ß', '§'],
  / 'u': ['u', 'ú', 'ù', 'û', 'ü'],
  / 'y': ['y', 'ý','ÿ'],
  / '[': ['[', '「', '『'],
  / ']': [']', '」', '』'],
  / '!': ['!', '¡'],
  / '?': ['?', '¿'],
  / '5': ['5', '€'],
  / 'm': ['m', 'μ']
  / }
```

With this configuration, in **normal mode** or **visual mode**, pressing `fe (vfe)` moves the cursor to the character in the configured list (`e`, `é`, `è`, `ê`, `ë`) that is closest to the cursor.

Repetition with `;` and `,` works just like the default behavior.

The same behavior applies to operations like `dfe`, `cte`, and `yfe`, whether in **operator-pending mode**.

Delete operations with `d` and `c` can be repeated with . exactly as in the default behavior.

### Key Mappings

By default, ftFT functions as is. To assign a different key, for example, configure your `vimrc` as follows:

```
let g:multif_keys = {
  / 'f': '<Space>f'
  / 't': '<Space>t'
  / 'F': '<Space>F'
  / 'T': '<Space>T'
  / }
```

## Troubleshooting

```
:MultifCheckConfig
```

Enter **command-line mode** and run the command above to check the currently configured characters. The plugin will review your settings and display details of any errors it finds.
