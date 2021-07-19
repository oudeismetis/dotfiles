# dotfiles
the way I likes it *

## Some inspiration for my dotfiles approach came from: 
1. [JulianGindi](https://github.com/JulianGindi/dotfiles)
1. [akrawchyk](https://github.com/akrawchyk/dotfiles)
1. [josephabrahams](https://github.com/josephabrahams/dotfiles)
1. [nsmoot](https://github.com/nsmoot/dotfiles)
1. [holman](https://github.com/holman/dotfiles)
1. [RCM](https://github.com/thoughtbot/rcm)

## Installation

Install iterm2
Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install tmux
Karabiner needed(?) for caps locks remap
reattach-to-user-namespace no longer needed?
https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard/issues/66

Spellchecker misconfigured a little
https://thoughtbot.com/blog/vim-spell-checking

ag.vim is depricated
brew install the_silver_searcher
Switch toooo Ack? Something else?
https://github.com/ggreer/the_silver_searcher
https://github.com/rking/ag.vim

brew update
brew install python
python --version (should be 3)
pip3 --verison

If not pip3 then:
brew postinstall python
and/or
brew postinstall python3

then...
pip install --version pipenv

(might need to resource zsh)
pipenv --version

Add a .pythonrc file
https://github.com/whiteinge/dotfiles/blob/master/.pythonrc.py

Copy/Paste issues
https://evertpot.com/osx-tmux-vim-copy-paste-clipboard/
first step important to disable iterm. Everything else is either outdated knowledge or already accounted for in my config


```
brew install reattach-to-user-namespace
brew install pipenv
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
