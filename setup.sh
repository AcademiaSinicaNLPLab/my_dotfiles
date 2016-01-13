#!/bin/bash

echo "Setting up the dotfiles..."
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv ${PWD##*/}/dotfiles/{} ../{}
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv dotfiles/{} {}
echo "Setting neovim"
curl -fLo ~/.nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s ~/.nvim ~/.config/nvim
ln -s ~/.nvimrc ~/.config/nvim/init.vim
echo "Done"
