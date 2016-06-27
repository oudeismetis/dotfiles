# path

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/sbin:/Users/edwardromano/bin:/sbin:/Users/edwardromano/bin"
export PATH
mkdir -p ~/.zsh/cache

#Source all of our zsh files
export ZSH=~/.dotfiles/zsh
typeset -U config_files
config_files=($ZSH/*.zsh)

export PLATFORM=`uname -s`

# Load all additional files
for file in $config_files
do
  source $file
done

# languages
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE=C

# completion
autoload -U compinit; compinit
_fab_list() {
  reply=(`fab --shortlist`)
}
compctl -K _fab_list fab
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # match uppercase from lowercase

# viewing / editing
export PAGER='less'
export EDITOR='vim'
export MUTT_EDITOR='vim'

autoload colors; colors # ANSI color codes

# history
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.zsh/history
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# prompt
_git_prompt () {
  test -z "$(pwd | egrep '/\.git(/|$)')" || return
  local _git_branch="`git branch 2>/dev/null | egrep '^\*' | sed 's/^\* //'`"
  test -z "$_git_branch" && return
  local _git_status=`git status --porcelain | sort | awk '
    BEGIN { modified = 0; staged = 0; new = 0; }
    /^ / { modified += 1 }
    /^[^\? ]/ { staged += 1 }
    /^\?/ { new += 1 }
    END {
      if (staged) { print "∆"; exit }
      if (modified) { print "∂"; exit }
      if (new) { print "≈"; exit }
    }'`
  if [[ -n $_git_status ]]; then
    _git_status=":%F{yellow}$_git_status%f]"
  else
    _git_status="]  "
  fi
  echo -n "[%F{gray}±%f:%F{blue}$_git_branch%f$_git_status"
}
export PROMPT='
%(?..[%{$fg[red]%}%?%{$reset_color%}] )%{$fg[magenta]%}%m%{$reset_color%}: %{$fg[cyan]%}%~
%{$fg[yellow]%}$%{$reset_color%} '
if which git >/dev/null 2>&1; then
  RPROMPT='$(_git_prompt)'
fi
setopt PROMPT_SUBST # perform substitution/expansion in prompts

# python
if [ -f ~/.pythonrc ]; then
  export PYTHONSTARTUP=~/.pythonrc
fi

# ruby
RBENV_DIR="$HOME/.rbenv"
if [ -d "$RBENV_DIR" ]; then
  export PATH="$RBENV_DIR/bin:$PATH"
  if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)"
  fi
fi

# nvm - node version manager
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh

# npm
NPM_PACKAGES_DIR="$HOME/.npm-packages"
if [ -d "$NPM_PACKAGES_DIR" ]; then
  export PATH="$PATH:$NPM_PACKAGES_DIR/bin"
fi

# user-dependent settings
# if [[ "`id -u`" -eq 0 ]]; then
#   umask 022
# else
#   umask 077
# fi

# local settings
if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi

# export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
