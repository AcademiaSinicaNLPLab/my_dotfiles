#!/bin/bash

echo "Setting up the dotfiles..."
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv ${PWD##*/}/dotfiles/{} ../{}
echo "Done"
echo "Switch to ZSH"
chsh -s $(which zsh)
echo "Please re-login"
