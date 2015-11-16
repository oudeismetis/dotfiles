export PLATFORM=`uname -s`
mkdir -p ~/.zsh/cache

#Source all of our zsh files
export ZSH=~/.dotfiles/zsh
typeset -U config_files
config_files=($ZSH/*.zsh)

# Load all additional files
for file in $config_files
do
  source $file
done

# path
PATH="/usr/local/sbin:/usr/local/bin:$PATH"
PATH="$PATH:/sbin"
PATH="$PATH:$HOME/bin"
export PATH

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

# ls colors
if [ $PLATFORM = FreeBSD ] || [ $PLATFORM = Darwin ]; then
  CLR_DIR=Ex
  CLR_SYM_LINK=Gx
  CLR_SOCKET=Fx
  CLR_PIPE=dx
  CLR_EXE=Cx
  CLR_BLOCK_SP=Dx
  CLR_CHAR_SP=Dx
  CLR_EXE_SUID=hb
  CLR_EXE_GUID=ad
  CLR_DIR_STICKY=Ex
  CLR_DIR_WO_STICKY=Ex
  LSCOLORS="$CLR_DIR$CLR_SYM_LINK$CLR_SOCKET$CLR_PIPE$CLR_EXE$CLR_BLOCK_SP"
  LSCOLORS="$LSCOLORS$CLR_CHAR_SP$CLR_EXE_SUID$CLR_EXE_GUID$CLR_DIR_STICKY"
  LSCOLORS="$LSCOLORS$CLR_DIR_WO_STICKY"
  export LSCOLORS
  export CLICOLOR="YES"
fi

# aliases
if [ $PLATFORM = Linux ]; then
  alias ls='ls -F --color=auto'
else
  alias ls='ls -FG'
  alias top='top -ocpu'
fi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias dir='ll'
alias l='ll'
alias ll='ls -lh'
alias la='ls -A'
alias vi='vim'
if [ -x /usr/local/bin/mvim ]; then
  alias vim='mvim -v'
fi
alias s='screen'
alias tree='tree -C --dirsfirst'
alias rmpyc='find . -name "*.pyc" -delete'
alias ddu='find . -maxdepth 1 -type d -exec du -s {} \;'
alias unix2dos='recode lat1..ibmpc'
alias dos2unix='recode ibmpc..lat1'
alias t='vim -c ":$" ~/.todo'
alias todo='cat ~/.todo'
alias p='ping www.make.sh'

# viewing / editing
export PAGER='less'
export EDITOR='vim'
export MUTT_EDITOR='vim'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-tomorrow.dark.sh"
#BASE16_SHELL="~/.dotfiles/colors/base16-tomorrow.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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
export VIRTUAL_ENV_DISABLE_PROMPT=y
_virtualenv_prompt () {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "$reset_color workon$fg[green]" `basename "$VIRTUAL_ENV"`
  fi
}
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
%(?..[%{$fg[red]%}%?%{$reset_color%}] )%{$fg[magenta]%}%m%{$reset_color%}: %{$fg[cyan]%}%~$(_virtualenv_prompt)
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

export VAGRANT_DEFAULT_PROVIDER=vmware_fusion
