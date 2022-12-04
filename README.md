# perldoc + Floaterm

![Example](https://github.com/dzangfan/perldoc-float-vim/blob/master/demo/example.gif)

This package is focked from [perldoc-vim](https://github.com/hotchpotch/perldoc-vim), and features [float terminal](https://github.com/voldikss/vim-floaterm) which allows you to `perldoc` as if in console.

## Installation

Install [Floaterm](https://github.com/voldikss/vim-floaterm) and ensure it works properly, in addition to your `perldoc` binary. You can test them briefly by

```bash
:FloatermNew
```

and

```bash
perldoc -f say
```

Then, install this package by package managers you are using. For example, in [vim-plug](https://github.com/junegunn/vim-plug), add

```vim
Plug 'dzangfan/perldoc-float-vim'
```

to your plug-section and execute `:PlugInstall`.

## Usage

The basic (and only) command is `Perldoc`, which accepts a builtin function name(e.g. `say`), package path(e.g. `List::Util`) or special variable(e.g. `$/`) and displays corresponding documents if exists. If no argument is provided, `Perldoc` will pick the word your cursor is pointing up. By default, we do not provide any `keymap`. So if you want the effect in our demo, add

```vim
nnoremap <silent> * :Perldoc<CR>
```

to your configuration(i.e. `.vimrc`, `init.vim`, etc.).
