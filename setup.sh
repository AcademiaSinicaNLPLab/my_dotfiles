#!/bin/bash

echo "==Linking dotfiles=="
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sf $PWD/dotfiles/{} ~/{}
find dotfiles ! -path dotfiles -type d | cut -d / -f 2 | xargs -i ln -sf $PWD/dotfiles/{} ~/{}

echo "==Setting vimfx=="
mv ~/vimfx ~/.config/

echo "==Setting neovim=="
# Make nvim setting accessible at both ~/.config (mandatory) and ~/.nim (for convience)
[ ! -d ~/.nvim ] && mkdir ~/.nvim
[ ! -d ~/.config ] && mkdir ~/.config
[ ! -h ~/.nvim/UltiSnips ] && ln -s ./UltiSnips ~/.nvim/UltiSnips
[ ! -h ~/.config/nvim ] && ln -s ~/.nvim ~/.config/nvim
[ ! -h ~/.config/nvim/init.vim ] && ln -s ~/.nvimrc ~/.config/nvim/init.vim
# Installing neovim plugins...
nvim -c "q" 

