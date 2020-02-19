#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cat >> ~/.bashrc<<EOF
source $DIR/bash/prompt.sh
source $DIR/bash/aliases.sh
source $DIR/bash/settings.sh
EOF

cp $DIR/vim/vimrc ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall

git/setup.sh
