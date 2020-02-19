#!/bin/bash

cat >> ~/.bashrc<<EOF
source $DIR/bash/prompt.sh
source $DIR/bash/aliases.sh
source $DIR/bash/settings.sh
EOF

source ~/.bashrc
