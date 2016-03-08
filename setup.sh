#!/bin/bash

echo "Setting up the dotfiles..."
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv ${PWD##*/}/dotfiles/{} ../{}
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv dotfiles/{} {}

echo "Setting neovim"
[ ! -d ~/.nvim ] && mkdir ~/.nvim
[ ! -d ~/.config ] && mkdir ~/.config
[ ! -h ~/.config/nvim ] && ln -s ~/.nvim ~/.config/nvim
[ ! -h ~/.config/nvim/init.vim ] && ln -s ~/.nvimrc ~/.config/nvim/init.vim
[ ! -h ~/.nvim/UltiSnips ] && ln -s ~/my_dotfiles/UltiSnips ~/.nvim/UltiSnips
echo "Done"
