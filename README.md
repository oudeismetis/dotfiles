# dotfiles
the way I likes it *

## Some inspiration for my dotfiles approach came from: 
1. [JulianGindi](https://github.com/JulianGindi/dotfiles)
1. [akrawchyk](https://github.com/akrawchyk/dotfiles)
1. [josephabrahams](https://github.com/josephabrahams/dotfiles)
1. [nsmoot](https://github.com/nsmoot/dotfiles)
1. [holman](https://github.com/holman/dotfiles)
1. [RCM](https://github.com/thoughtbot/rcm)

## Instalation
```
cd ~
mkdir dev
cd dev
git clone git@github.com:oudeismetis/dotfiles.git
ln -s ~/dev/dotfiles/.bundle .bundle
ln -s ~/dev/dotfiles/.gemrc .gemrc
ln -s ~/dev/dotfiles/.git .git
ln -s ~/dev/dotfiles/.gitconfig .gitconfig
ln -s ~/dev/dotfiles/.gitmodule .gitmodule
ln -s ~/dev/dotfiles/.hgrc .hgrc
ln -s ~/dev/dotfiles/.vimrc .vimrc
ln -s ~/dev/dotfiles/.zshrc .zshrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
pip install pylama
source ~/.zshrc 
vim ~/.vimrc
```

inside vim:
```
:source %
:PluginInstall
```

tmux config:
```
tmux source ~/.dotfiles/.tmux.conf
```
