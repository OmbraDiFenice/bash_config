#!/bin/bash

for file in $(ls -1 *.sh | grep -v setup.sh)
do
    grep "$file" ~/.bashrc 2>&1> /dev/null || echo "source $INSTALL_DIR/bash/$file" >> ~/.bashrc
done

source ~/.bashrc
