#!/bin/bash

for file in $(ls -1 "$INSTALL_DIR/bash/"*.sh | grep -v setup.sh)
do
    grep "$file" ~/.bashrc 2>&1> /dev/null || echo "source $file" >> ~/.bashrc
done

source ~/.bashrc
