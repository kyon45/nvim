# NEOVIM CONFIG

## Troubleshooting

### nvim.terminal `Error converting string from  to UTF-8`

#### Reproduction

- open `nvim`
- type `:terminal`
- then you got the following output:

  ```
  iconv: conversion from -t unsupported
  iconv: try 'iconv -l' to get the list of supportedencodings
  Error converting string from to UTF-8
  $ 
  ```

#### Probable Reason

> - [Broken cyrillic encoding in a terminal mode #17681 · neovim/neovim](https://github.com/neovim/neovim/issues/17681#issuecomment-1065823855)
> - [Neovim can't read UTF-8 characters](https://github.com/neovim/neovim/wiki/FAQ#neovim-cant-read-utf-8-characters)

#### Solution

Add `export LANG=en_US.UTF-8` to your shell profile

