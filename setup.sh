#!/bin/bash

echo "Setting up the dotfiles..."
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv ${PWD##*/}/dotfiles/{} ../{}
find dotfiles -name ".*" | cut -d / -f 2 | xargs -i ln -sfv dotfiles/{} {}
echo "Done"
