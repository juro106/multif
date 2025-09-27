# vim-multif 

vim-multif slightly extends the functionality of [`ftFT`](https://github.com/vim/vim/blob/0d76683e094c6cac2e879601aff3acf1163cbe0b/runtime/doc/motion.txt#L254-L262).

Targets multiple characters—including multibyte ones—with a single key, moving to the nearest match. 

It eliminates the need to press `Shift` or `AltGr`, switch `IMEs`, or enter digraphs using `Ctrl+k`.

To avoid altering the default experience when using ftFT, this plugin does not support searches across multiple lines or provide a rich UI that highlights all candidates at once.

## Install

```
Plug 'juro106/vim-multif'
```

## Configuration



### Setting Custom Target Characters

Define your own dictionary of target characters for each key:

```
let g:multif_chars = { 
  \ 'key1': ['char1', 'char2', ...],
  \ 'key2': ['char1', 'char2', ...],
  \ ...
  \ }
```

Both the keys (the keys you press) and the target characters (the characters each key maps to) must be single characters.

There are no default targets, so this step is required.

Below is an example configuration to illustrate how you might set up your own target characters:

```
Example:

let g:multif_chars = {
  \ 'a': ['a', 'á', 'à', 'â', 'ã', 'ä', 'å', 'æ', 'å'],
  \ 'c': ['c', 'ç', '©'],
  \ 'e': ['e', 'é', 'è', 'ê', 'ë'],
  \ 'i': ['i', 'í', 'ì', 'î', 'ï'],
  \ 'n': ['n', 'ñ'],
  \ 'o': ['o', 'ó', 'ò', 'ô', 'ö', 'õ', 'ø'],
  \ 's': ['s', 'ß', '§'],
  \ 'u': ['u', 'ú', 'ù', 'û', 'ü'],
  \ 'y': ['y', 'ý','ÿ'],
  \ '.': ['.', '。', '．'],
  \ ',': [',', '、', '，'],
  \ '"': ['"', '“', '”'],
  \ '[': ['[', '「', '『'],
  \ ']': [']', '」', '』'],
  \ '!': ['!', '¡'],
  \ '?': ['?', '¿'],
  \ '5': ['5', '€'],
  \ 'm': ['m', 'μ']
  \ }
```

With this configuration, in **normal mode** or **visual mode**, pressing `fe (or vfe)` moves the cursor to the character in the configured list (`e`, `é`, `è`, `ê`, `ë`) that is closest to the cursor.

Repetition with `;` and `,` works just like the default behavior, and also supports counts.

The same behavior applies to operations like `dfe`, `cte`, and `yfe` in **operator-pending mode**.

Delete operations with `d` or `c` can be repeated with `.` exactly as in the default behavior, and also supports counts.

### Setting Custom Key Mappings

Choose which keys trigger the plugin’s actions. By default, ftFT functions as is. To assign a different key, for example, configure your `vimrc` as follows:

```
let g:multif_keys = {
  \ 'f': '<Space>f'
  \ 't': '<Space>t'
  \ 'F': '<Space>F'
  \ 'T': '<Space>T'
  \ }
```

### Additional Examples of Custom Target Characters

#### Multibyte:
```
let g:multif_chars = {
  \ '.': ['.', '。', '．'],
  \ ',': [',', '、', '，'],
  \ '[': ['[', '「', '『', '【'],
  \ ']': [']', '」', '』', '】'],
  \ '1': ['1', '１', '！', '¡'],
  \ '2': ['2', '２', '＠'],
  \ '3': ['3', '３', '＃'],
  \ '4': ['4', '４', '＄', '£', '¤'],
  \ '5': ['5', '５', '％', '€'],
  \ '6': ['6', '６', '^'],
  \ '7': ['7', '７', '&'],
  \ '8': ['8', '８', '＊', '※'],
  \ '9': ['9', '９', '（'],
  \ '0': ['0', '０', '）'],
  \ '/': ['/', '？', '・', '／'],
  \ '\': ['\', '￥', '¥'],
  \ '~': ['~', '〜'],
  \ "'", ["'", '‘', '’']
  \ '"': ['"', '“', '”'],
  \ ';': [';', '；']
  \ ':': [':', '：']
  \ 'm': ['m', 'μ']
  \ }
```

#### Shift-Free:
```
let g:multif_chars = {
  \ '1': ['1', '!', '¡'],
  \ '2': ['2', '@', '²'],
  \ '3': ['3', '#', '³'],
  \ '4': ['4', '$', '£', '¤'],
  \ '5': ['5', '%', '€'],
  \ '6': ['6', '^'],
  \ '7': ['7', '&'],
  \ '8': ['8', '*'],
  \ '9': ['9', '('],
  \ '0': ['0', ')'],
  \ ';': [';', ':'],
  \ "'": ["'", '"'],
  \ '/': ['/', '?', '¿'],
  \ '.': ['.', '>'],
  \ ',': [',', '<'],
  \ '-': ['-', '_'],
  \ '=': ['=', '+'],
  \ '[': ['[', '{'],
  \ ']': [']', '}'],
  \ '`': ['`', '~'],
  \ '\': ['\', '|'],
  \ }
```

#### Multi-Symbol Navigation:
```
let g:multif_chars = {
  \ ';': [';', ':', '!', '@', '#', '$', '%', '^', '&', '*', '?', '~']
  \ '[': ['[', '(', '{', '<' ]
  \ ']': [']', ')', '}', '>' ]
  \ }
```

#### Japanese:
```
let g:multif_chars = {
  \ '.': ['.', '。', '．'],
  \ ',': [',', '、', '，'],
  \ 't': ['t', 'て'],
  \ 'i': ['i', 'に'],
  \ 'w': ['w', 'を'],
  \ 'h': ['h', 'は'],
  \ 'n': ['n', 'の'],
  \ 'g': ['g', 'が'],
  \ 'd': ['d', 'で'],
  \ 'r': ['r', 'る'],
  \ 'o': ['o', 'と'],
  \ 'e': ['e', 'へ'],
  \ 's': ['s', 'す'],
  \ 'k': ['k', 'か'],
  \ 'm': ['m', 'も'],
  \ '[': ['[', '「', '『', '【'],
  \ ']': [']', '」', '』', '】'],
  \ '1': ['1', '１', '！'],
  \ '2': ['2', '２', '二'],
  \ '3': ['3', '３', '三'],
  \ '4': ['4', '４', '四'],
  \ '5': ['5', '５', '五'],
  \ '6': ['6', '６', '六'],
  \ '7': ['7', '７', '七'],
  \ '8': ['8', '８', '八', '※'],
  \ '9': ['9', '９', '九'],
  \ '0': ['0', '０', '零'],
  \ '/': ['/', '？'],
  \ '\': ['\', '￥'],
  \  }
```

## Troubleshooting

```
:MultifCheckConfig
```

Enter **command-line mode** and run the command above to check the currently configured characters. The plugin will review your settings and display details of any errors it finds.
