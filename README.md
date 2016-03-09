# One-Key Operation Dotfiles

Settings about my:
* .nvimrc
* .zshrc
* .gitconfig
* .tmux.conf
* .vimperatorrc

## Philosophy
* One-key installation. Simply run
```bash
$ ./setup.sh # everything is done

```

* No framework (particularly, oh-my-zsh). Control everything yourself.

* One setting one file. Every setting file should work well itself.
    * Use package manager for [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) and zsh


## Neovim

### Features
1. Automatically install package manager [vim-plug](https://github.com/junegunn/vim-plug)
2. Plugins:
    1. Syntax checker: neomake
    2. Syntax highlighter: rainbow
    3. Syntax indent: vim-python-pep8-indent', indent-line
    4. Git wrapper: vim-fugitive, gv
    5. Snippets: ultisnips, vim-snippets
    6. Fancy UI: vim-airline
    7. Automatic complteion: deoplete
    8. File browsing: nerdtree, fzf
    9. Utility: undotree, vim-easy-align, tabular, vim-yankstack, taboo, ag, vim-textobj-user


### Work Flow
Everyone (should) has his own work flow. My nvimrc fits best for my own.

#### Principles
1. Use neovim as tmux (unless you want to run program on remote servers after you log off.)
2. Use tab (:tabedit) instead of window.
3. The only time to split a new window is when you want to open a terminal (:term)

#### Workflow
1. Open neovim with nerdtree
```bash
$ nvim .
```
2. Open file from nerdtree in new tab, one tab for one file (keybinding `t`)
3. Unfold directory in nerdtree with `<Space>`
3. When switching between tabs, the working directory will be automatically changed
4. When you want to execute shell commands, split a new vertical window (keybinding `Alt+e`)
5. When you need more than two shell in a window, split a new horizontal window (keybinding `Alt+o`)
6. When you want to execute shell commands in the same tab with nerdtree, first move cursor to the specific directory, then press `Enter` key.  
The working directory will then changed. And then you just splite a new vertical window (keybinding `Alt+e`)
7. If you just want a new shell in a new tab, just press `Alt+t`

#### Moving Around
1. Tab is used intensively. So tab switching deserves a hotkey
    * `Ctrl+h`, `Ctrl+l` to move to the left or right tab
    * `Ctrl+Alt+h`, `Ctrl+Alt+l` to move current tab to left or right
2. Never leave your hjkl
    * Exit commandmode, insertmode, terminalmode, back to normal mode using `jk` (use `Enter` for visual mode instead)
    * `Alt+h`, `Alt+l` to move to line begin or line end (this also work for visual mode, and my zshrc also has binding to make this work for terminalmode)
    * `ctrl+j`, `ctrl+k` to move to the next or previous blank line (the same in visual mode)
    * `ctrl+j`, `ctrl+k` bind to <Down> or <Up> in commandmode and terminalmode

#### Terminal mode
* `Alt+e`, `Alt+o`, `Alt+t` to open new shell in vertical window, horizontal window, or a new tab
* Exit terminal mode and switch to other window with `Ctrl+a` (bind to vim's `Ctrl+w`)

#### Folding
* `<Space>` to unfold
* `<Space>` to open directory in nerdtree
