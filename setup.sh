DIR=$(cd $(dirname $0); pwd)

# git
git config --global color.ui true

# vim
ln -sf $DIR/.vim ~/.vim
ln -sf $DIR/.vim/.vimrc ~/.vimrc
