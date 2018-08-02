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
brew install reattach-to-user-namespace
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
```

zsh:
```
echo $SHELL
```

if not zsh:
```
chsh -s $(which zsh)
```

get the dotfiles:
```
git clone git@github.com:oudeismetis/dotfiles.git $HOME/.dotfiles
ln -s $HOME/.dotfiles/.bundle .bundle
ln -s $HOME/.dotfiles/.gemrc .gemrc
ln -s $HOME/.dotfiles/.git .git
ln -s $HOME/.dotfiles/.gitconfig .gitconfig
ln -s $HOME/.dotfiles/.gitmodule .gitmodule
ln -s $HOME/.dotfiles/.hgrc .hgrc
ln -s $HOME/.dotfiles/.vimrc .vimrc
ln -s $HOME/.dotfiles/.zshrc .zshrc
ln -s $HOME/.dotfiles/.tmux.conf .tmux.conf

pip install pylama
source $HOME/.zshrc
base16_tomorrow-night
vim $HOME/.vimrc
```

inside vim:
```
:source %
:PluginInstall
```

tmux config:
```
tmux source-file ~/.tmux.conf
```
