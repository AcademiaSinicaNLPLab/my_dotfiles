#!/bin/bash

echo "Setting up the dotfiles..."
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv ${PWD##*/}/dotfiles/{} ../{}
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv dotfiles/{} {}

echo "Setting vim"
[ ! -d ~/.vim/autoload ] && mkdir -p ~/.vim/autoload
[ ! -f ~/.vim/autoload/plug.vim ] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Done"

echo "Setting neovim"
[ ! -d ~/.nvim/autoload ] && mkdir -p ~/.nvim/autoload
[ ! -f ~/.nvim/autoload/plug.vim ] && curl -fLo ~/.nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[ ! -d ~/.config ] && mkdir ~/.config
[ ! -h ~/.config/nvim ] && ln -s ~/.nvim ~/.config/nvim
[ ! -h ~/.config/nvim/init.vim ] && ln -s ~/.nvimrc ~/.config/nvim/init.vim
[ ! -h ~/.nvim/UltiSnips ] && ln -s ~/my_dotfiles/UltiSnips ~/.nvim/UltiSnips
echo "Done"
