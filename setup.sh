DIR=$(cd $(dirname $0); pwd)

# git
git config --global color.ui true
# submoduleの導入
git submodule init
git submodule update


# vim
ln -sf $DIR/.vim ~/.vim
ln -sf $DIR/.vim/.vimrc ~/.vimrc

# tmux
sudo yum install tmux
ln -sf $DIR/tmux.conf ~/.tmux.conf

# zshrc
if [ -e ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -sf $DIR/zshrc ~/.zshrc
