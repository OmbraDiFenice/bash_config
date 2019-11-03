DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source $DIR/bash/prompt.sh
source $DIR/bash/aliases.sh
source $DIR/bash/settings.sh

cp $DIR/vim/vimrc ~/.vimrc
