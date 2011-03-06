# Better prompt, in color and showing current git branch

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " "${ref#refs/heads/}
}

COLOR_BLACK="\033[0;30m"
COLOR_BLUE="\033[0;34m"
COLOR_GREEN="\033[0;32m"
COLOR_CYAN="\033[0;36m"
COLOR_RED="\033[0;31m"
COLOR_PURPLE="\033[0;35m"
COLOR_BROWN="\033[0;33m"
COLOR_GRAY="\033[0;37m"

# Show hostname in user-specified color

function ps_hostname {
  if [ -n "${PSCOLOR}" ]; then
    echo -en $PSCOLOR
  else
    echo -en $COLOR_BLUE
  fi
  if [ -n "${PSHOST}" ]; then
    echo -en $PSHOST
  else
    echo -en `hostname`
  fi
  echo -en "\033[0m"
}

export PS1="\$(ps_hostname):\w\[\033[1;37m\]\$(parse_git_branch)\[\033[0;00m\] \u\$ "

# Add local ~/bin to PATH if it exists

if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# I like vim.
export EDITOR=vim
alias vi=vim
