# pyenv
PYENV_DIR="$HOME/.pyenv"
if [ -d "$PYENV_DIR" ]; then
  export PATH="$PYENV_DIR/bin:$PATH"
  if which pyenv > /dev/null; then
    eval "$(pyenv init -)";
  fi
fi

# virtualenv
export WORKON_HOME=~/Envs
mkdir -p $WORKON_HOME
# source /usr/local/bin/virtualenvwrapper.sh

# pip
if which pip >/dev/null 2>&1; then
  if [ ! -f ~/.zsh/cache/pip_completion ]; then
    pip completion --zsh | egrep -v '^\s*(#|$)' > ~/.zsh/cache/pip_completion 2>/dev/null
  fi

  . ~/.zsh/cache/pip_completion

  export PIP_RESPECT_VIRTUALENV=true
fi

# functions
abspath () {
  # abspath <directory>
  # Print the absolute path to a given file (using Python's `os.path.abspath()`).
  python -c 'import os, sys; print os.path.abspath(sys.argv[1])' "$@"
}

python_lib () {
  # python_lib
  # Print the full path to the current Python site-packages directory.
  echo `python -c 'import distutils.sysconfig; print distutils.sysconfig.get_python_lib()'`
}

pylink () {
  # pylink <package/module>
  # Symlink a Python package/module into the site-packages directory.
  ln -s $(abspath `pwd`/"$1") `python_lib`/`basename "$1"`
}

pyunlink () {
  # pyunlink <package/module>
  # Remove the link to a Python package/module from the site-packages directory.
  unlink `python_lib`/`basename "$1"`
}
