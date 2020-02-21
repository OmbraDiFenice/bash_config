#!/bin/bash

cp $INSTALL_DIR/vim/vimrc ~/.vimrc

git clone https://github.com/altercation/vim-colors-solarized.git
mkdir -p ~/.vim/colors
mv vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
rm -rf vim-colors-solarized

if [ ! -f ~/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall
