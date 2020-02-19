#!/bin/bash

cat >> ~/.bashrc<<EOF
source $INSTALL_DIR/bash/prompt.sh
source $INSTALL_DIR/bash/aliases.sh
source $INSTALL_DIR/bash/settings.sh
EOF

source ~/.bashrc
